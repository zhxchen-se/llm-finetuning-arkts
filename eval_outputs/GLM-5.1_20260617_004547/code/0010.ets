@Entry
@Component
struct Index {
  @State allNames: string[] = [
    'Alice', 'Aaron', 'Amy', 'Adam', 'Alex',
    'Bob', 'Bella', 'Ben', 'Bill', 'Brian',
    'Charlie', 'Chloe', 'Chris', 'Claire', 'Carol',
    'David', 'Diana', 'Dan', 'Derek', 'Dean',
    'Eve', 'Emily', 'Emma', 'Ethan', 'Evan',
    'Frank', 'Fiona', 'Fred', 'Faith', 'Flora',
    'Grace', 'George', 'Gina', 'Gary', 'Gloria',
    'Henry', 'Hannah', 'Helen', 'Harry', 'Heather',
    'Ivy', 'Isaac', 'Ian', 'Iris', 'Ivan',
    'Jack', 'Julia', 'James', 'Jade', 'Jenny'
  ]
  @State filteredNames: string[] = []
  @State filterText: string = ''

  aboutToAppear() {
    this.applyFilter()
  }

  applyFilter() {
    if (this.filterText === '') {
      this.filteredNames = [...this.allNames]
    } else {
      this.filteredNames = this.allNames.filter(name =>
        name.toLowerCase().startsWith(this.filterText.toLowerCase())
      )
    }
  }

  build() {
    Column() {
      Text('Name Filter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      TextInput({ placeholder: 'Type a letter to filter...', text: this.filterText })
        .width('90%')
        .height(45)
        .fontSize(18)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.filterText = value
          this.applyFilter()
        })

      Scroll() {
        Row({ space: 8 }) {
          Button('All')
            .fontSize(14)
            .height(32)
            .backgroundColor(this.filterText === '' ? '#007DFF' : '#666666')
            .onClick(() => {
              this.filterText = ''
              this.applyFilter()
            })

          ForEach(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'], (letter: string) => {
            Button(letter)
              .fontSize(14)
              .height(32)
              .backgroundColor(this.filterText.toUpperCase() === letter ? '#007DFF' : '#666666')
              .onClick(() => {
                this.filterText = letter
                this.applyFilter()
              })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('90%')
      .margin({ bottom: 16 })

      Text(`Showing ${this.filteredNames.length} of ${this.allNames.length} names`)
        .fontSize(14)
        .fontColor('#888888')
        .margin({ bottom: 8 })

      List({ space: 8 }) {
        ForEach(this.filteredNames, (name: string) => {
          ListItem() {
            Row() {
              Text(name)
                .fontSize(18)
                .fontColor('#333333')
            }
            .width('100%')
            .padding(12)
            .borderRadius(8)
            .backgroundColor('#F1F3F5')
          }
        }, (name: string) => name)
      }
      .width('90%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 20 })
    .backgroundColor('#FFFFFF')
  }
}