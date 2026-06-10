import { List, ListItem, Text, Button, Row } from '@ohos.arkui';

@Entry
@Component
struct Index {
  @State items: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(18)
                .layoutWeight(1)
              Button('Delete')
                .fontSize(14)
                .onClick(() => {
                  this.items.splice(index, 1);
                })
            }
            .width('100%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
          }
        }, (item: string, index: number) => index.toString())
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}