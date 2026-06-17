@Entry
@Component
struct Index {
  @State sliderValue: number = 0

  build() {
    Column() {
      Text(`Slider Value: ${this.sliderValue.toFixed(0)}`)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      Slider({
        value: this.sliderValue,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('85%')
        .onChange((value: number) => {
          this.sliderValue = value
        })
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
  }
}