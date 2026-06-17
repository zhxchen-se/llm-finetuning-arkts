@Entry
@Component
struct Index {
  @State userRating: number = 0

  build() {
    Column() {
      // User Information Card
      Row() {
        Image($r('app.media.app_icon'))
          .width(60)
          .height(60)
          .borderRadius(30)
          .margin({ right: 16 })
          .interpolation(ImageInterpolation.High)

        Column() {
          Text('Alex Johnson')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1F1F1F')

          Text('Member since Oct 27, 2023')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('90%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .shadow({ radius: 8, color: '#E0E0E0', offsetY: 4 })
      .margin({ top: 40 })

      // Rating Card
      Column() {
        Text('Rate your experience')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 16 })

        Rating({ rating: this.userRating, indicator: false })
          .stars(5)
          .stepSize(1)
          .starStyle({
            filledStar: $r('sys.media.ohos_ic_public_favor_filled'),
            halfStar: $r('sys.media.ohos_ic_public_favor_filled'),
            emptyStar: $r('sys.media.ohos_ic_public_favor')
          })
          .onChange((value: number) => {
            this.userRating = value
          })

        Text(`Your Rating: ${this.userRating} / 5`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF9800')
          .margin({ top: 24 })

        if (this.userRating > 0) {
          Text(
            this.userRating >= 4 ? 'Thank you for your positive feedback!' :
            this.userRating >= 2 ? 'We will try to improve!' :
            'We are sorry to hear that!'
          )
            .fontSize(14)
            .fontColor('#888888')
            .margin({ top: 8 })
        }
      }
      .width('90%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .shadow({ radius: 8, color: '#E0E0E0', offsetY: 4 })
      .margin({ top: 24 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Center)
  }
}