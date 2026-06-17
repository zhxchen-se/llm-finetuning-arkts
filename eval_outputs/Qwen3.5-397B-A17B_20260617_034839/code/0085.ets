@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  build() {
    Column() {
      Text('Swipe Image Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      Swiper() {
        ForEach([0, 1], (item) => {
          Stack() {
            Image($r('app.media.icon'))
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Contain)
              .backgroundColor('#F0F0F0')

            Text(`Image ${item + 1}`)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor('rgba(0, 0, 0, 0.5)')
              .padding(10)
              .borderRadius(10)
          }
          .width('100%')
          .height('100%')
        }, (item) => item.toString())
      }
      .width('90%')
      .height(300)
      .loop(true)
      .indicator(true)
      .onChange((index) => {
        this.currentIndex = index
      })

      Text(`Current Index: ${this.currentIndex + 1}`)
        .margin({ top: 20 })
        .fontSize(16)
        .fontColor('#333333')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}