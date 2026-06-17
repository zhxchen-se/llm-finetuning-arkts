@Entry
@Component
struct Index {
  @State selectedValue: number = 50

  build() {
    Column() {
      Text(`Selected Value: ${this.selectedValue}`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })

      Slider({
        value: this.selectedValue,
        min: 0,
        max: 100,
        step: 1
      })
      .onChange((value: number) => {
        this.selectedValue = value
      })
      .width('85%')

      Progress({
        value: this.selectedValue,
        total: 100
      })
      .width('85%')
      .height(16)
      .margin({ top: 32 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}