import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Welcome to HarmonyOS')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Go to Next Page')
        .width('80%')
        .height(50)
        .backgroundColor('#007DFF')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/SecondPage'
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}