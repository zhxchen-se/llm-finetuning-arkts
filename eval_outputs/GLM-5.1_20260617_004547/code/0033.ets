@Observed
class TaskItem {
  id: number = 0
  text: string = ''
  isCompleted: boolean = false
}

@Component
struct TaskItemComponent {
  @ObjectLink task: TaskItem
  onDelete: () => void = () => {}

  build() {
    Row() {
      Checkbox()
        .select(this.task.isCompleted)
        .onChange((value: boolean) => {
          this.task.isCompleted = value
        })
      Text(this.task.text)
        .layoutWeight(1)
        .margin({ left: 12, right: 12 })
        .decoration({ type: this.task.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
        .fontColor(this.task.isCompleted ? '#888888' : '#000000')
      Button('Delete')
        .backgroundColor('#ff4444')
        .fontColor(Color.White)
        .height(32)
        .onClick(() => this.onDelete())
    }
    .width('100%')
    .padding(12)
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}

@Entry
@Component
struct Index {
  @State tasks: TaskItem[] = []
  @State inputText: string = ''

  build() {
    Column() {
      Text('To-Do List')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Text(`Remaining tasks: ${this.tasks.filter(t => !t.isCompleted).length}`)
        .fontSize(18)
        .fontColor('#333333')
        .margin({ bottom: 20 })

      Row() {
        TextInput({ placeholder: 'Enter a new task', text: this.inputText })
          .onChange((value: string) => {
            this.inputText = value
          })
          .layoutWeight(1)
          .height(40)
          .margin({ right: 8 })

        Button('Add')
          .height(40)
          .onClick(() => {
            if (this.inputText.trim()) {
              const newTask = new TaskItem()
              newTask.id = Date.now()
              newTask.text = this.inputText.trim()
              newTask.isCompleted = false
              this.tasks = [...this.tasks, newTask]
              this.inputText = ''
            }
          })
      }
      .width('100%')
      .margin({ bottom: 20 })

      List({ space: 10 }) {
        ForEach(this.tasks, (task: TaskItem) => {
          ListItem() {
            TaskItemComponent({ task: task, onDelete: () => {
              this.tasks = this.tasks.filter(t => t.id !== task.id)
            }})
          }
        }, (task: TaskItem) => task.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#f5f5f5')
  }
}