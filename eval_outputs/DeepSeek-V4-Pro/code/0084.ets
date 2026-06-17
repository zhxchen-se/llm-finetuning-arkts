@Entry
@Component
struct Index {
  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(100)
        .height(100)
        .objectFit(ImageFit.Contain)
      Text('text')
        .fontSize(20)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}