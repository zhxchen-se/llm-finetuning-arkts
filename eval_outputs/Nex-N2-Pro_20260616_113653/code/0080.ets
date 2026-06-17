@Entry
@Component
struct Index {
  @State textColor: string = '#FFFF00';

  build() {
    Column() {
      Text('Hello World')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)

      Button('Change Color')
        .onClick(() => {
          this.textColor = '#00FF00';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}