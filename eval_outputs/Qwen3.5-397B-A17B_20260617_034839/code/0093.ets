import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State currentPage: number = 1;

  build() {
    Column() {
      if (this.currentPage === 1) {
        Column() {
          Text('Page 1')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          Button('Go to Page 2')
            .onClick(() => {
              this.currentPage = 2;
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#007DFF')
        .transition(TransitionEffect.Slide({ direction: SlideDirection.Left, duration: 400 }))
      } else {
        Column() {
          Text('Page 2')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          Button('Back to Page 1')
            .onClick(() => {
              this.currentPage = 1;
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#00B96B')
        .transition(TransitionEffect.Slide({ direction: SlideDirection.Right, duration: 400 }))
      }
    }
    .width('100%')
    .height('100%')
  }
}