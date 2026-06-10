import { VerticalAlign } from '@ohos.arkui.UIContext';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('VerticalAlign Comparison')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // Top alignment
      Text('VerticalAlign.Top')
        .fontSize(16)
        .margin({ bottom: 5 })
      Row() {
        Text('Small')
          .fontSize(12)
          .backgroundColor(Color.Pink)
          .padding(5)
        Text('Medium')
          .fontSize(20)
          .backgroundColor(Color.Orange)
          .padding(5)
        Text('Large')
          .fontSize(30)
          .backgroundColor(Color.Green)
          .padding(5)
      }
      .height(100)
      .width('100%')
      .backgroundColor(Color.Gray)
      .alignItems(VerticalAlign.Top)
      .margin({ bottom: 20 })

      // Center alignment
      Text('VerticalAlign.Center')
        .fontSize(16)
        .margin({ bottom: 5 })
      Row() {
        Text('Small')
          .fontSize(12)
          .backgroundColor(Color.Pink)
          .padding(5)
        Text('Medium')
          .fontSize(20)
          .backgroundColor(Color.Orange)
          .padding(5)
        Text('Large')
          .fontSize(30)
          .backgroundColor(Color.Green)
          .padding(5)
      }
      .height(100)
      .width('100%')
      .backgroundColor(Color.Gray)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 20 })

      // Bottom alignment
      Text('VerticalAlign.Bottom')
        .fontSize(16)
        .margin({ bottom: 5 })
      Row() {
        Text('Small')
          .fontSize(12)
          .backgroundColor(Color.Pink)
          .padding(5)
        Text('Medium')
          .fontSize(20)
          .backgroundColor(Color.Orange)
          .padding(5)
        Text('Large')
          .fontSize(30)
          .backgroundColor(Color.Green)
          .padding(5)
      }
      .height(100)
      .width('100%')
      .backgroundColor(Color.Gray)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(20)
  }
}