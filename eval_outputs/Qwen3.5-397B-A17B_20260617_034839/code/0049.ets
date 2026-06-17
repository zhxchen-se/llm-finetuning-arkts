import { HorizontalAlign, FontWeight } from '@ohos.base';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HorizontalAlign.Center Demonstration')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .textAlign(TextAlign.Center)

      Text('Container with alignItems(HorizontalAlign.Center)')
        .fontSize(14)
        .fontColor('#666')
        .margin({ bottom: 10 })

      Column() {
        Text('Child 1')
          .fontSize(18)
          .padding(15)
          .backgroundColor('#e6f7ff')
          .borderRadius(8)

        Button('Child 2 (Button)')
          .fontSize(18)
          .margin({ top: 20, bottom: 20 })
          .backgroundColor('#007dff')

        Text('Child 3')
          .fontSize(18)
          .padding(15)
          .backgroundColor('#e6f7ff')
          .borderRadius(8)
      }
      .width('100%')
      .height(350)
      .backgroundColor('#f5f5f5')
      .alignItems(HorizontalAlign.Center)
      .border({ width: 2, color: '#007dff', style: BorderStyle.Dashed })
      .padding(20)

      Text('All children above are centered horizontally within the dashed container.')
        .fontSize(14)
        .fontColor('#888')
        .margin({ top: 30 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(24)
  }
}