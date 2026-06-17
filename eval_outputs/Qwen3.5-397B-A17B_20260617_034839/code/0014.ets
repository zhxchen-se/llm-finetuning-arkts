import { ProgressType, FontWeight, FlexAlign, HorizontalAlign } from '@ohos/arkui';

@Entry
@Component
struct Index {
  @State progress: number = 0
  private timer: number = -1

  aboutToAppear() {
    this.startLoading()
  }

  aboutToDisappear() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
    }
  }

  startLoading() {
    this.progress = 0
    this.timer = setInterval(() => {
      if (this.progress >= 100) {
        clearInterval(this.timer)
        this.timer = -1
      } else {
        this.progress += 1
      }
    }, 50)
  }

  build() {
    Column() {
      Stack() {
        Progress({ value: this.progress, type: ProgressType.Ring })
          .width(200)
          .height(200)
          .color('#007DFF')
          .strokeWidth(10)

        Text(`${this.progress}%`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width(200)
      .height(200)

      Button(this.timer === -1 ? 'Start Loading' : 'Reset')
        .onClick(() => {
          if (this.timer === -1) {
            this.startLoading()
          } else {
            clearInterval(this.timer)
            this.timer = -1
            this.progress = 0
          }
        })
        .margin({ top: 50 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}