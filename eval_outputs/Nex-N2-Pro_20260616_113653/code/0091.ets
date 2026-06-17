@Entry
@Component
struct Index {
  @State count: number = 10;
  private timer: number = -1;

  aboutToAppear(): void {
    this.timer = setInterval(() => {
      if (this.count > 0) {
        this.count--;
      } else {
        clearInterval(this.timer);
        this.timer = -1;
      }
    }, 1000);
  }

  aboutToDisappear(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }
  }

  build() {
    Column() {
      Text('Countdown')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')

      Text(this.count.toString())
        .fontSize(120)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2563EB')
        .margin({ top: 40, bottom: 40 })

      Text(this.count === 0 ? 'Finished' : 'Counting down...')
        .fontSize(24)
        .fontColor('#64748B')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8FAFC')
  }
}