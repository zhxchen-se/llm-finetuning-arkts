import { FontWeight, FontStyle } from '@ohos.base';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Default Font')
        .fontSize(24)
        .margin(10)

      Text('Serif Font Family')
        .fontFamily('serif')
        .fontSize(24)
        .margin(10)

      Text('Sans-serif Font Family')
        .fontFamily('sans-serif')
        .fontSize(24)
        .margin(10)

      Text('Bold FontWeight')
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
        .margin(10)

      Text('Italic FontStyle')
        .fontStyle(FontStyle.Italic)
        .fontSize(24)
        .margin(10)

      Text('Large Font Size')
        .fontSize(32)
        .fontColor('#007DFF')
        .margin(10)

      Text('Custom Font Weight (Light)')
        .fontWeight(FontWeight.Light)
        .fontSize(24)
        .margin(10)
    }
    .width('100%')
    .padding(20)
  }
}