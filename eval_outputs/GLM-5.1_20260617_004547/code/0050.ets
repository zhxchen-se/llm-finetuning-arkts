@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Right Aligned Item 1')
        .width('60%')
        .height(50)
        .backgroundColor(Color.Orange)
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .margin({ bottom: 10 })

      Text('Right Aligned Item 2')
        .width('40%')
        .height(50)
        .backgroundColor(Color.Pink)
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .margin({ bottom: 10 })

      Button('Right Aligned Button')
        .width('50%')
        .height(50)
        .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .horizontalAlign(HorizontalAlign.End)
  }
}