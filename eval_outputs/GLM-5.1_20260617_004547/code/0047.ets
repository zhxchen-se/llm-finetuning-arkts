import { Circle } from '@ohos.arkui.UIContext'

@Entry
@Component
struct Index {
  @State interactiveRating: number = 2.5
  @State displayRating: number = 4.0

  build() {
    Column({ space: 30 }) {
      Text('Custom Rating Bar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // Interactive Rating Bar
      Column({ space: 10 }) {
        Text('Interactive Mode (ratingIndicator: false)')
          .fontSize(16)
          .fontColor('#666666)

        Row({ space: 10 }) {
          CustomRatingBar({
            currentRating: $interactiveRating,
            maxRating: 5,
            ratingIndicator: false
          })
          
          Text(`${this.interactiveRating.toFixed(1)} / 5.0`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF9800')
        }
      }
      .padding(20)
      .borderRadius(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })

      // Display-Only Rating Bar
      Column({ space: 10 }) {
        Text('Display-Only Mode (ratingIndicator: true)')
          .fontSize(16)
          .fontColor('#666666')

        Row({ space: 10 }) {
          CustomRatingBar({
            currentRating: $displayRating,
            maxRating: 5,
            ratingIndicator: true
          })
          
          Text(`${this.displayRating.toFixed(1)} / 5.0`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#757575')
        }
      }
      .padding(20)
      .borderRadius(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 8, color: '#1F000000', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct CustomRatingBar {
  @Link currentRating: number
  @Prop maxRating: number = 5
  @Prop ratingIndicator: boolean = false

  build() {
    Row({ space: 6 }) {
      ForEach(Array.from({ length: this.maxRating * 2 }), (_: undefined, index: number) => {
        Circle({ width: 16, height: 16 })
          .fill(index < (this.currentRating * 2) ? '#FF9800' : '#E0E0E0')
          .enabled(!this.ratingIndicator)
          .opacity(this.ratingIndicator ? 0.8 : 1.0)
          .onClick(() => {
            if (!this.ratingIndicator) {
              this.currentRating = (index + 1) * 0.5
            }
          })
          .animation({ duration: 200, curve: Curve.EaseOut })
      }, (_: undefined, index: number) => index.toString())
    }
  }
}