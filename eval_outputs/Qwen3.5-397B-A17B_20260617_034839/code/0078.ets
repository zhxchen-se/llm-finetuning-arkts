import { Color, GlyphIcons, SafeAreaType } from '@ohos.base';

interface TabConfig {
  icon: GlyphIcons;
  label: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  private tabConfigs: TabConfig[] = [
    { icon: GlyphIcons.Home, label: 'Home', color: '#007DFF' },
    { icon: GlyphIcons.Search, label: 'Search', color: '#00C853' },
    { icon: GlyphIcons.User, label: 'Profile', color: '#FFAB00' },
    { icon: GlyphIcons.Settings, label: 'Settings', color: '#D500F9' }
  ];

  build() {
    Column() {
      Stack() {
        ForEach(this.tabConfigs, (item: TabConfig, index: number) => {
          Column() {
            Text(`Content for ${item.label}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(item.color)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .visibility(this.currentIndex === index ? Visibility.Visible : Visibility.Hidden)
          .position({ x: 0, y: 0 })
        }, (item: TabConfig) => item.label)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#1a1a1a')

      Row() {
        ForEach(this.tabConfigs, (item: TabConfig, index: number) => {
          Column() {
            Stack() {
              Circle()
                .width(50)
                .height(50)
                .fill(item.color)
                .opacity(this.currentIndex === index ? 0.6 : 0)
                .blur(15)
                .animation({ duration: 300, curve: Curve.Ease })

              Glyph(item.icon)
                .fontColor(this.currentIndex === index ? item.color : '#888888')
                .fontSize(28)
                .animation({ duration: 300, curve: Curve.Ease })
            }
            .width(50)
            .height(50)

            Text(item.label)
              .fontSize(12)
              .fontColor(this.currentIndex === index ? item.color : '#888888')
              .margin({ top: 4 })
              .animation({ duration: 300, curve: Curve.Ease })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.currentIndex = index;
          })
        }, (item: TabConfig) => item.label)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#252525')
      .shadow({ radius: 10, color: '#000000', offsetX: 0, offsetY: -5 })
      .safeArea({ type: SafeAreaType.BOTTOM, color: Color.Transparent })
    }
    .width('100%')
    .height('100%')
  }
}