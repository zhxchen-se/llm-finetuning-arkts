// entry/src/main/ets/pages/Index.ets
@Entry
@Component
struct Index {
  @State tasks: Array<{ id: number, text: string, completed: boolean }> = [];
  @State newTaskText: string = '';
  private nextId: number = 0;

  build() {
    Column() {
      // Header
      Text('To-Do List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
        .textAlign(TextAlign.Center)
        .width('100%')

      // Input area
      Row() {
        TextInput({ placeholder: 'Enter a new task...', text: this.newTaskText })
          .onChange((value: string) => {
            this.newTaskText = value;
          })
          .layoutWeight(1)
          .margin({ right: 8 })
        Button('Add')
          .onClick(() => {
            if (this.newTaskText.trim() !== '') {
              this.tasks.push({
                id: this.nextId++,
                text: this.newTaskText.trim(),
                completed: false
              });
              this.newTaskText = '';
            }
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 16 })

      // Remaining tasks counter
      Text(`Remaining: ${this.tasks.filter(t => !t.completed).length}`)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 8 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // Task list
      List() {
        ForEach(this.tasks, (task: { id: number, text: string, completed: boolean }, index: number) => {
          ListItem() {
            Row() {
              Checkbox({ name: `task_${task.id}`, group: 'tasks' })
                .select(task.completed)
                .onChange((value: boolean) => {
                  task.completed = value;
                  // Force state update by reassigning the array reference
                  this.tasks = [...this.tasks];
                })
                .margin({ right: 8 })

              Text(task.text)
                .fontSize(16)
                .decoration({ type: task.completed ? TextDecorationType.LineThrough : TextDecorationType.None })
                .fontColor(task.completed ? '#999999' : '#000000')
                .layoutWeight(1)

              Button('Delete')
                .fontSize(14)
                .fontColor(Color.Red)
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  this.tasks.splice(index, 1);
                  this.tasks = [...this.tasks]; // trigger update
                })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .alignItems(VerticalAlign.Center)
          }
        }, (task: { id: number }) => task.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 0.5, color: '#e0e0e0' })
    }
    .width('100%')
    .height('100%')
    .padding({ top: 32, bottom: 16 })
    .backgroundColor('#f5f5f5')
  }
}