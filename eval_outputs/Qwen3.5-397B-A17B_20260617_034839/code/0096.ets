import { Entry, Component } from '@ohos.arkui';

@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Orange', 'Grape', 'Watermelon', 'Mango', 'Pineapple', 'Strawberry'];

  build() {
    Column() {
      List() {
        ForEach(this.fruits, (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(24)
              .padding(16)
              .width('100%')
              .textAlign(TextAlign.Start)
          }
        }, (item: string) => item)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}