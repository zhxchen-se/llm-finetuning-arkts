import { ForEach } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabs: Array<{ title: string; content: string }> = [
    { title: 'Home', content: 'Home Content' },
    { title: 'Discover', content: 'Discover Content' },
    { title: 'Profile', content: 'Profile Content' }
  ];

  build() {
    Column() {
      // Capsule-shaped tab bar
      Row() {
        ForEach(this.tabs, (tab: { title: string; content: string }, index: number) => {
          Text(tab.title)
            .fontSize(16)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
            .borderRadius(16)
            .backgroundColor(this.currentIndex === index ? '#007AFF' : Color.Transparent)
            .fontColor(this.currentIndex === index ? Color.White : '#333333')
            .onClick(() => {
              this.currentIndex = index;
            })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        })
      }
      .width('80%')
      .height(44)
      .backgroundColor('#F0F0F0')
      .borderRadius(22)
      .padding(4)
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 20 })

      // Swipeable content areas
      Swiper() {
        ForEach(this.tabs, (tab: { title: string; content: string }) => {
          Column() {
            Text(tab.content)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        })
      }
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}