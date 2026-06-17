import { TabsController } from '@ohos.components.Tabs';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabTitles: string[] = ['Home', 'Service', 'Mine'];
  private colors: number[] = [0xFFE6F7FF, 0xFFF0F5FF, 0xFFF5F0FF];

  @Builder
  CustomTabBar() {
    Row() {
      ForEach(this.tabTitles, (title: string, index: number) => {
        Column() {
          Text(title)
            .fontSize(16)
            .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentIndex === index ? Color.White : Color.Gray)
        }
        .width('30%')
        .height(36)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.currentIndex === index ? Color.Blue : Color.Transparent)
        .borderRadius(18)
        .onClick(() => {
          this.tabsController.index = index;
        })
      }, (title: string, index: number) => title + index.toString())
    }
    .width('85%')
    .height(48)
    .backgroundColor(Color.LightGray)
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 20 })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        ForEach(this.tabTitles, (title: string, index: number) => {
          TabContent() {
            Column() {
              Text(`${title} Content`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 50 })
              Text('Swipe left or right to navigate')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ top: 10 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.colors[index % this.colors.length])
          }
          .tabBar(this.tabTitles[index])
        }, (title: string, index: number) => title + index.toString())
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .customBarBuilder(this.CustomTabBar)
      .barStyle(BarStyle.Hidden)
      .swipeable(true)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}