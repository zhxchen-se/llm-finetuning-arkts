@Entry
@Component
struct Index {
  @State items: string[] = [
    'Item 1', 'Item 2', 'Item 3', 'Item 4',
    'Item 5', 'Item 6', 'Item 7', 'Item 8',
    'Item 9', 'Item 10'
  ]

  build() {
    Column() {
      Text('Horizontal Scroll List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20, top: 20 })

      List({ space: 10 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Column() {
              Text(item)
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .width(150)
            .height(100)
            .backgroundColor('#007DFF')
            .borderRadius(12)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        }, (item: string, index: number) => item + index.toString())
      }
      .horizontal(true)
      .width('100%')
      .height(120)
      .padding({ left: 15, right: 15 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}