import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State data: string[] = Array.from({ length: 100 }, (_, i) => `Item ${i + 1}`);

  build() {
    Column() {
      Text('Long List with Vertical Scrolling')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin(10)
      List() {
        ForEach(this.data, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .fontSize(18)
              .textAlign(TextAlign.Center)
              .backgroundColor(index % 2 === 0 ? '#f0f0f0' : '#ffffff')
          }
        }, (item: string) => item)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
  }
}