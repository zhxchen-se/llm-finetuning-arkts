import { List, ListItem } from '@ohos.arkui.advanced.List';

@Entry
@Component
struct Index {
  private items: string[] = Array.from({ length: 100 }, (_, i) => `Item ${i + 1}`);

  build() {
    List() {
      ForEach(this.items, (item: string) => {
        ListItem() {
          Text(item)
            .fontSize(20)
            .padding(16)
            .width('100%')
            .textAlign(TextAlign.Start)
        }
        .border({ width: { bottom: 1 }, color: '#e0e0e0' })
      }, (item: string) => item)
    }
    .width('100%')
    .height('100%')
    .listDirection(Axis.Vertical)
    .scrollBar(BarState.Auto)
  }
}