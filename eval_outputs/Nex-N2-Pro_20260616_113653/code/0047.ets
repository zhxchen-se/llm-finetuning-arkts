@Component
struct CustomRatingBar {
  @Prop ratingIndicator: boolean = false;
  @Link rating: number;

  private readonly maxRating: number = 5;
  private readonly step: number = 0.5;
  private readonly circleCount: number = 10;
  private readonly circleSize: number = 24;
  private readonly gap: number = 8;
  private readonly circleIndexes: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  private get barWidth(): number {
    return this.circleCount * this.circleSize + (this.circleCount - 1) * this.gap;
  }

  private get normalizedRating(): number {
    const roundedRating = Math.round(this.rating / this.step) * this.step;
    return Math.max(0, Math.min(this.maxRating, roundedRating));
  }

  private get filledCount(): number {
    return Math.round(this.normalizedRating / this.step);
  }

  private setRating(circleIndex: number): void {
    if (this.ratingIndicator) {
      return;
    }

    this.rating = Math.max(0, Math.min(this.maxRating, (circleIndex + 1) * this.step));
  }

  build() {
    Column() {
      Row() {
        Text(this.rating.toFixed(1))
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Text('/ 5')
          .fontSize(18)
          .fontColor('#6B7280')
          .margin({ left: 8 })

        Text(this.ratingIndicator ? 'Display only' : 'Tap to rate')
          .fontSize(14)
          .fontColor(this.ratingIndicator ? '#64748B' : '#2563EB')
          .margin({ left: 12 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        ForEach(this.circleIndexes, (index: number) => {
          Circle()
            .width(this.circleSize)
            .height(this.circleSize)
            .fill(index < this.filledCount ? '#F59E0B' : '#E5E7EB')
            .strokeWidth(1)
            .strokeColor('#FFFFFF')
            .shadow({
              radius: 2,
              color: '#1F293726',
              offsetX: 0,
              offsetY: 1
            })
            .onClick(() => {
              this.setRating(index)
            })
        }, (index: number) => index.toString())
      }
      .width(this.barWidth)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 14, bottom: 14 })
      .enabled(!this.ratingIndicator)
      .backgroundColor(this.ratingIndicator ? '#F8FAFC' : '#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 12,
        color: '#11182714',
        offsetX: 0,
        offsetY: 4
      })

      Text(this.ratingIndicator ? 'Display-only mode: the circles cannot be changed.' : 'Each circle equals 0.5 points. Tap a circle to change the rating.')
        .fontSize(13)
        .fontColor('#6B7280')
        .margin({ top: 8 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F3F4F6')
    .borderRadius(20)
  }
}

@Entry
@Component
struct Index {
  @State rating: number = 3.5;
  @State ratingIndicator: boolean = false;

  build() {
    Column() {
      Text('Custom Rating Bar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ bottom: 24 })

      CustomRatingBar({
        rating: this.rating,
        ratingIndicator: this.ratingIndicator
      })
      .width('90%')

      Row() {
        Text(this.ratingIndicator ? 'Display-only mode is on' : 'Interactive mode is on')
          .fontSize(15)
          .fontColor('#374151')

        Toggle({ type: ToggleType.Switch, isOn: this.ratingIndicator })
          .onChange((isOn: boolean) => {
            this.ratingIndicator = isOn;
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })

      Text('ratingIndicator=true locks the bar; ratingIndicator=false lets you rate.')
        .fontSize(13)
        .fontColor('#6B7280')
        .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#EEF2FF')
  }
}