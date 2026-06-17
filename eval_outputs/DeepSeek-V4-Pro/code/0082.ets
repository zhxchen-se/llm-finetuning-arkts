import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('Go to Second Page')
        .fontSize(20)
        .margin({ top: 20 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/SecondPage'
          }).catch((err: Error) => {
            console.error(`Navigation failed: ${err.message}`);
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}