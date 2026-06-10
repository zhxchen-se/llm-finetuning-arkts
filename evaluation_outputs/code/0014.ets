import { ProgressType } from '@ohos.arkui.advanced.Progress';

@Entry
@Component
struct Index {
  @State progress: number = 0;
  private timerId: number = -1;

  aboutToAppear() {
    this.timerId = setInterval(() => {
      if (this.progress < 100) {
        this.progress += 1;
      } else {
        clearInterval(this.timerId);
      }
    }, 50);
  }

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Progress({
        value: this.progress,
        total: 100,
        type: ProgressType.Ring
      })
        .width(200)
        .height(200)
        .color('#317AF7')
        .backgroundColor('#E5E5E5')
        .style({ strokeWidth: 12, scaleCount: 60, scaleWidth: 2 })

      Text(`${this.progress.toFixed(0)}%`)
        .fontSize(36)
        .fontColor('#317AF7')
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}