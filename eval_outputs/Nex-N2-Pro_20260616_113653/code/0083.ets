@Entry
@Component
struct Index {
  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.Start,
        vertical: false
      }) {
        TabContent() {
          Column() {
            Text('pageA')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .tabBar('pageA')

        TabContent() {
          Column() {
            Text('pageB')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .tabBar('pageB')

        TabContent() {
          Column() {
            Text('pageC')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .tabBar('pageC')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}