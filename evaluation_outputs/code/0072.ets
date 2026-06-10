import { TabsController } from '@ohos.arkui.advanced.TabsController';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabTitles: string[] = ['Home', 'Discover', 'Profile'];

  @Builder
  TabBuilder() {
    Row() {
      ForEach(this.tabTitles, (title: string, index: number) => {
        Column() {
          Text(title)
            .fontSize(16)
            .fontColor(this.currentIndex === index ? '#007AFF' : '#182431')
            .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .padding({ top: 12, bottom: 8 })
          if (this.currentIndex === index) {
            Divider()
              .strokeWidth(2)
              .color('#007AFF')
              .width('100%')
          } else {
            Divider()
              .strokeWidth(0)
              .color(Color.Transparent)
              .width('100%')
          }
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentIndex = index;
          this.tabsController.changeIndex(index);
        })
      })
    }
    .height(48)
    .width('100%')
    .backgroundColor('#F1F3F5')
  }

  build() {
    Tabs({
      barPosition: BarPosition.Start,
      controller: this.tabsController,
      index: this.currentIndex
    }) {
      TabContent() {
        List() {
          ForEach(Array.from({ length: 20 }, (_, i) => i + 1), (item: number) => {
            ListItem() {
              Text(`Home item ${item}`)
                .fontSize(18)
                .padding(16)
                .width('100%')
                .textAlign(TextAlign.Start)
            }
          })
        }
        .width('100%')
        .height('100%')
      }

      TabContent() {
        Column() {
          Text('Discover')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 20 })
          Text('Explore new content here.')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 8 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }

      TabContent() {
        Column() {
          Text('Profile')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 20 })
          Text('Manage your account settings.')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 8 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .tabBar(this.TabBuilder)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .animationDuration(300)
    .width('100%')
    .height('100%')
  }
}