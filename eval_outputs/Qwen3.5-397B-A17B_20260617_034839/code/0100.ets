@Entry
@Component
struct Index {
  build() {
    Column() {
      Circle(50)
        .fill('#FFFF00')
      Text('shape circle')
        .fontSize(20)
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}