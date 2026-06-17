@Entry
@Component
struct Index {
  @State objectX: number = 100
  @State objectY: number = 180

  private startX: number = 0
  private startY: number = 0

  build() {
    Stack() {
      Text('Drag the blue object')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .position({ x: 24, y: 70 })

      Box() {
        Text('Drag')
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
      }
        .width(130)
        .height(130)
        .borderRadius(26)
        .backgroundColor('#0A59F7')
        .position({ x: this.objectX, y: this.objectY })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.startX = this.objectX - event.offsetX
              this.startY = this.objectY - event.offsetY
            })
            .onActionUpdate((event: GestureEvent) => {
              this.objectX = this.startX + event.offsetX
              this.objectY = this.startY + event.offsetY
            })
        )
    }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F7FB')
  }
}