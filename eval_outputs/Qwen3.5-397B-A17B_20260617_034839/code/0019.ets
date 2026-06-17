import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Show Toast')
        .onClick(() => {
          promptAction.showToast({
            message: 'This is a toast message',
            duration: 2000
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}