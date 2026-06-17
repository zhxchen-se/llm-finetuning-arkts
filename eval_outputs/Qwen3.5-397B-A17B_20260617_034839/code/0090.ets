import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State rotateAngle: number = 0;

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(150)
        .height(150)
        .rotate(this.rotateAngle)
        .transition({ type: TransitionType.Rotate, duration: 300 })

      Button('Rotate Left')
        .margin({ top: 30 })
        .onClick(() => {
          this.rotateAngle -= 90;
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}