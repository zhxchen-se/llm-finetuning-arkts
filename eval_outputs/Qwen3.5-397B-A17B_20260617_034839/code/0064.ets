import { PlayState, AnimationOptions } from '@ohos/arkui'

@Entry
@Component
struct Index {
  @State playState: PlayState = PlayState.Pause
  @State angle: number = 0
  private timer: number | null = null
  private speed: number = 2

  aboutToDisappear() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  startAnimation() {
    if (this.playState === PlayState.Run) {
      return
    }
    this.playState = PlayState.Run
    this.startTimer()
  }

  pauseAnimation() {
    if (this.playState === PlayState.Pause) {
      return
    }
    this.playState = PlayState.Pause
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  stopAnimation() {
    this.playState = PlayState.Pause
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
    this.angle = 0
  }

  private startTimer() {
    if (this.timer) {
      return
    }
    this.timer = setInterval(() => {
      this.angle += this.speed
      if (this.angle >= 360) {
        this.angle = 0
      }
    }, 16) as unknown as number
  }

  build() {
    Column() {
      Text('Animation Control')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Box()
        .width(150)
        .height(150)
        .backgroundColor('#007DFF')
        .borderRadius(15)
        .rotate({ angle: this.angle })
        // To use a resource file animation, replace the object below with:
        // .animation($r('app.profile.your_animation_file'))
        // Ensure the .anim file exists in resources/base/profile
        .animation({
          duration: 1000,
          playState: this.playState,
          iterations: -1,
          curve: Curve.Ease
        })
        .shadow({ radius: 10, color: '#1824310f', offsetX: 0, offsetY: 5 })
        .margin({ bottom: 50 })

      Row() {
        Button('Start')
          .onClick(() => {
            this.startAnimation()
          })
          .margin({ right: 10 })

        Button('Pause')
          .onClick(() => {
            this.pauseAnimation()
          })
          .margin({ right: 10 })

        Button('Stop')
          .onClick(() => {
            this.stopAnimation()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(FlexAlign.Center)
  }
}