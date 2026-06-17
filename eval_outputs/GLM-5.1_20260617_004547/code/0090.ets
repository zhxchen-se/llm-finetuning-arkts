@Entry
@Component
struct Index {
  @State rotateAngle: number = 0

  build() {
    Column({ space: 30 }) {
      Image($r('app.media.icon'))
        .width(200)
        .height(200)
        .objectFit(ImageFit.Contain)
        .rotate({ angle: this.rotateAngle })
        .animation({ duration: 300, curve: Curve.EaseInOut })

      Button('Rotate Left')
        .width(150)
        .height(50)
        .fontSize(18)
        .onClick(() => {
          this.rotateAngle -= 90
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}