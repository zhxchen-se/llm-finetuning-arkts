import router from '@ohos.router';

@Entry
@Component
struct Index {
  pageTransition() {
    PageTransitionEnter({ duration: 600, curve: Curve.EaseInOut })
      .slide(SlideEffect.Right)
      .opacity(0)
    PageTransitionExit({ duration: 600, curve: Curve.EaseInOut })
      .slide(SlideEffect.Left)
      .opacity(0)
  }

  build() {
    Column() {
      Text('Index Page')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Go to Second Page')
        .onClick(() => {
          router.pushUrl({ url: 'pages/Second' })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}