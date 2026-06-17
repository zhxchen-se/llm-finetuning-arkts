@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HorizontalAlign.Center Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Text('The child elements below are centered horizontally within the container using HorizontalAlign.Center')
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 20 })
        .padding({ left: 20, right: 20 })

      // Container demonstrating HorizontalAlign.Center
      Column() {
        Text('Child 1')
          .width(150)
          .height(50)
          .fontSize(18)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFA500')
          .borderRadius(8)
          .margin({ bottom: 10 })

        Text('Child 2 - Wider')
          .width(250)
          .height(50)
          .fontSize(18)
          .textAlign(TextAlign.Center)
          .backgroundColor('#4169E1')
          .fontColor(Color.White)
          .borderRadius(8)
          .margin({ bottom: 10 })

        Text('Child 3 - Narrow')
          .width(100)
          .height(50)
          .fontSize(18)
          .textAlign(TextAlign.Center)
          .backgroundColor('#2E8B57')
          .fontColor(Color.White)
          .borderRadius(8)
      }
      .width('100%')
      .height(300)
      .alignItems(HorizontalAlign.Center) // Centering children horizontally
      .backgroundColor('#F0F0F0')
      .border({ width: 2, color: '#CCCCCC', radius: 12 })
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}