import { router } from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HorizontalAlign.Center Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 20 })

      Text('This text is centered horizontally.')
        .fontSize(16)
        .margin({ bottom: 20 })

      Button('Centered Button')
        .width('60%')
        .margin({ bottom: 20 })

      Row() {
        Text('Item 1')
          .width(80)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFD700')
          .borderRadius(8)
        Text('Item 2')
          .width(80)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor('#87CEEB')
          .borderRadius(8)
          .margin({ left: 10 })
        Text('Item 3')
          .width(80)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor('#90EE90')
          .borderRadius(8)
          .margin({ left: 10 })
      }
      .margin({ bottom: 20 })

      Image($r('app.media.startIcon'))
        .width(60)
        .height(60)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: 20 })

      Text('All children are centered horizontally within the Column.')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .width('80%')
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F5F5')
    .padding({ top: 20 })
  }
}