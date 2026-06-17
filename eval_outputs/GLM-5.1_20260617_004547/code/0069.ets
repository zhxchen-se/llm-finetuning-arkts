@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private images: string[] = [
    'https://picsum.photos/seed/harm1/400/600',
    'https://picsum.photos/seed/harm2/400/600',
    'https://picsum.photos/seed/harm3/400/600',
    'https://picsum.photos/seed/harm4/400/600',
    'https://picsum.photos/seed/harm5/400/600'
  ]

  build() {
    Column() {
      Swiper() {
        ForEach(this.images, (item: string, index?: number) => {
          Image(item)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(16)
        }, (item: string, index?: number) => index?.toString() || item)
      }
      .index(this.currentIndex)
      .autoPlay(false)
      .indicator(false)
      .loop(false)
      .duration(300)
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .layoutWeight(1)
      .margin({ top: 20, left: 16, right: 16 })

      Row() {
        ForEach(this.images, (item: string, index?: number) => {
          Row()
            .width(this.currentIndex === index ? 24 : 8)
            .height(8)
            .borderRadius(4)
            .backgroundColor(this.currentIndex === index ? '#007DFF' : '#CCCCCC')
            .animation({ duration: 300, curve: Curve.EaseInOut })
            .margin({ left: 4, right: 4 })
            .onClick(() => {
              this.currentIndex = index!
            })
        }, (item: string, index?: number) => index?.toString() || item)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}