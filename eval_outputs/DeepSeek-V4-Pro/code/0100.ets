@Entry
@Component
struct Index {
  build() {
    Column() {
      // Yellow circle
      View()
        .width(100)
        .height(100)
        .borderRadius(50)
        .backgroundColor(Color.Yellow)

      // Text underneath
      Text('shape circle')
        .fontSize(16)
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}