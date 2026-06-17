@Entry
@Component
struct Index {
  build() {
    Column() {
      Swiper() {
        Image($r('app.media.icon'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Contain)

        Image($r('app.media.icon'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Contain)
      }
      .width('100%')
      .height('100%')
      .indicator(true)
      .autoPlay(false)
      .loop(true)
    }
    .width('100%')
    .height('100%')
  }
}