import { Entry, Component, State } from '@ohos/arkui';

@Entry
@Component
struct Index {
  @State listData: Array<string> = []

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.listData.push(`List Item ${i + 1}`)
    }
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.listData, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .backgroundColor('#007DFF')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .borderRadius(10)
          }
        }, (item: string) => {
          return item
        })
      }
      .width('100%')
      .height('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
  }
}