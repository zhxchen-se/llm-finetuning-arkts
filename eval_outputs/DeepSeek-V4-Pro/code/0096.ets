import { List, ListItem } from '@ohos.arkui.advanced.List';

@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'];

  build() {
    List() {
      ForEach(this.fruits, (fruit: string, index: number) => {
        ListItem() {
          Text(fruit)
            .fontSize(20)
            .padding(12)
            .width('100%')
            .textAlign(TextAlign.Start)
        }
      }, (fruit: string, index: number) => fruit + index)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 20 })
  }
}