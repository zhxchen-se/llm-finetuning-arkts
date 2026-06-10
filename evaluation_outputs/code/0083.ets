import { BarMode } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        Text('Page A')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
      }
      .tabBar('pageA')

      TabContent() {
        Text('Page B')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
      }
      .tabBar('pageB')

      TabContent() {
        Text('Page C')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
      }
      .tabBar('pageC')
    }
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .barHeight(56)
  }
}