@Entry
@Component
struct Index {
  @State count: number = 10;
  private timer: number = -1;

  aboutToAppear() {
    this.timer = setInterval(() => {
      if (this.count > 0) {
        this.count--;
      } else {
        clearInterval(this.timer);
      }
    }, 1000);
  }

  aboutToDisappear() {
    if (this.timer !== -1) {
      clearInterval(this.timer);
    }
  }

  build() {
    Column() {
      Text(this.count.toString())
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}