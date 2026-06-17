@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private stringItems: string[] = ['Welcome', 'To', 'HarmonyOS', 'ArkTS', 'Development']

  build() {
    Column() {
      Swiper({
        index: this.currentIndex,
        autoPlay: true,
        interval: 2000,
        loop: true,
        curve: Curve.EaseInOut
      }) {
        ForEach(this.stringItems, (item: string) => {
          Column() {
            Text(item)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#007DFF')
          .borderRadius(12)
        }, (item: string) => item)
      }
      .width('85%')
      .height(240)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row() {
        ForEach(this.stringItems, (_, index: number) => {
          Column() {
          }
          .width(10)
          .height(10)
          .backgroundColor(this.currentIndex === index ? '#007DFF' : '#E0E0E0')
          .borderRadius(5)
          .margin({ left: 5, right: 5 })
        })
      }
      .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}