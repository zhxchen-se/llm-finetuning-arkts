import { Component, State } from '@ohos/arkui';

@Entry
@Component
struct Index {
  @State count: number = 10;
  private timerId: number = -1;

  aboutToAppear() {
    this.startCountdown();
  }

  aboutToDisappear() {
    this.stopCountdown();
  }

  startCountdown() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
    this.timerId = setInterval(() => {
      if (this.count > 0) {
        this.count--;
      } else {
        this.stopCountdown();
      }
    }, 1000);
  }

  stopCountdown() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Column() {
      Text(this.count.toString())
        .fontSize(80)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF0000')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 200 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}