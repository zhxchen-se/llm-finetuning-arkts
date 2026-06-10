import { Image, Button } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State rotation: number = 0;

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(100)
        .height(100)
        .rotate({ angle: this.rotation })

      Button('Rotate Left 90°')
        .margin({ top: 20 })
        .onClick(() => {
          this.rotation -= 90;
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}