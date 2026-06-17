import { Image, Text, Column, FlexAlign, HorizontalAlign } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(120)
        .height(120)

      Text('text')
        .fontSize(20)
        .fontColor('#000000')
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}