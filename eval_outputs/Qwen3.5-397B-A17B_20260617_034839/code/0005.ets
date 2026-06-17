@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private controller: SwiperController = new SwiperController()
  private imageList: string[] = [
    'https://placehold.co/600x400/png?text=Image+1',
    'https://placehold.co/600x400/png?text=Image+2',
    'https://placehold.co/600x400/png?text=Image+3'
  ]

  build() {
    Column() {
      Swiper() {
        ForEach(this.imageList, (item, index) => {
          Image(item)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .borderRadius(12)
        }, (item, index) => index.toString())
      }
      .controller(this.controller)
      .width('100%')
      .height(250)
      .loop(true)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row() {
        ForEach(this.imageList, (item, index) => {
          Path()
            .commands("M 5 0 L 10 10 L 0 10 Z")
            .fillColor(this.currentIndex === index ? '#007DFF' : '#CCCCCC')
            .width(10)
            .height(10)
            .margin({ left: 5, right: 5 })
            .onClick(() => {
              this.controller.toIndex(index)
              this.currentIndex = index
            })
        }, (item, index) => index.toString())
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}