interface TodoItem {
  id: number
  title: string
  completed: boolean
}

@Entry
@Component
struct Index {
  @State todoText: string = ''
  @State todos: TodoItem[] = []
  @State remainingCount: number = 0
  nextId: number = 1

  addTask(): void {
    const title: string = this.todoText.trim()

    if (title.length === 0) {
      return
    }

    const newTodo: TodoItem = {
      id: this.nextId,
      title: title,
      completed: false
    }

    this.nextId += 1

    const newTodos: TodoItem[] = []
    for (let i: number = 0; i < this.todos.length; i++) {
      newTodos.push(this.todos[i])
    }
    newTodos.push(newTodo)

    this.todos = newTodos
    this.todoText = ''
    this.updateRemainingCount()
  }

  toggleTask(index: number): void {
    const newTodos: TodoItem[] = []

    for (let i: number = 0; i < this.todos.length; i++) {
      const currentTodo: TodoItem = this.todos[i]

      newTodos.push({
        id: currentTodo.id,
        title: currentTodo.title,
        completed: i === index ? !currentTodo.completed : currentTodo.completed
      })
    }

    this.todos = newTodos
    this.updateRemainingCount()
  }

  deleteTask(index: number): void {
    const newTodos: TodoItem[] = []

    for (let i: number = 0; i < this.todos.length; i++) {
      if (i !== index) {
        newTodos.push(this.todos[i])
      }
    }

    this.todos = newTodos
    this.updateRemainingCount()
  }

  updateRemainingCount(): void {
    let count: number = 0

    for (let i: number = 0; i < this.todos.length; i++) {
      if (!this.todos[i].completed) {
        count += 1
      }
    }

    this.remainingCount = count
  }

  build() {
    Column() {
      Text('To-Do List')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1f2937')
        .margin({ bottom: 16 })

      Row() {
        TextInput({ text: this.todoText, placeholder: 'Add a new task' })
          .onChange((value: string) => {
            this.todoText = value
          })
          .layoutWeight(1)
          .height(48)
          .padding({ left: 14, right: 14 })
          .backgroundColor(Color.White)
          .borderRadius(12)

        Button() {
          Text('Add')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .margin({ left: 8 })
        .height(48)
        .padding({ left: 18, right: 18 })
        .backgroundColor('#2563eb')
        .borderRadius(12)
        .onClick(() => {
          this.addTask()
        })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        Text(`Remaining tasks: ${this.remainingCount}`)
          .fontSize(18)
          .fontColor('#374151')

        Blank()

        Text(`Total: ${this.todos.length}`)
          .fontSize(16)
          .fontColor('#6b7280')
      }
      .width('100%')
      .padding({ left: 4, right: 4, top: 8, bottom: 8 })
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ bottom: 12 })

      if (this.todos.length === 0) {
        Text('No tasks yet. Add your first task!')
          .fontSize(16)
          .fontColor('#6b7280')
          .padding(16)
          .width('100%')
          .textAlign(TextAlign.Center)
      }

      List({ space: 8 }) {
        ForEach(this.todos, (todo: TodoItem, index: number) => {
          ListItem() {
            Row() {
              Checkbox({ name: 'task-' + todo.id, group: 'todos' })
                .select(todo.completed)
                .onChange(() => {
                  this.toggleTask(index)
                })

              Text(todo.title)
                .layoutWeight(1)
                .fontSize(18)
                .fontColor(todo.completed ? '#9ca3af' : '#111827')
                .decoration({
                  type: todo.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                })
                .margin({ left: 10, right: 10 })

              Button() {
                Text('Delete')
                  .fontSize(14)
                  .fontColor(Color.White)
              }
              .height(36)
              .padding({ left: 12, right: 12 })
              .backgroundColor('#ef4444')
              .borderRadius(10)
              .onClick(() => {
                this.deleteTask(index)
              })
            }
            .width('100%')
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
        }, (todo: TodoItem) => todo.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#f3f4f6')
  }
}