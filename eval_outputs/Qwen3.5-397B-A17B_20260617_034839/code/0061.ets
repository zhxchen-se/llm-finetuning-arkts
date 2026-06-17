import { setTimeout, clearTimeout } from '@ohos.base';

@Entry
@Component
struct Index {
  @State frameIndex: number = 0;
  @State isPlaying: boolean = false;
  @State speed: number = 200;
  @State isInfinite: boolean = true;
  @State repeatCount: number = 3;
  @State currentRepeat: number = 0;
  @State inputRepeatCount: string = '3';

  private timerId: number = -1;
  private pixelMapArray: Resource[] = [
    $r('app.media.icon'),
    $r('app.media.icon'),
    $r('app.media.icon'),
    $r('app.media.icon'),
    $r('app.media.icon')
  ];

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
  }

  startAnimation() {
    if (this.isPlaying) return;
    this.isPlaying = true;
    this.animateFrame();
  }

  stopAnimation() {
    this.isPlaying = false;
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
  }

  resetAnimation() {
    this.stopAnimation();
    this.frameIndex = 0;
    this.currentRepeat = 0;
  }

  animateFrame() {
    if (!this.isPlaying) return;

    this.timerId = setTimeout(() => {
      this.frameIndex++;
      if (this.frameIndex >= this.pixelMapArray.length) {
        this.frameIndex = 0;
        if (!this.isInfinite) {
          this.currentRepeat++;
          if (this.currentRepeat >= this.repeatCount) {
            this.stopAnimation();
            return;
          }
        }
      }
      this.animateFrame();
    }, this.speed);
  }

  build() {
    Column() {
      Text('Pixel Map Animation')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Image(this.pixelMapArray[this.frameIndex])
        .width(200)
        .height(200)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: 30 })
        .backgroundColor('#f0f0f0')

      Row() {
        Button(this.isPlaying ? 'Pause' : 'Play')
          .onClick(() => {
            if (this.isPlaying) {
              this.stopAnimation();
            } else {
              this.startAnimation();
            }
          })
          .margin({ right: 10 })

        Button('Reset')
          .onClick(() => {
            this.resetAnimation();
          })
      }
      .margin({ bottom: 20 })

      Column() {
        Text(`Speed: ${this.speed}ms`)
          .fontSize(16)
          .margin({ bottom: 5 })

        Slider({ value: this.speed, min: 50, max: 1000, step: 50 })
          .onChange((value: number) => {
            this.speed = value;
          })
          .width('80%')
      }
      .margin({ bottom: 20 })

      Column() {
        Row() {
          Text('Infinite Loop')
            .fontSize(16)
          Toggle({ type: ToggleType.Switch, isOn: this.isInfinite })
            .onChange((isOn: boolean) => {
              this.isInfinite = isOn;
              if (this.isInfinite) {
                this.currentRepeat = 0;
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 10 })

        if (!this.isInfinite) {
          Row() {
            Text('Repeat Count:')
              .fontSize(16)
            TextInput({ text: this.inputRepeatCount })
              .width(100)
              .type(InputType.Number)
              .onChange((value: string) => {
                this.inputRepeatCount = value;
                const count = parseInt(value);
                if (!isNaN(count) && count > 0) {
                  this.repeatCount = count;
                }
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }

        Text(`Current Repeat: ${this.currentRepeat}/${this.isInfinite ? '∞' : this.repeatCount}`)
          .fontSize(14)
          .fontColor('#666')
          .margin({ top: 10 })
      }
      .padding(10)
      .backgroundColor('#f9f9f9')
      .borderRadius(10)
      .width('90%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}