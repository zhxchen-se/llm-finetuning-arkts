@Entry
@Component
struct CircleTextExample {
  build() {
    Column() {
      // Yellow circle in center
      Row() {
        Circle({ width: 100, height: 100 })
          .fill(Color.Yellow)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('50%')
      .justifyContent(FlexAlign.Center)

      // Text underneath the circle
      Text('shape circle')
        .fontSize(20)
        .margin({ top: 20 })
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}