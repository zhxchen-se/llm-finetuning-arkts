@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('First item')
        .fontSize(24)
        .fontColor('#182431')
        .margin({ bottom: 16 })

      Text('Second item')
        .fontSize(24)
        .fontColor('#182431')
        .margin({ bottom: 16 })

      Text('Third item')
        .fontSize(24)
        .fontColor('#182431')
    }
    .width('100%')
    .height('100%')
    .padding(32)
    .backgroundColor('#F1F3F5')
    .alignItems(HorizontalAlign.End)
    .justifyContent(FlexAlign.Start)
  }
}