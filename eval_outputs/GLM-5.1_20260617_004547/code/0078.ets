interface TabConfig {
  icon: string;
  label: string;
  color: string;
  glowColor: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  private tabs: TabConfig[] = [
    { icon: '🏠', label: 'Home', color: '#FF5722', glowColor: '#33FF5722' },
    { icon: '🔍', label: 'Search', color: '#4CAF50', glowColor: '#334CAF50' },
    { icon: '💬', label: 'Chat', color: '#2196F3', glowColor: '#332196F3' },
    { icon: '👤', label: 'Profile', color: '#9C27B0', glowColor: '#339C27B0' }
  ];

  @Builder TabItem(index: number, tab: TabConfig) {
    Column() {
      Stack() {
        if (this.currentIndex === index) {
          Circle()
            .width(44)
            .height(44)
            .fill(tab.glowColor)
            .shadow({ radius: 20, color: tab.color, offsetX: 0, offsetY: 0 })
        }
        Text(tab.icon)
          .fontSize(24)
          .zIndex(1)
      }
      .width(44)
      .height(44)
      .alignContent(Alignment.Center)
      .scale({ x: this.currentIndex === index ? 1.1 : 1.0, y: this.currentIndex === index ? 1.1 : 1.0 })
      .animation({ duration: 300, curve: Curve.EaseInOut })

      Text(tab.label)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? tab.color : '#999999')
        .margin({ top: 4 })
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .animation({ duration: 300, curve: Curve.EaseInOut })
    }
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index;
    })
    .layoutWeight(1)
    .height('100%')
  }

  @Builder ContentArea() {
    Column() {
      Text(this.tabs[this.currentIndex].icon)
        .fontSize(80)
        .margin({ bottom: 20 })

      Text(this.tabs[this.currentIndex].label)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.tabs[this.currentIndex].color)

      Text(`Content for ${this.tabs[this.currentIndex].label} goes here...`)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      this.ContentArea()

      Divider()
        .color('#EEEEEE')

      Row() {
        ForEach(this.tabs, (tab: TabConfig, index?: number) => {
          this.TabItem(index ?? 0, tab)
        }, (tab: TabConfig, index?: number) => index?.toString())
      }
      .width('100%')
      .height(70)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#1A000000', offsetY: -2, offsetX: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}