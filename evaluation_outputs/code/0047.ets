import { Array } from '@kit.ArkUI';

@Component
struct CircleItem {
  @Prop filled: boolean = false;
  @Prop index: number = 0;
  onClick?: () => void;

  build() {
    View()
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.filled ? '#FFD700' : '#E0E0E0')
      .margin({ left: 4, right: 4 })
      .onClick(() => {
        if (this.onClick) {
          this.onClick();
        }
      })
  }
}

@Component
struct RatingBar {
  @Link rating: number;
  @Prop ratingIndicator: boolean = false;
  private maxRating: number = 5;
  private step: number = 0.5;
  private circleCount: number = this.maxRating / this.step;

  build() {
    Row() {
      ForEach(
        Array.from({ length: this.circleCount }, (_, i) => i),
        (i: number) => {
          CircleItem({
            index: i,
            filled: (i + 1) * this.step <= this.rating,
            onClick: () => {
              if (!this.ratingIndicator) {
                this.rating = (i + 1) * this.step;
              }
            }
          })
        },
        (i: number) => i.toString()
      )
    }
    .justifyContent(FlexAlign.Center)
    .padding(10)
  }
}

@Entry
@Component
struct Index {
  @State currentRating: number = 3.0;
  @State isIndicator: boolean = false;

  build() {
    Column() {
      Text('Rating Bar Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      RatingBar({ rating: $currentRating, ratingIndicator: this.isIndicator })

      Text(`Current Rating: ${this.currentRating.toFixed(1)}`)
        .fontSize(18)
        .margin({ top: 20 })

      Button(this.isIndicator ? 'Switch to Editable' : 'Switch to Indicator')
        .onClick(() => {
          this.isIndicator = !this.isIndicator;
        })
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}