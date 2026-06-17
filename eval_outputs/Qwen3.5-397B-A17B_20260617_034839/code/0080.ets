@Entry
@Component
struct Index {
  @State textColor: Color = Color.Yellow;

  build() {
    Column() {
      Text('hello world')
        .fontSize(50)
        .fontColor(this.textColor)

      Button('Change Color')
        .margin({ top: 20 })
        .onClick(() => {
          this.textColor = Color.Green;
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}