@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State isDarkMode: boolean = false
  @State isNotificationOn: boolean = true

  @Builder
  TabBuilder(title: string, icon: Resource, index: number) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor(this.currentIndex === index ? '#007DFF' : '#999999')
      Text(title)
        .fontSize(10)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
        .margin({ top: 4 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Column() {
          Text('Home')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })
          
          Text('Welcome to your HarmonyOS App!')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ bottom: 20 })

          List({ space: 12 }) {
            ForEach(['Recent Update 1', 'Recent Update 2', 'Recent Update 3'], (item: string) => {
              ListItem() {
                Row() {
                  Text(item)
                    .fontSize(16)
                    .fontColor('#333333')
                }
                .width('100%')
                .height(80)
                .backgroundColor('#F1F3F5')
                .borderRadius(12)
                .padding({ left: 16, right: 16 })
                .alignItems(VerticalAlign.Center)
              }
            }, (item: string) => item)
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20 })
      }
      .tabBar(this.TabBuilder('Home', $r('sys.symbol.house'), 0))

      TabContent() {
        Column() {
          Text('Favorites')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })

          List({ space: 12 }) {
            ForEach(['Favorite Item A', 'Favorite Item B', 'Favorite Item C', 'Favorite Item D'], (item: string) => {
              ListItem() {
                Row() {
                  Image($r('sys.symbol.heart_fill'))
                    .width(20)
                    .height(20)
                    .fillColor('#E84026')
                    .margin({ right: 12 })
                  Text(item)
                    .fontSize(16)
                    .fontColor('#333333')
                }
                .width('100%')
                .height(70)
                .backgroundColor('#F1F3F5')
                .borderRadius(12)
                .padding({ left: 16, right: 16 })
                .alignItems(VerticalAlign.Center)
              }
            }, (item: string) => item)
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20 })
      }
      .tabBar(this.TabBuilder('Favorites', $r('sys.symbol.heart'), 1))

      TabContent() {
        Column() {
          Text('Settings')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })

          Column({ space: 10 }) {
            Row() {
              Text('Dark Mode')
                .fontSize(16)
              Toggle({ type: ToggleType.Switch, isOn: this.isDarkMode })
                .onChange((isOn: boolean) => {
                  this.isDarkMode = isOn
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(16)
            .backgroundColor('#F1F3F5')
            .borderRadius(12)

            Row() {
              Text('Notifications')
                .fontSize(16)
              Toggle({ type: ToggleType.Switch, isOn: this.isNotificationOn })
                .onChange((isOn: boolean) => {
                  this.isNotificationOn = isOn
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(16)
            .backgroundColor('#F1F3F5')
            .borderRadius(12)

            Row() {
              Text('Version')
                .fontSize(16)
              Text('1.0.0')
                .fontSize(16)
                .fontColor('#999999')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(16)
            .backgroundColor('#F1F3F5')
            .borderRadius(12)
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20 })
        .alignItems(HorizontalAlign.Start)
      }
      .tabBar(this.TabBuilder('Settings', $r('sys.symbol.gearshape'), 2))
    }
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}