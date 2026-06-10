import { PanDirection } from '@ohos.arkui.advanced.Gesture';

@Entry
@Component
struct Index {
  @State translateX: number = 0;
  @State translateY: number = 0;
  private startX: number = 0;
  private startY: number = 0;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Stack() {
        Text('Drag me')
          .fontSize(20)
          .fontColor(Color.White)
      }
      .width(120)
      .height(120)
      .backgroundColor('#007DFF')
      .borderRadius(16)
      .shadow({ radius: 10, color: '#40000000', offsetX: 2, offsetY: 2 })
      .translate({ x: this.translateX, y: this.translateY })
      .gesture(
        PanGesture({ direction: PanDirection.All })
          .onActionStart((event: GestureEvent) => {
            this.startX = this.translateX;
            this.startY = this.translateY;
          })
          .onActionUpdate((event: GestureEvent) => {
            this.translateX = this.startX + event.offsetX;
            this.translateY = this.startY + event.offsetY;
          })
          .onActionEnd(() => {
            // position already updated
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}