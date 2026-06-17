import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Page Navigation Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Go to Another Page')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/SecondPage'
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}