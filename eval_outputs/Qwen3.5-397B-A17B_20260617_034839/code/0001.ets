@Entry
@Component
struct Index {
  @State scale: number = 1.0
  private baseScale: number = 1.0

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(200)
        .height(200)
        .scale({ x: this.scale, y: this.scale })
        .gesture(
          PinchGesture()
            .onAction((event: PinchGestureEvent) => {
              let newScale = this.baseScale * event.scale
              if (newScale < 0.5) {
                newScale = 0.5
              }
              if (newScale > 5.0) {
                newScale = 5.0
              }
              this.scale = newScale
            })
            .onEnd(() => {
              this.baseScale = this.scale
            })
        )
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}