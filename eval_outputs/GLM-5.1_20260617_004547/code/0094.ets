@Entry
@Component
struct Index {
  @State positionX: number = 150
  @State positionY: number = 300
  private startX: number = 0
  private startY: number = 0

  build() {
    Stack() {
      Column() {
        Text('Drag Me')
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width(120)
      .height(120)
      .borderRadius(60)
      .backgroundColor('#007DFF')
      .justifyContent(FlexAlign.Center)
      .shadow({ radius: 20, color: '#888888', offsetX: 0, offsetY: 10 })
      .position({ x: this.positionX, y: this.positionY })
      .gesture(
        PanGesture()
          .onActionStart(() => {
            this.startX = this.positionX
            this.startY = this.positionY
          })
          .onAction((event: GestureEvent) => {
            this.positionX = this.startX + event.offsetX
            this.positionY = this.startY + event.offsetY
          })
          .onActionEnd(() => {
            // Drag completed
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}