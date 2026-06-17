import { @Entry, @Component, @State } from '@ohos/arkui';

@Entry
@Component
struct Index {
  @State posX: number = 100;
  @State posY: number = 100;
  @State startPosX: number = 0;
  @State startPosY: number = 0;

  build() {
    Stack() {
      Box() {
        Text('Drag Me')
          .fontColor('#FFFFFF')
          .fontSize(16)
      }
      .width(120)
      .height(120)
      .backgroundColor('#007DFF')
      .borderRadius(10)
      .position({ x: this.posX, y: this.posY })
      .gesture(
        PanGesture()
          .onActionStart((event) => {
            this.startPosX = this.posX;
            this.startPosY = this.posY;
          })
          .onActionUpdate((event) => {
            this.posX = this.startPosX + event.offsetX;
            this.posY = this.startPosY + event.offsetY;
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}