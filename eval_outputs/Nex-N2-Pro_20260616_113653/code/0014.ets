@Entry
@Component
struct Index {
  @State progress: number = 0
  private timer: number = -1

  aboutToAppear(): void {
    this.timer = setInterval(() => {
      this.progress = this.progress >= 100 ? 0 : this.progress + 1
    }, 80)
  }

  aboutToDisappear(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer)
    }
  }

  build() {
    Column() {
      CircularLoadingProgress({ value: this.progress })
    }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F7F7F7')
  }
}

@Component
struct CircularLoadingProgress {
  @Prop value: number = 0
  @Prop total: number = 100

  build() {
    Stack() {
      Progress({
        value: this.value,
        total: this.total,
        type: ProgressType.Ring
      })
        .width(220)
        .height(220)
        .strokeWidth(16)
        .color('#0A59F7')
        .secondaryColor('#E6E6E6')

      Text(`${Math.round((this.value / this.total) * 100)}%`)
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0A59F7')
    }
      .width(220)
      .height(220)
  }
}