@Entry
@Component
struct Index {
  @State currentProgress: number = 0
  private intervalId: number = -1

  aboutToDisappear() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId)
    }
  }

  build() {
    Column({ space: 40 }) {
      Text('Circular Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#182431')

      CircularProgress({ progress: this.currentProgress })

      Row({ space: 20 }) {
        Button('Start')
          .width(120)
          .height(40)
          .fontSize(16)
          .backgroundColor('#007DFF')
          .onClick(() => {
            if (this.intervalId !== -1) {
              clearInterval(this.intervalId)
            }
            this.currentProgress = 0
            this.intervalId = setInterval(() => {
              if (this.currentProgress < 100) {
                this.currentProgress += 1
              } else {
                this.currentProgress = 100
                clearInterval(this.intervalId)
                this.intervalId = -1
              }
            }, 30)
          })

        Button('Reset')
          .width(120)
          .height(40)
          .fontSize(16)
          .backgroundColor('#E84026')
          .onClick(() => {
            if (this.intervalId !== -1) {
              clearInterval(this.intervalId)
              this.intervalId = -1
            }
            this.currentProgress = 0
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}

@Component
struct CircularProgress {
  @Prop progress: number = 0

  build() {
    Stack() {
      Progress({ value: this.progress, total: 100, type: ProgressType.Ring })
        .width(200)
        .height(200)
        .color('#007DFF')
        .style({ strokeWidth: 20 })

      Text(`${Math.round(this.progress)}%`)
        .fontSize(36)
        .fontColor('#182431')
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
    }
  }
}