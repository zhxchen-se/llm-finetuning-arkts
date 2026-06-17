import { PixelMap } from '@kit.ArkGraphics2D';

const specifiedPixelMapArray: PixelMap[] = [
  // Replace this array with your specified PixelMap frames.
  // pixelMapFrame01,
  // pixelMapFrame02,
  // pixelMapFrame03
];

@Entry
@Component
struct Index {
  @State pixelMapArray: PixelMap[] = specifiedPixelMapArray;
  @State currentIndex: number = 0;
  @State playing: boolean = false;
  @State fps: number = 12;
  @State repeatMode: number = 0;
  @State loopCount: number = 0;

  private timerId: number = -1;
  private readonly minFps: number = 1;
  private readonly maxFps: number = 30;
  private readonly maxRepeat: number = 99;

  aboutToAppear(): void {
    this.startTimer();
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  get playButtonText(): string {
    return this.playing ? 'Pause' : 'Play';
  }

  get speedText(): string {
    return `${this.fps} FPS`;
  }

  get frameIntervalText(): string {
    return `Frame interval: ${(1000 / this.fps).toFixed(1)} ms`;
  }

  get frameInfoText(): string {
    if (this.pixelMapArray.length > 0 && this.currentIndex < this.pixelMapArray.length) {
      return `${this.currentIndex + 1}/${this.pixelMapArray.length}`;
    }
    return '0/0';
  }

  get repeatText(): string {
    return this.repeatMode === 0 ? 'Repeat: Infinite' : `Repeat: ${this.repeatMode}`;
  }

  get repeatProgressText(): string {
    if (this.repeatMode === 0) {
      return 'Looping';
    }
    const pass = Math.min(this.loopCount + 1, this.repeatMode);
    return `Pass: ${pass}/${this.repeatMode}`;
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Text('PixelMap Animation Player')
            .width('100%')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F8FAFC')
            .textAlign(TextAlign.Center)

          Text('Set specifiedPixelMapArray with your PixelMap frames.')
            .width('100%')
            .fontSize(13)
            .fontColor('#94A3B8')
            .textAlign(TextAlign.Center)
            .margin({ top: 8 })

          this.FrameView()

          Column() {
            Text('Playback Controls')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#F8FAFC')
              .margin({ bottom: 12 })

            Row() {
              Button(this.playButtonText)
                .width(96)
                .height(48)
                .fontSize(16)
                .fontColor('#FFFFFF')
                .backgroundColor(this.playing ? '#F97316' : '#16A34A')
                .enabled(this.pixelMapArray.length > 0)
                .onClick(() => {
                  if (this.playing) {
                    this.stopTimer();
                  } else {
                    this.prepareToPlay();
                    this.startTimer();
                  }
                })

              Button('Prev')
                .width(96)
                .height(48)
                .fontSize(16)
                .fontColor('#FFFFFF')
                .backgroundColor('#334155')
                .enabled(this.pixelMapArray.length > 0)
                .margin({ left: 6, right: 6 })
                .onClick(() => {
                  this.previousFrame();
                })

              Button('Next')
                .width(96)
                .height(48)
                .fontSize(16)
                .fontColor('#FFFFFF')
                .backgroundColor('#334155')
                .enabled(this.pixelMapArray.length > 0)
                .onClick(() => {
                  this.nextFrame();
                })

              Button('Reset')
                .width(96)
                .height(48)
                .fontSize(16)
                .fontColor('#FFFFFF')
                .backgroundColor('#475569')
                .enabled(this.pixelMapArray.length > 0)
                .margin({ left: 6, right: 6 })
                .onClick(() => {
                  this.resetPlayback();
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)

            Divider()
              .margin({ top: 16, bottom: 16 })

            Column() {
              Row() {
                Text('Speed')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')

                Text(this.speedText)
                  .fontSize(14)
                  .fontColor('#93C5FD')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Slider({ value: this.fps, min: this.minFps, max: this.maxFps, step: 1 })
                .width('100%')
                .margin({ top: 12, bottom: 4 })
                .onChange((value: number): void => {
                  this.setFps(value);
                })

              Text(this.frameIntervalText)
                .fontSize(12)
                .fontColor('#94A3B8')
                .margin({ top: 4 })
            }
            .width('100%')
            .margin({ top: 16 })

            Column() {
              Row() {
                Text('Repetition')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')

                Text(this.repeatText)
                  .fontSize(14)
                  .fontColor('#93C5FD')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Button('-')
                  .width(44)
                  .height(44)
                  .fontSize(22)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#334155')
                  .onClick(() => {
                    this.changeRepeat(-1);
                  })

                Text(this.repeatProgressText)
                  .width(160)
                  .fontSize(14)
                  .fontColor('#93C5FD')
                  .textAlign(TextAlign.Center)
                  .margin({ left: 8, right: 8 })

                Button('+')
                  .width(44)
                  .height(44)
                  .fontSize(22)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#334155')
                  .onClick(() => {
                    this.changeRepeat(1);
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
              .margin({ top: 10 })

              Text('0 = infinite repetition')
                .width('100%')
                .fontSize(12)
                .fontColor('#64748B')
                .textAlign(TextAlign.Center)
                .margin({ top: 8 })
            }
            .width('100%')
            .margin({ top: 16 })
          }
          .width('100%')
          .padding(16)
          .borderRadius(18)
          .backgroundColor('#111827')
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  private startTimer(): void {
    this.stopTimer();

    if (this.pixelMapArray.length === 0) {
      return;
    }

    this.playing = true;
    this.timerId = setInterval(() => {
      this.nextFrame();
    }, 1000 / this.fps);
  }

  private stopTimer(): void {
    if (this.timerId >= 0) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
    this.playing = false;
  }

  private restartTimer(): void {
    const shouldPlay = this.playing;
    this.stopTimer();

    if (shouldPlay) {
      this.startTimer();
    }
  }

  private prepareToPlay(): void {
    if (this.pixelMapArray.length === 0) {
      return;
    }

    if (
      this.repeatMode > 0 &&
      this.loopCount >= this.repeatMode - 1 &&
      this.currentIndex >= this.pixelMapArray.length - 1
    ) {
      this.currentIndex = 0;
      this.loopCount = 0;
    }
  }

  private nextFrame(): void {
    if (this.pixelMapArray.length === 0) {
      return;
    }

    const lastIndex = this.pixelMapArray.length - 1;

    if (this.currentIndex >= lastIndex) {
      if (this.repeatMode === 0) {
        this.currentIndex = 0;
        this.loopCount = 0;
      } else if (this.loopCount >= this.repeatMode - 1) {
        this.stopTimer();
      } else {
        this.currentIndex = 0;
        this.loopCount += 1;
      }
      return;
    }

    this.currentIndex += 1;
  }

  private previousFrame(): void {
    if (this.pixelMapArray.length === 0) {
      return;
    }

    this.currentIndex = (this.currentIndex - 1 + this.pixelMapArray.length) % this.pixelMapArray.length;

    if (!this.playing) {
      this.loopCount = 0;
    }
  }

  private resetPlayback(): void {
    this.stopTimer();
    this.currentIndex = 0;
    this.loopCount = 0;
  }

  private setFps(value: number): void {
    this.fps = Math.max(this.minFps, Math.min(this.maxFps, Math.round(value)));
    this.restartTimer();
  }

  private changeRepeat(delta: number): void {
    const nextRepeat = this.repeatMode + delta;
    this.repeatMode = Math.max(0, Math.min(this.maxRepeat, nextRepeat));
    this.loopCount = 0;

    if (
      this.repeatMode > 0 &&
      this.pixelMapArray.length > 0 &&
      this.loopCount >= this.repeatMode - 1 &&
      this.currentIndex >= this.pixelMapArray.length - 1
    ) {
      this.stopTimer();
    }
  }

  @Builder
  FrameView() {
    if (this.pixelMapArray.length > 0 && this.currentIndex < this.pixelMapArray.length) {
      Column() {
        Image(this.pixelMapArray[this.currentIndex])
          .width('100%')
          .height(260)
          .objectFit(ImageFit.contain)
          .backgroundColor('#020617')
          .borderRadius(16)

        Text(this.frameInfoText)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ top: 10 })
      }
      .width('78%')
      .height(320)
      .justifyContent(FlexAlign.Center)
      .padding(12)
      .borderRadius(20)
      .backgroundColor('#111827')
      .margin({ top: 20, bottom: 20 })
    } else {
      Column() {
        Text('No PixelMap frames specified')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')

        Text('Edit specifiedPixelMapArray to provide frames.')
          .fontSize(13)
          .fontColor('#94A3B8')
          .margin({ top: 8 })
      }
      .width('78%')
      .height(320)
      .justifyContent(FlexAlign.Center)
      .padding(12)
      .borderRadius(20)
      .backgroundColor('#111827')
      .margin({ top: 20, bottom: 20 })
    }
  }
}