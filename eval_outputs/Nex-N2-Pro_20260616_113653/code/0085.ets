@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State offsetX: number = 0

  private readonly imageWidth: number = 240
  private readonly swipeThreshold: number = 50
  private readonly images = [
    $r('app.media.icon'),
    $r('app.media.icon')
  ]

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.images[0])
            .width(this.imageWidth)
            .height(this.imageWidth)
            .objectFit(ImageFit.Contain)

          Image(this.images[1])
            .width(this.imageWidth)
            .height(this.imageWidth)
            .objectFit(ImageFit.Contain)
        }
        .width(this.imageWidth * 2)
        .height(this.imageWidth)
        .translate({ x: this.offsetX, y: 0 })
        .animation({ duration: 200, curve: Curve.EaseOut })
        .gesture(
          PanGesture()
            .onActionUpdate((event) => {
              this.offsetX = event.offsetX
            })
            .onActionEnd((event) => {
              if (this.currentIndex === 0 && event.offsetX < -this.swipeThreshold) {
                this.currentIndex = 1
                this.offsetX = -this.imageWidth
              } else if (this.currentIndex === 1 && event.offsetX > this.swipeThreshold) {
                this.currentIndex = 0
                this.offsetX = 0
              } else {
                this.offsetX = this.currentIndex === 0 ? 0 : -this.imageWidth
              }
            })
        )
      }
      .width(this.imageWidth)
      .height(this.imageWidth)
      .clip(true)

      Text(`Image ${this.currentIndex + 1}/${this.images.length}`)
        .fontSize(20)
        .margin({ top: 24 })

      Text('Swipe left for next image, right for previous image')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}