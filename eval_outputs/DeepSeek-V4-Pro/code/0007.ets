import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Welcome to HarmonyOS';

  build() {
    Column() {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Refresh')
        .fontSize(20)
        .onClick(() => {
          this.message = '';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}