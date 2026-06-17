@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HorizontalAlign.End Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      Row() {
        Text('Item 1')
          .fontSize(18)
          .padding(10)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .borderRadius(5)

        Text('Item 2')
          .fontSize(18)
          .padding(10)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .borderRadius(5)
          .margin({ left: 10 })
      }
      .width('100%')
      .horizontalAlign(HorizontalAlign.End)
      .backgroundColor('#E8E8E8')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}