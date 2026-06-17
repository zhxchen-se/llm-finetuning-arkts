interface Task {
  id: number;
  content: string;
  isCompleted: boolean;
}

@Entry
@Component
struct Index {
  @State tasks: Task[] = [];
  @State inputValue: string = '';
  @State nextId: number = 1;

  build() {
    Column() {
      // Header
      Row() {
        Text('To-Do List')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Text(`Remaining: ${this.getRemainingCount()}`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(20)
      .justifyContent(FlexAlign.SpaceBetween)

      // Input Area
      Row() {
        TextInput({ placeholder: 'Add a new task...' })
          .layoutWeight(1)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.inputValue = value;
          })
        Button('Add')
          .onClick(() => {
            this.addTask();
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 20 })

      // Task List
      List() {
        ForEach(this.tasks, (task: Task) => {
          ListItem() {
            Row() {
              Checkbox({ name: task.id.toString() })
                .select(task.isCompleted)
                .onChange((isComplete: boolean) => {
                  this.toggleTask(task.id, isComplete);
                })
                .width(24)
                .height(24)
                .margin({ right: 10 })

              Text(task.content)
                .layoutWeight(1)
                .fontColor(task.isCompleted ? '#999999' : '#000000')
                .decoration(task.isCompleted ? TextDecoration.LineThrough : TextDecoration.None)
                .fontSize(16)

              Button('Delete')
                .type(ButtonType.Capsule)
                .backgroundColor('#FF5555')
                .fontSize(12)
                .padding({ left: 10, right: 10 })
                .onClick(() => {
                  this.deleteTask(task.id);
                })
            }
            .width('100%')
            .padding(10)
            .alignItems(VerticalAlign.Center)
          }
        }, (task: Task) => task.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  getRemainingCount(): number {
    return this.tasks.filter(task => !task.isCompleted).length;
  }

  addTask() {
    if (this.inputValue.trim().length > 0) {
      const newTask: Task = {
        id: this.nextId,
        content: this.inputValue.trim(),
        isCompleted: false
      };
      this.tasks = [...this.tasks, newTask];
      this.inputValue = '';
      this.nextId++;
    }
  }

  toggleTask(id: number, isComplete: boolean) {
    this.tasks = this.tasks.map(task =>
      task.id === id ? { ...task, isCompleted: isComplete } : task
    );
  }

  deleteTask(id: number) {
    this.tasks = this.tasks.filter(task => task.id !== id);
  }
}