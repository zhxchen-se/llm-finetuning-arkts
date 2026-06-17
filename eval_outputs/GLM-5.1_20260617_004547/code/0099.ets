@Entry
@Component
struct Index {
  @State sliderValue: number = 50

  build() {
    Column() {
      Text(`Current Value: ${this.sliderValue.toFixed(0)}`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      Slider({
        value: this.sliderValue,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('80%')
        .blockColor('#007DFF')
        .trackColor('#CCCCCC')
        .selectedColor('#007DFF')
        .showSteps(false)
        .showTips(true)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}