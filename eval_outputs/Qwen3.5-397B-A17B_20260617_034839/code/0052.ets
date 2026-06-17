import { FlexAlign, FlexDirection } from '@ohos.base';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Flex() {
        Text('Element 1')
          .width(200)
          .height(50)
          .backgroundColor('#FF6347')
          .fontSize(18)
          .fontColor('#ffffff')
        Text('Element 2')
          .width(200)
          .height(50)
          .backgroundColor('#4682B4')
          .fontSize(18)
          .fontColor('#ffffff')
        Text('Element 3')
          .width(200)
          .height(50)
          .backgroundColor('#32CD32')
          .fontSize(18)
          .fontColor('#ffffff')
      }
      .direction(FlexDirection.Column)
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}