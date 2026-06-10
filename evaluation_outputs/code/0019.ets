import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Show Toast')
        .onClick(() => {
          promptAction.showToast({
            message: 'Hello, this is a toast!',
            duration: 2000,
            bottom: '50%'
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}