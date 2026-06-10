import { Tabs, TabContent, BarPosition } from '@ohos.arkui.advanced.Tabs';

interface TabItem {
  title: string;
  icon: string;
  activeColor: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabItems: TabItem[] = [
    { title: 'Home', icon: '🏠', activeColor: '#FF6B6B' },
    { title: 'Search', icon: '🔍', activeColor: '#4ECDC4' },
    { title: 'Notifications', icon: '🔔', activeColor: '#FFD166' },
    { title: 'Profile', icon: '👤', activeColor: '#6A0572' }
  ];

  @Builder TabBarBuilder() {
    Row() {
      ForEach(this.tabItems, (item: TabItem, index: number) => {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            if (index === this.currentIndex) {
              Circle({ width: 40, height: 40 })
                .fill(item.activeColor + '33')
                .shadow({
                  radius: 20,
                  color: item.activeColor,
                  offsetX: 0,
                  offsetY: 0
                })
            }
            Text(item.icon)
              .fontSize(24)
              .fontColor(index === this.currentIndex ? item.activeColor : '#999999')
          }
          .width(40)
          .height(40)
          .clip(false)

          Text(item.title)
            .fontSize(12)
            .fontColor(index === this.currentIndex ? item.activeColor : '#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentIndex = index;
        })
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor('#F0F0F0')
    .padding({ top: 8, bottom: 8 })
    .clip(false)
  }

  build() {
    Tabs({ index: this.currentIndex, barPosition: BarPosition.End }) {
      TabContent() {
        Column() {
          Text('Home Page')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FF6B6B')
      }

      TabContent() {
        Column() {
          Text('Search Page')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#4ECDC4')
      }

      TabContent() {
        Column() {
          Text('Notifications Page')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFD166')
      }

      TabContent() {
        Column() {
          Text('Profile Page')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#6A0572')
      }
    }
    .tabBar(this.TabBarBuilder())
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .width('100%')
    .height('100%')
  }
}