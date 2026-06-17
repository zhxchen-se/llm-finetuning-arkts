@Entry
@Component
struct Index {
  @State currentScale: number = 1
  private lastScale: number = 1
  private minScale: number = 0.5
  private maxScale: number = 5.0

  build() {
    Column() {
      Stack() {
        Image($r('app.media.icon'))
          .width(200)
          .height(200)
          .objectFit(ImageFit.Contain)
          .scale({ x: this.currentScale, y: this.currentScale })
          .gesture(
            GestureGroup(GestureMode.Exclusive,
              PinchGesture()
                .onActionStart(() => {
                  this.lastScale = this.currentScale
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.currentScale = this.lastScale * event.scale
                })
                .onActionEnd(() => {
                  if (this.currentScale < this.minScale) {
                    this.currentScale = this.minScale
                  } else if (this.currentScale > this.maxScale) {
                    this.currentScale = this.maxScale
                  }
                }),
              TapGesture({ count: 2 })
                .onAction(() => {
                  this.currentScale = 1
                })
            )
          )
      }
      .width('100%')
      .layoutWeight(1)

      Row({ space: 20 }) {
        Button('Zoom Out')
          .onClick(() => {
            this.currentScale = Math.max(this.minScale, this.currentScale - 0.2)
          })

        Button('Reset')
          .onClick(() => {
            this.currentScale = 1
          })

        Button('Zoom In')
          .onClick(() => {
            this.currentScale = Math.min(this.maxScale, this.currentScale + 0.2)
          })
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}