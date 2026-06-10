import { FlexAlign, FlexDirection, ItemAlign } from '@ohos.arkui.UIContext';

@Entry
@Component
struct Index {
  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      Text('First element')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
      Text('Second element')
        .fontSize(20)
        .margin({ bottom: 10 })
      Text('Third element')
        .fontSize(20)
        .margin({ bottom: 10 })
      Button('A button')
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}