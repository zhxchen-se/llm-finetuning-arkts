import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Page Transition Example')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      Text('Selected effect: SlideFromRight')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 8, bottom: 48 })

      Button('Open Second Page')
        .width('80%')
        .height(48)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/SecondPage',
            transition: {
              effect: router.RouterTransition.SlideFromRight
            }
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}