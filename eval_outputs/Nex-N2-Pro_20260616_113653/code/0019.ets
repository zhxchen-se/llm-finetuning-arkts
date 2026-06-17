import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Toast Example')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)

      Button('Show Toast')
        .margin({ top: 24 })
        .onClick(() => {
          promptAction.showToast({
            message: 'This is a toast message'
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}