@Entry
@Component
struct Index {
  @State sliderValue: number = 0

  build() {
    Column({ space: 30 }) {
      Text('Slider & Progress Demo')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      Text(`Selected Value: ${this.sliderValue}`)
        .fontSize(24)
        .fontColor('#333333')

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
      .showTips(true)
      .onChange((value: number, mode: SliderChangeMode) => {
        this.sliderValue = Math.round(value)
      })

      Progress({ value: this.sliderValue, total: 100, type: ProgressType.Linear })
        .width('80%')
        .color('#007DFF')
        .style({ strokeWidth: 20 })

      Progress({ value: this.sliderValue, total: 100, type: ProgressType.Ring })
        .width(120)
        .height(120)
        .color('#FF9800')
        .style({ strokeWidth: 15 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F5F5F5')
    .padding(20)
  }
}