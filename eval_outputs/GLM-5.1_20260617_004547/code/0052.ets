@Entry
@Component
struct Index {
  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
      Text('Element 1')
        .width('80%')
        .height(80)
        .fontSize(20)
        .fontColor(Color.White)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .margin({ top: 20 })

      Text('Element 2')
        .width('80%')
        .height(80)
        .fontSize(20)
        .fontColor(Color.White)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .margin({ top: 20 })

      Text('Element 3')
        .width('80%')
        .height(80)
        .fontSize(20)
        .fontColor(Color.White)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
        .borderRadius(8)
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}