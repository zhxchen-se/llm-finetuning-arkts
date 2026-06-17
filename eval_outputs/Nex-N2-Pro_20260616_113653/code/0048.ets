@Component
struct RatingComponent {
  @Link ratingStars: number;
  @Prop ratingStepsize: number = 1;

  private readonly maxStars: number = 5;
  private readonly starIndexes: number[] = [1, 2, 3, 4, 5];

  aboutToAppear(): void {
    this.ratingStars = this.normalizeRating(this.ratingStars);
  }

  build() {
    Column() {
      Row() {
        ForEach(this.starIndexes, (item: number) => {
          Text('★')
            .width(44)
            .fontSize(38)
            .textAlign(TextAlign.Center)
            .fontColor(this.getStarColor(item))
            .onClick(() => {
              this.setRating(item);
            })
        }, (item: number) => item.toString())
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Row() {
        Button('-')
          .width(44)
          .height(44)
          .onClick(() => {
            this.changeRating(-this.ratingStepsize);
          })

        Text(this.formatRating())
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .minWidth(56)
          .textAlign(TextAlign.Center)
          .margin({ left: 16, right: 16 })

        Button('+')
          .width(44)
          .height(44)
          .onClick(() => {
            this.changeRating(this.ratingStepsize);
          })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
  }

  private getStepSize(): number {
    if (this.ratingStepsize > 0 && this.ratingStepsize < Infinity) {
      return this.ratingStepsize;
    }
    return 1;
  }

  private normalizeRating(value: number): number {
    let safeValue = value;
    if (safeValue !== safeValue || safeValue === Infinity || safeValue === -Infinity) {
      safeValue = 0;
    }

    const step = this.getStepSize();
    const clamped = Math.max(0, Math.min(this.maxStars, safeValue));
    const rounded = Math.round(clamped / step) * step;
    return Number(rounded.toFixed(4));
  }

  private setRating(value: number): void {
    this.ratingStars = this.normalizeRating(value);
  }

  private changeRating(delta: number): void {
    const alignedCurrent = this.normalizeRating(this.ratingStars);
    this.ratingStars = this.normalizeRating(alignedCurrent + delta);
  }

  private getStarColor(index: number): string {
    const fullStars = Math.floor(this.ratingStars);
    const fractionalPart = this.ratingStars - fullStars;

    if (index <= fullStars) {
      return '#F59E0B';
    }

    if (index === fullStars + 1 && fractionalPart >= 0.5) {
      return '#F59E0B';
    }

    return '#D1D5DB';
  }

  private formatRating(): string {
    return Number(this.ratingStars.toFixed(4)).toString();
  }
}

@Entry
@Component
struct Index {
  @State ratingStars: number = 3;
  @State ratingStepsize: number = 0.5;

  build() {
    Column() {
      Text('Configurable Rating Component')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Text('ratingStars sets the value; ratingStepsize sets the increment')
        .fontSize(15)
        .fontColor('#6B7280')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 28 })

      RatingComponent({
        ratingStars: $ratingStars,
        ratingStepsize: this.ratingStepsize
      })
      .padding(24)
      .borderRadius(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#000000', offsetX: 0, offsetY: 4 })

      Text(`Current ratingStars: ${this.ratingStars}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 28 })

      Text(`Current ratingStepsize: ${this.ratingStepsize}`)
        .fontSize(16)
        .fontColor('#6B7280')
        .margin({ top: 8 })

      Row() {
        Text('Set ratingStepsize: ')
          .fontSize(16)
          .fontColor('#374151')

        Button('0.25')
          .width(64)
          .margin({ left: 8 })
          .backgroundColor(this.ratingStepsize === 0.25 ? '#2563EB' : '#E5E7EB')
          .fontColor(this.ratingStepsize === 0.25 ? '#FFFFFF' : '#111827')
          .onClick(() => {
            this.ratingStepsize = 0.25;
          })

        Button('0.5')
          .width(64)
          .margin({ left: 8 })
          .backgroundColor(this.ratingStepsize === 0.5 ? '#2563EB' : '#E5E7EB')
          .fontColor(this.ratingStepsize === 0.5 ? '#FFFFFF' : '#111827')
          .onClick(() => {
            this.ratingStepsize = 0.5;
          })

        Button('1')
          .width(64)
          .margin({ left: 8 })
          .backgroundColor(this.ratingStepsize === 1 ? '#2563EB' : '#E5E7EB')
          .fontColor(this.ratingStepsize === 1 ? '#FFFFFF' : '#111827')
          .onClick(() => {
            this.ratingStepsize = 1;
          })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F3F4F6')
  }
}