import { VerticalAlign, FlexAlign, Color, FontWeight } from '@ohos.base';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('VerticalAlign Comparison')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 30 })

      // VerticalAlign.Top
      Text('1. VerticalAlign.Top')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })
      Row() {
        Text('Child Element')
          .fontSize(18)
          .backgroundColor(Color.White)
          .padding(10)
          .borderRadius(8)
      }
      .width('90%')
      .height(120)
      .backgroundColor('#E0E0E0')
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Start)
      .padding(10)
      .margin({ bottom: 30 })

      // VerticalAlign.Center
      Text('2. VerticalAlign.Center')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })
      Row() {
        Text('Child Element')
          .fontSize(18)
          .backgroundColor(Color.White)
          .padding(10)
          .borderRadius(8)
      }
      .width('90%')
      .height(120)
      .backgroundColor('#E0E0E0')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding(10)
      .margin({ bottom: 30 })

      // VerticalAlign.Bottom
      Text('3. VerticalAlign.Bottom')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })
      Row() {
        Text('Child Element')
          .fontSize(18)
          .backgroundColor(Color.White)
          .padding(10)
          .borderRadius(8)
      }
      .width('90%')
      .height(120)
      .backgroundColor('#E0E0E0')
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.Start)
      .padding(10)
      .margin({ bottom: 30 })
    }
    .width('100%')
    .padding(20)
  }
}