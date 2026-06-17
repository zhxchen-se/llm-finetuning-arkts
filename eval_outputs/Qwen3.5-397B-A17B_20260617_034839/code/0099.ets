@Entry
@Component
struct Index {
  @State sliderValue: number = 50

  build() {
    Column() {
      Text(`Current Value: ${this.sliderValue}`)
        .fontSize(24)
        .fontColor('#000000')
        .margin({ bottom: 30 })

      Slider({ value: this.sliderValue, min: 0, max: 100 })
        .width('80%')
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