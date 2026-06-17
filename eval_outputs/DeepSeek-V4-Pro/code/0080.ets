import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State textColor: string = '#FFFF00'; // Yellow

  build() {
    Column() {
      Text('hello world')
        .fontSize(30)
        .fontColor(this.textColor)
        .margin({ bottom: 20 })

      Button('Change Color')
        .onClick(() => {
          this.textColor = '#00FF00'; // Green
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}