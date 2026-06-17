@Entry
@Component
struct Index {
  private stringItems: string[] = [
    'HarmonyOS',
    'ArkTS Development',
    'Sliding Animation',
    'One by One Display',
    'User Interface'
  ];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column({ space: 20 }) {
      Text('String Items Slider')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      Swiper(this.swiperController) {
        ForEach(this.stringItems, (item: string, index?: number) => {
          Column() {
            Text(item)
              .fontSize(28)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(16)
          .backgroundColor('#007DFF')
          .shadow({ radius: 10, color: '#007DFF', offsetY: 6 })
        })
      }
      .loop(true)
      .autoPlay(false)
      .indicator(
        new DotIndicator()
          .itemWidth(8)
          .itemHeight(8)
          .selectedItemWidth(16)
          .selectedItemHeight(8)
          .color('#CCCCCC')
          .selectedColor('#007DFF')
      )
      .duration(600)
      .curve(Curve.FastOutSlowIn)
      .margin({ top: 20 })

      Row({ space: 20 }) {
        Button('Previous')
          .fontSize(18)
          .width('40%')
          .height(50)
          .backgroundColor('#E8E8E8')
          .fontColor('#333333')
          .borderRadius(25)
          .onClick(() => {
            this.swiperController.showPrevious();
          })

        Button('Next')
          .fontSize(18)
          .width('40%')
          .height(50)
          .borderRadius(25)
          .onClick(() => {
            this.swiperController.showNext();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 30 })
      .padding({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
    .backgroundColor('#F1F3F5')
  }
}