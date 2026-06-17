@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Item 1')
        .fontSize(20)
        .margin(10)
      Text('Item 2')
        .fontSize(20)
        .margin(10)
      Button('Click')
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.End)
  }
}