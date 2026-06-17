@Entry
@Component
struct Index {
  @State searchText: string = ''
  @State allNames: Array<string> = []

  aboutToAppear() {
    const letters: string[] = ['A', 'B', 'C', 'D', 'E']
    for (let i = 0; i < 50; i++) {
      const letter = letters[i % 5]
      this.allNames.push(`${letter} Name ${i + 1}`)
    }
  }

  getFilteredNames(): Array<string> {
    if (!this.searchText) {
      return this.allNames
    }
    return this.allNames.filter((name) =>
      name.toLowerCase().startsWith(this.searchText.toLowerCase())
    )
  }

  build() {
    Column() {
      Row() {
        Text('Filter List')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 10 })

        TextInput({ placeholder: 'Type a letter (e.g., a)' })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.searchText = value
          })
          .padding(10)
          .backgroundColor('#F1F3F5')
          .borderRadius(8)
      }
      .width('100%')
      .padding(16)

      List() {
        ForEach(this.getFilteredNames(), (name: string) => {
          ListItem() {
            Row() {
              Text(name)
                .fontSize(16)
                .fontColor('#333333')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 8 })
            .shadow({ radius: 2, color: '#1A000000', offsetY: 2 })
          }
        }, (name: string) => name)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}