@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private imageList: string[] = [
    'https://picsum.photos/600/400?random=1',
    'https://picsum.photos/600/400?random=2',
    'https://picsum.photos/600/400?random=3',
    'https://picsum.photos/600/400?random=4'
  ]

  build() {
    Column() {
      Swiper() {
        ForEach(this.imageList, (item: string) => {
          Image(item)
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .backgroundColor('#F5F5F5')
        }, (item: string) => item)
      }
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .loop(true)

      Row() {
        ForEach(this.imageList, (_, index: number) => {
          Circle()
            .width(8)
            .height(8)
            .backgroundColor(index === this.currentIndex ? '#007DFF' : '#CCCCCC')
            .margin({ left: 5, right: 5 })
        }, (_, index: number) => index.toString())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(10)
    }
    .width('100%')
    .height('100%')
  }
}