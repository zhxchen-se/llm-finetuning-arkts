@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        TabContent() {
          Column() {
            Text('Content of Page A')
              .fontSize(24)
              .fontColor('#333333')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('pageA')

        TabContent() {
          Column() {
            Text('Content of Page B')
              .fontSize(24)
              .fontColor('#333333')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('pageB')

        TabContent() {
          Column() {
            Text('Content of Page C')
              .fontSize(24)
              .fontColor('#333333')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('pageC')
      }
      .scrollable(true)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
  }
}