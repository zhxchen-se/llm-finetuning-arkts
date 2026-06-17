import { FontWeight } from '@ohos.base';

@Entry
@Component
export default struct Index {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Home', 'Service', 'Mine'];

  build() {
    Column({ space: 10 }) {
      // Tab Bar Area
      Stack({ alignContent: Alignment.Center }) {
        // Line Cursor (Bottom Layer)
        Box() {
          width: 40
          height: 3
          backgroundColor: '#007DFF'
          borderRadius: 1.5
          position: 'absolute'
          bottom: 0
          // Calculate position: (Index * TabWidth%) + (HalfTabWidth%) - (HalfLineWidth)
          // TabWidth = 100% / 3. HalfTab = 100% / 6. HalfLine = 20vp.
          left: calc(${this.currentIndex * 100 / 3}% + 100% / 6 - 20vp)
        }

        // Tabs (Top Layer)
        Row({ space: 0 }) {
          ForEach(this.tabs, (item: string, index: number) => {
            Column() {
              Text(item)
                .fontSize(this.currentIndex === index ? 14 : 16)
                .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')
                .transition({
                  type: TransitionType.OPACITY,
                  opacity: 1,
                  scale: 1
                })
            }
            .layoutWeight(1)
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .onClick(() => {
              if (this.currentIndex !== index) {
                animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
                  this.currentIndex = index;
                });
              }
            })
          }, (item: string, index: number) => 'tab' + index)
        }
        .width('100%')
        .height(60)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#F5F5F5')

      // Content Area
      Column() {
        Text(`Content for ${this.tabs[this.currentIndex]}`)
          .fontSize(24)
          .fontColor('#333333')
          .margin({ top: 20 })
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 20 })
  }
}