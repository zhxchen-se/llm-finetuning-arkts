@Entry
@Component
struct Index {
  @State sliderValue: number = 50

  build() {
    Column() {
      Text(`Selected Value: ${this.sliderValue}`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Slider({ value: this.sliderValue, min: 0, max: 100 })
        .onChange((value: number) => {
          this.sliderValue = value
        })
        .width('80%')
        .margin({ bottom: 40 })

      Progress({ value: this.sliderValue, total: 100 })
        .width('80%')
        .height(20)
        .color('#007DFF')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}