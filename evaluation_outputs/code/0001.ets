import { display } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State scaleValue: number = 1;
  private minScale: number = 0.5;
  private maxScale: number = 3;

  build() {
    Column() {
      Stack() {
        Image($r('app.media.icon'))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .height('100%')
          .scale({ x: this.scaleValue, y: this.scaleValue })
          .gesture(
            PinchGesture({ fingers: 2 })
              .onActionUpdate((event: GestureEvent) => {
                this.scaleValue = Math.max(
                  this.minScale,
                  Math.min(this.maxScale, this.scaleValue * event.scale)
                );
              })
          )
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}