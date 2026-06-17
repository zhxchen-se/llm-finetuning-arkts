@Entry
@Component
struct Index {
  build() {
    Column() {
      Circle()
        .width(120)
        .height(120)
        .fill('#FFFF00')

      Text('shape circle')
        .fontSize(24)
        .fontColor('#000000')
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}