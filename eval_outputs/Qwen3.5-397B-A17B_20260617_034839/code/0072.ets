@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();
  private tabData: Array<{ id: number, title: string }> = [
    { id: 0, title: 'Home' },
    { id: 1, title: 'Service' },
    { id: 2, title: 'Profile' }
  ];

  @Builder TabBarContent(index: number) {
    Row() {
      Text(this.tabData[index].title)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 'bold' : 'normal')
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')
      if (this.currentIndex === index) {
        Row()
          .width(20)
          .height(3)
          .backgroundColor('#007DFF')
          .position({ x: 0, y: 24 })
          .borderRadius(1.5)
      }
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.controller.changeIndex(index);
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Top, controller: this.controller })
        .tabBar(this.TabBarContent.bind(this))
        .onChange((index: number) => {
          this.currentIndex = index;
        })
        .width('100%')
        .height('100%')
      {
        ForEach(this.tabData, (item: { id: number, title: string }, index: number) => {
          TabContent() {
            Column() {
              Text(`${item.title} Content`)
                .fontSize(24)
                .fontWeight('bold')
                .margin({ top: 20 })
              Text('Swipe horizontally or tap tabs to navigate')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 10 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .tabBar(this.TabBarContent.bind(this, index))
        }, (item: { id: number, title: string }) => item.id.toString())
      }
    }
    .width('100%')
    .height('100%')
  }
}