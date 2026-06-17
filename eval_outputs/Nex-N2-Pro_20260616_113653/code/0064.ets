import { ImageAnimatorController } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  private animatorController: ImageAnimatorController = new ImageAnimatorController();

  @State statusText: string = 'Stopped';
  @State isPlaying: boolean = false;
  @State isPaused: boolean = false;

  private startAnimation(): void {
    if (this.isPaused && this.isPlaying) {
      this.animatorController.resume();
    } else {
      this.animatorController.start();
    }

    this.isPlaying = true;
    this.isPaused = false;
    this.statusText = 'Playing';
  }

  private pauseAnimation(): void {
    if (!this.isPlaying) {
      return;
    }

    this.animatorController.pause();
    this.isPlaying = false;
    this.isPaused = true;
    this.statusText = 'Paused';
  }

  private stopAnimation(): void {
    this.animatorController.stop();
    this.isPlaying = false;
    this.isPaused = false;
    this.statusText = 'Stopped';
  }

  build() {
    Column() {
      Text('Resource Animation Player')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 32, bottom: 8 })

      Text('Uses PNG frame resources from app/media')
        .fontSize(14)
        .fontColor('#64748B')
        .textAlign(TextAlign.Center)
        .maxLines(2)

      ImageAnimator({
        images: [
          { src: $r('app.media.animation_01'), width: 180, height: 180 },
          { src: $r('app.media.animation_02'), width: 180, height: 180 },
          { src: $r('app.media.animation_03'), width: 180, height: 180 },
          { src: $r('app.media.animation_04'), width: 180, height: 180 },
          { src: $r('app.media.animation_05'), width: 180, height: 180 },
          { src: $r('app.media.animation_06'), width: 180, height: 180 },
          { src: $r('app.media.animation_07'), width: 180, height: 180 },
          { src: $r('app.media.animation_08'), width: 180, height: 180 }
        ],
        duration: 1200,
        repeatCount: -1
      })
        .width(220)
        .height(220)
        .borderRadius(24)
        .backgroundColor('#111827')
        .margin({ top: 28, bottom: 20 })
        .imageAnimatorController(this.animatorController)

      Text(this.statusText)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isPlaying ? '#16A34A' : (this.isPaused ? '#F59E0B' : '#64748B'))
        .margin({ bottom: 24 })

      Row() {
        Button('Start')
          .width(96)
          .height(44)
          .backgroundColor('#2563EB')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .onClick(() => {
            this.startAnimation();
          })

        Button('Pause')
          .width(96)
          .height(44)
          .backgroundColor('#F59E0B')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .enabled(this.isPlaying && !this.isPaused)
          .onClick(() => {
            this.pauseAnimation();
          })

        Button('Stop')
          .width(96)
          .height(44)
          .backgroundColor('#DC2626')
          .fontColor('#FFFFFF')
          .borderRadius(12)
          .enabled(this.isPlaying || this.isPaused)
          .onClick(() => {
            this.stopAnimation();
          })
      }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
    }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F8FAFC')
  }
}