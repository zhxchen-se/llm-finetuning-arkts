@Entry
@Component
struct Index {
  @State textColor: ResourceColor = Color.Yellow

  build() {
    Column() {
      Text('Hello World')
        .fontSize(30)
        .fontColor(this.textColor)
        .fontWeight(FontWeight.Bold)

      Button('Change Color')
        .margin({ top: 20 })
        .onClick(() => {
          this.textColor = Color.Green
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}