@Entry
@Component
struct Index {
  @State ratingStars: number = 3.0;
  @State ratingStepsize: number = 0.5;

  build() {
    Column({ space: 20 }) {
      Text('Rating Component Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Rating({ rating: this.ratingStars, indicator: false })
        .stars(5)
        .stepSize(this.ratingStepsize)
        .starStyle(StarStyle.EMBIGGEN)
        .onChange((value: number) => {
          this.ratingStars = value;
        })

      Text(`Current Rating: ${this.ratingStars.toFixed(2)}`)
        .fontSize(18)
        .margin({ top: 10 })

      Row({ space: 10 }) {
        Text('Adjust Rating:')
          .fontSize(16)
        Slider({
          value: this.ratingStars,
          min: 0,
          max: 5,
          step: this.ratingStepsize,
          style: SliderStyle.InSet
        })
          .width('60%')
          .onChange((value: number) => {
            this.ratingStars = value;
          })
      }
      .width('100%')
      .margin({ top: 20 })

      Text('Configure Step Size:')
        .fontSize(18)
        .margin({ top: 20 })

      Row({ space: 15 }) {
        Button('0.1')
          .onClick(() => {
            this.ratingStepsize = 0.1;
            this.ratingStars = Math.round(this.ratingStars / 0.1) * 0.1;
          })
          .width(60)
          .height(40)
          .backgroundColor(this.ratingStepsize === 0.1 ? '#007DFF' : '#CCCCCC')

        Button('0.5')
          .onClick(() => {
            this.ratingStepsize = 0.5;
            this.ratingStars = Math.round(this.ratingStars / 0.5) * 0.5;
          })
          .width(60)
          .height(40)
          .backgroundColor(this.ratingStepsize === 0.5 ? '#007DFF' : '#CCCCCC')

        Button('1.0')
          .onClick(() => {
            this.ratingStepsize = 1.0;
            this.ratingStars = Math.round(this.ratingStars / 1.0) * 1.0;
          })
          .width(60)
          .height(40)
          .backgroundColor(this.ratingStepsize === 1.0 ? '#007DFF' : '#CCCCCC')
      }
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}