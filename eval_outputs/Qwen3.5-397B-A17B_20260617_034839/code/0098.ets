@Entry
@Component
struct Index {
  @State listData: Array<string> = []

  aboutToAppear() {
    for (let i = 0; i < 100; i++) {
      this.listData.push(`Item ${i + 1}`)
    }
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.listData, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .padding(15)
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .fontSize(16)
              .fontColor('#333333')
              .shadow({ radius: 2, color: '#10000000', offsetX: 0, offsetY: 2 })
          }
        }, (item: string) => item)
      }
      .width('100%')
      .height('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}