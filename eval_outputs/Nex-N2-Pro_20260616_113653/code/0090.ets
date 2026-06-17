@Entry
@Component
struct Index {
  @State angle: number = 0

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(200)
        .height(200)
        .rotate(`${this.angle}deg`)

      Button('Rotate 90 degrees left')
        .margin({ top: 40 })
        .onClick(() => {
          this.angle -= 90
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}