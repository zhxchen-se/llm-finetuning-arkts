@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HorizontalAlign.Center Demo')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ bottom: 8 })

      Text('The children below are centered horizontally inside the container.')
        .fontSize(15)
        .fontColor('#4B5563')
        .margin({ bottom: 28 })

      Column() {
        Text('Child 1')
          .width(140)
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor('#FFFFFF')
          .backgroundColor('#3B82F6')
          .borderRadius(12)

        Text('Child 2')
          .width(190)
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor('#FFFFFF')
          .backgroundColor('#10B981')
          .borderRadius(12)

        Text('Child 3')
          .width(240)
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor('#FFFFFF')
          .backgroundColor('#F97316')
          .borderRadius(12)
      }
        .width('90%')
        .height(260)
        .padding(24)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#F3F4F6')
        .borderWidth(2)
        .borderColor('#93C5FD')
        .borderRadius(18)

      Text('.alignItems(HorizontalAlign.Center)')
        .fontSize(14)
        .fontColor('#6B7280')
        .margin({ top: 24 })
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
  }
}