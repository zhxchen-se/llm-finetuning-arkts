@Entry
@Component
struct Index {
  @State scale: number = 1

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(120)
        .height(120)
        .objectFit(ImageFit.Contain)
        .scale({ x: this.scale, y: this.scale })
        .gesture(
          PinchGesture()
            .onAction((event) => {
              this.scale = event.scale
            })
        )
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}