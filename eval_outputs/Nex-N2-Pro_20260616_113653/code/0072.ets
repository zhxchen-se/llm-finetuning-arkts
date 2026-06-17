@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private tabs: Array<string> = ['Overview', 'Tasks', 'Profile']

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.Top,
        vertical: false
      }) {
        TabContent() {
          this.Section(
            'Overview',
            'Tap a tab header or swipe horizontally to move between sections.',
            '#EAF4FF'
          )
        }
        .tabBarMethod('Overview')

        TabContent() {
          this.Section(
            'Tasks',
            'Swipe left or right, or tap Tasks above, to see the active tab update.',
            '#FFF4E6'
          )
        }
        .tabBarMethod('Tasks')

        TabContent() {
          this.Section(
            'Profile',
            'The selected tab is highlighted by the indicator and matching content.',
            '#ECFDF3'
          )
        }
        .tabBarMethod('Profile')
      }
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .indicatorColor('#0A84FF')
      .indicatorWidth(56)
      .indicatorHeight(4)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F8FB')
  }

  @Builder Section(title: string, description: string, color: string) {
    Column() {
      Text(`Active tab: ${this.tabs[this.currentIndex]}`)
        .fontColor('#0A84FF')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)

      Text(title)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#101828')
        .margin({ top: 12 })

      Text(description)
        .fontSize(16)
        .fontColor('#475467')
        .textAlign(TextAlign.Center)
        .margin({ top: 12 })

      Row() {
        ForEach([0, 1, 2], (dot: number) => {
          Column()
            .width(this.currentIndex === dot ? 28 : 8)
            .height(8)
            .borderRadius(4)
            .backgroundColor(this.currentIndex === dot ? '#0A84FF' : '#D0D5DD')
            .margin({ left: dot === 0 ? 0 : 6 })
        })
      }
      .justifyContent(FlexAlign.Center)
      .margin({ top: 28 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(24)
    .backgroundColor(color)
  }
}