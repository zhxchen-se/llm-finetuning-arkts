@Entry
@Component
struct Index {
  private animatorController: ImageAnimatorController = new ImageAnimatorController()

  build() {
    Column({ space: 30 }) {
      Text('Animation Player')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      ImageAnimator()
        .images([
          { src: $r('app.media.icon') },
          { src: $r('app.media.icon') },
          { src: $r('app.media.icon') },
          { src: $r('app.media.icon') }
        ])
        .duration(2000)
        .autoPlay(false)
        .fixedSize(false)
        .controller(this.animatorController)
        .width(200)
        .height(200)
        .backgroundColor(Color.Orange)
        .borderRadius(16)

      Row({ space: 20 }) {
        Button('Start')
          .width(100)
          .height(40)
          .onClick(() => {
            this.animatorController.start()
          })

        Button('Pause')
          .width(100)
          .height(40)
          .onClick(() => {
            this.animatorController.pause()
          })

        Button('Stop')
          .width(100)
          .height(40)
          .onClick(() => {
            this.animatorController.stop()
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}