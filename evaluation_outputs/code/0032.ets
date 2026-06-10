import { Tabs, TabContent } from '@ohos.arkui.advanced.Tabs';

@Entry
@Component
struct Index {
  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Column() {
          Text('Home')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Text('Welcome to Home Page')
            .fontSize(20)
            .margin({ top: 10 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar({
        icon: $r('sys.symbol.ohos_home'),
        text: 'Home'
      })

      TabContent() {
        Column() {
          Text('Favorites')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Text('Your favorite items appear here')
            .fontSize(20)
            .margin({ top: 10 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar({
        icon: $r('sys.symbol.ohos_star'),
        text: 'Favorites'
      })

      TabContent() {
        Column() {
          Text('Settings')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Text('Adjust your preferences')
            .fontSize(20)
            .margin({ top: 10 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar({
        icon: $r('sys.symbol.ohos_settings'),
        text: 'Settings'
      })
    }
    .width('100%')
    .height('100%')
  }
}