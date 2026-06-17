@Entry
@Component
struct Index {
  @State count: number = 10

  build() {
    Column({ space: 20 }) {
      Text('Countdown')
        .fontSize(24)
        .fontColor('#666666')

      Text(`${this.count}`)
        .fontSize(80)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.count === 0 ? '#FF0000' : '#000000')

      Row({ space: 20 }) {
        Button('Decrement')
          .fontSize(20)
          .width(150)
          .height(50)
          .onClick(() => {
            if (this.count > 0) {
              this.count--
            }
          })
          .enabled(this.count > 0)
          .backgroundColor(this.count > 0 ? '#007DFF' : '#CCCCCC')

        Button('Reset')
          .fontSize(20)
          .width(150)
          .height(50)
          .onClick(() => {
            this.count = 10
          })
          .backgroundColor('#FF5722')
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}