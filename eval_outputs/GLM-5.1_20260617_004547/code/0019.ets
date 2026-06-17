import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Show Toast Message')
        .fontSize(20)
        .margin(10)
        .onClick(() => {
          promptAction.showToast({
            message: 'This is a toast message!',
            duration: 2000,
            bottom: 100
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}