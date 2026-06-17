import { Image, Text, Column, Tabs, TabContent, BarPosition, FlexAlign, HorizontalAlign } from '@ohos.arkui';
import { FontWeight } from '@ohos.base';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Bottom, index: this.currentIndex }) {
        TabContent() {
          Column() {
            Text('Home View')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#F1F3F5')
        }
        .tabBar(() => {
          Column() {
            Image($r('sys.media.ic_public_home'))
              .width(24)
              .height(24)
              .margin({ bottom: 4 })
            Text('Home')
              .fontSize(12)
              .fontColor(this.currentIndex === 0 ? '#007DFF' : '#666666')
          }
          .alignItems(HorizontalAlign.Center)
        })

        TabContent() {
          Column() {
            Text('Favorites View')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#F1F3F5')
        }
        .tabBar(() => {
          Column() {
            Image($r('sys.media.ic_public_favorites'))
              .width(24)
              .height(24)
              .margin({ bottom: 4 })
            Text('Favorites')
              .fontSize(12)
              .fontColor(this.currentIndex === 1 ? '#007DFF' : '#666666')
          }
          .alignItems(HorizontalAlign.Center)
        })

        TabContent() {
          Column() {
            Text('Settings View')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#F1F3F5')
        }
        .tabBar(() => {
          Column() {
            Image($r('sys.media.ic_public_settings'))
              .width(24)
              .height(24)
              .margin({ bottom: 4 })
            Text('Settings')
              .fontSize(12)
              .fontColor(this.currentIndex === 2 ? '#007DFF' : '#666666')
          }
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .height('100%')
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
  }
}