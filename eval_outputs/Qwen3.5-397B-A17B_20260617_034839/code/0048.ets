import { promptAction } from '@ohos.promptAction';

@Component
struct StarRating {
  @Link ratingStars: number;
  @Prop ratingStepsize: number;
  private maxStars: number = 5;
  private starSize: number = 40;

  updateRating(newValue: number) {
    if (newValue < 0) newValue = 0;
    if (newValue > this.maxStars) newValue = this.maxStars;
    this.ratingStars = newValue;
  }

  build() {
    Row() {
      ForEach(this.maxStars, (index: number) => {
        Text('★')
          .fontSize(this.starSize)
          .fontColor(index < this.ratingStars ? '#FFD700' : '#CCCCCC')
          .onClick(() => {
            let newValue = index + 1;
            this.updateRating(newValue);
          })
          .gesture(
            TapGesture()
              .onAction((event) => {
                if (this.ratingStepsize <= 0.5) {
                  let localX = event.getLocalX();
                  let isHalf = localX < (this.starSize / 2);
                  let newValue = index + (isHalf ? 0.5 : 1);
                  this.updateRating(newValue);
                } else {
                  this.updateRating(index + 1);
                }
              })
          )
      }, (index: number) => index.toString())
    }
    .width(this.maxStars * this.starSize)
    .height(this.starSize)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct Index {
  @State ratingStars: number = 3;
  @State ratingStepsize: number = 0.5;

  aboutToAppear() {
  }

  build() {
    Column() {
      Text('HarmonyOS Rating Component')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      Text('Current Rating: ' + this.ratingStars.toFixed(1))
        .fontSize(18)
        .margin({ bottom: 10 })

      Text('Step Size: ' + this.ratingStepsize)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 20 })

      StarRating({ ratingStars: $this.ratingStars, ratingStepsize: this.ratingStepsize })
        .margin({ bottom: 30 })

      Row() {
        Text('Configure Step Size:')
          .fontSize(16)
          .margin({ right: 10 })

        Button('0.5')
          .onClick(() => {
            this.ratingStepsize = 0.5;
            this.showToast('Step size set to 0.5');
          })
          .margin({ right: 10 })

        Button('1.0')
          .onClick(() => {
            this.ratingStepsize = 1.0;
            this.showToast('Step size set to 1.0');
          })
      }
      .margin({ bottom: 20 })

      Row() {
        Button('Decrease')
          .onClick(() => {
            let newValue = this.ratingStars - this.ratingStepsize;
            if (newValue >= 0) {
              this.ratingStars = newValue;
            }
          })
          .margin({ right: 20 })

        Button('Increase')
          .onClick(() => {
            let newValue = this.ratingStars + this.ratingStepsize;
            if (newValue <= 5) {
              this.ratingStars = newValue;
            }
          })
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  showToast(message: string) {
    promptAction.showToast({
      message: message,
      duration: 2000
    });
  }
}