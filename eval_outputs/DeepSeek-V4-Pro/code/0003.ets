import { List, ListItem, ForEach } from '@ohos.arkui.advanced.List';
import { Column, Text, Row } from '@ohos.arkui.advanced.Components';

@Entry
@Component
struct Index {
  private items: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7', 'Item 8'];

  build() {
    Column() {
      Text('Horizontal Scroll List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)

      List({ space: 10 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(18)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .width('100%')
            }
            .width(120)
            .height(80)
            .backgroundColor(this.getColor(index))
            .borderRadius(10)
            .justifyContent(FlexAlign.Center)
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .width('100%')
      .height(100)
      .padding({ left: 10, right: 10 })
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }

  private getColor(index: number): string {
    const colors: string[] = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8', '#F7DC6F'];
    return colors[index % colors.length];
  }
}