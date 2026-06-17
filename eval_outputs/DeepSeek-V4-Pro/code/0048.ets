import { TouchEvent, TouchType } from '@ohos.arkui.UiTest'; // Not needed, but we can just use TouchEvent without import? Actually, TouchEvent is a global type, no import needed. We'll omit imports.

@Component
struct RatingBar {
  @Link ratingStars: number;
  @Prop ratingStepsize: number = 1;
  @Prop maxRating: number = 5;
  @Prop starSize: number = 40;
  @State totalWidth: number = 0;
  private starIndices: number[] = [0, 1, 2, 3, 4];

  build() {
    Stack() {
      // Empty stars layer
      Row() {
        ForEach(this.starIndices, (item: number) => {
          Text('☆')
            .fontSize(this.starSize)
            .fontColor('#CCCCCC')
        })
      }
      .width('100%')
      .height(this.starSize)
      .hitTestBehavior(HitTestMode.None)

      // Filled stars layer, clipped to rating proportion
      Row() {
        ForEach(this.starIndices, (item: number) => {
          Text('★')
            .fontSize(this.starSize)
            .fontColor('#FFD700')
        })
      }
      .width('100%')
      .height(this.starSize)
      .clip(new Rect({ width: (this.ratingStars / this.maxRating) * this.totalWidth, height: this.starSize }))
      .hitTestBehavior(HitTestMode.None)
    }
    .width(this.starSize * this.maxRating)
    .height(this.starSize)
    .onAreaChange((oldValue, newValue) => {
      this.totalWidth = newValue.width as number;
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down || event.type === TouchType.Move) {
        let x = event.touches[0].x;
        this.updateRating(x);
      }
    })
  }

  updateRating(x: number) {
    if (this.totalWidth === 0) return;
    let rawRating = (x / this.totalWidth) * this.maxRating;
    let step = this.ratingStepsize;
    let newRating = Math.round(rawRating / step) * step;
    newRating = Math.max(0, Math.min(this.maxRating, newRating));
    this.ratingStars = newRating;
  }
}

@Entry
@Component
struct Index {
  @State rating: number = 3.5;
  @State stepSize: number = 0.5;

  build() {
    Column() {
      Text('Rating Component')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      RatingBar({ ratingStars: $rating, ratingStepsize: stepSize, starSize: 48 })

      Text(`Current Rating: ${this.rating.toFixed(1)}`)
        .fontSize(20)
        .margin({ top: 20 })

      Row() {
        Button('Step 0.5')
          .onClick(() => { this.stepSize = 0.5; })
          .margin({ right: 10 })
        Button('Step 1')
          .onClick(() => { this.stepSize = 1; })
      }
      .margin({ top: 20 })

      Button('Reset to 0')
        .onClick(() => { this.rating = 0; })
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}