@Entry
@Component
struct Index {
  @State bgColor: ResourceColor = Color.Blue

  build() {
    Column({ space: 20 }) {
      Text('Hello HarmonyOS')
        .width('80%')
        .height(100)
        .textAlign(TextAlign.Center)
        .fontSize(24)
        .fontColor(Color.White)
        .backgroundColor(this.bgColor)
        .borderRadius(10)

      Button('Change Background Color')
        .width('80%')
        .height(50)
        .fontSize(18)
        .onClick(() => {
          if (this.bgColor === Color.Blue) {
            this.bgColor = Color.Orange
          } else if (this.bgColor === Color.Orange) {
            this.bgColor = Color.Green
          } else {
            this.bgColor = Color.Blue
          }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}