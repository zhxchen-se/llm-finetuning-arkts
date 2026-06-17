@Entry
@Component
struct Index {
  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  private readonly MIN_SCALE: number = 0.5;
  private readonly MAX_SCALE: number = 4;
  private readonly STEP: number = 0.5;

  private zoomIn() {
    let newScale = this.scaleValue + this.STEP;
    this.scaleValue = newScale > this.MAX_SCALE ? this.MAX_SCALE : newScale;
  }

  private zoomOut() {
    let newScale = this.scaleValue - this.STEP;
    this.scaleValue = newScale < this.MIN_SCALE ? this.MIN_SCALE : newScale;
  }

  private resetZoom() {
    this.scaleValue = 1;
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 30 }) {
        Image($r('app.media.icon'))
          .width(200)
          .height(200)
          .objectFit(ImageFit.Contain)
          .scale({
            x: this.scaleValue,
            y: this.scaleValue,
            centerX: '50%',
            centerY: '50%'
          })
          .gesture(
            PinchGesture({ fingers: 2 })
              .onActionStart(() => {
                this.pinchValue = this.scaleValue;
              })
              .onActionUpdate((event) => {
                let newScale = this.pinchValue * event.scale;
                if (newScale < this.MIN_SCALE) {
                  newScale = this.MIN_SCALE;
                } else if (newScale > this.MAX_SCALE) {
                  newScale = this.MAX_SCALE;
                }
                this.scaleValue = newScale;
              })
          )

        Text(`Scale: ${this.scaleValue.toFixed(2)}x`)
          .fontSize(16)
          .fontColor('#666666')

        Row({ space: 20 }) {
          Button('Zoom Out')
            .onClick(() => this.zoomOut())

          Button('Reset')
            .onClick(() => this.resetZoom())

          Button('Zoom In')
            .onClick(() => this.zoomIn())
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}