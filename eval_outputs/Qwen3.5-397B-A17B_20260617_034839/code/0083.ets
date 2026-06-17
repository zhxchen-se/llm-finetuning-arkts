import { TabsController, BarPosition } from '@ohos.ArkUI';

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController();

  build() {
    Tabs({ barPosition: BarPosition.Top, controller: this.controller }) {
      TabContent() {
        Column() {
          Text('Content of pageA')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('pageA')

      TabContent() {
        Column() {
          Text('Content of pageB')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('pageB')

      TabContent() {
        Column() {
          Text('Content of pageC')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('pageC')
    }
    .width('100%')
    .height('100%')
  }
}