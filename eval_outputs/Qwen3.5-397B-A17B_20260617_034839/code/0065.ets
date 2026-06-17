import { animateTo } from '@ohos.base';

@Entry
@Component
struct Index {
  @State currentFrameIndex: number = 0;
  @State topOpacity: number = 0;
  @State isPlaying: boolean = true;
  @State nextFrameIndex: number = 1;

  // Simulate PixelMap resources. In a real project, add images to resources/base/element/media
  // and reference them like $r('app.media.frame1'), $r('app.media.frame2'), etc.
  private frameResources: Resource[] = [
    $r('app.media.icon'),
    $r('app.media.icon'),
    $r('app.media.icon')
  ];

  private animationDuration: number = 500;
  private frameInterval: number = 1000;
  private timer: number = -1;

  aboutToAppear() {
    this.startAnimationLoop();
  }

  aboutToDisappear() {
    this.stopAnimationLoop();
  }

  startAnimationLoop() {
    if (this.timer !== -1) {
      return;
    }
    this.isPlaying = true;
    this.runFrameSequence();
  }

  stopAnimationLoop() {
    this.isPlaying = false;
    if (this.timer !== -1) {
      clearTimeout(this.timer);
      this.timer = -1;
    }
  }

  runFrameSequence() {
    if (!this.isPlaying) return;

    // Calculate next frame index
    this.nextFrameIndex = (this.currentFrameIndex + 1) % this.frameResources.length;

    // Animate opacity for cross-fade transition
    animateTo({
      duration: this.animationDuration,
      curve: Curve.EaseInOut
    }, () => {
      this.topOpacity = 1;
    }, () => {
      // Animation complete, swap frames and reset opacity
      this.currentFrameIndex = this.nextFrameIndex;
      this.topOpacity = 0;
      
      // Schedule next frame
      if (this.isPlaying) {
        this.timer = setTimeout(() => {
          this.runFrameSequence();
        }, this.frameInterval - this.animationDuration);
      }
    });
  }

  togglePlay() {
    if (this.isPlaying) {
      this.stopAnimationLoop();
    } else {
      this.startAnimationLoop();
    }
  }

  build() {
    Column() {
      Text('PixelMap Frame Animation Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Stack() {
        // Bottom Image (Current Frame)
        Image(this.frameResources[this.currentFrameIndex])
          .width(200)
          .height(200)
          .objectFit(ImageFit.Contain)

        // Top Image (Next Frame with Opacity Transition)
        Image(this.frameResources[this.nextFrameIndex])
          .width(200)
          .height(200)
          .objectFit(ImageFit.Contain)
          .opacity(this.topOpacity)
      }
      .margin({ bottom: 40 })

      Row() {
        Button(this.isPlaying ? 'Pause' : 'Play')
          .onClick(() => {
            this.togglePlay();
          })
          .width(120)
          .height(40)
      }

      Text('Note: Add actual media resources to project\nto see distinct frames.')
        .fontSize(12)
        .fontColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}