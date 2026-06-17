import { Column, Row, Flex, FlexDirection, Radio, RadioIndicator, Text, Align, FlexAlign } from '@ohos.components';

@Entry
@Component
struct Index {
  @State radioValue: number = 1;

  build() {
    Column() {
      Flex() {
        Radio({ name: 'Radio1', group: 'group1', type: RadioIndicator.TICK })
          .value(1)
          .bindValue($$this.radioValue)
          .margin({ right: 20 })

        Radio({ name: 'Radio2', group: 'group1', type: RadioIndicator.DOT })
          .value(2)
          .bindValue($$this.radioValue)
          .margin({ right: 20 })

        Radio({ name: 'Radio3', group: 'group1' })
          .value(3)
          .bindValue($$this.radioValue)
          .indicatorBuilder((isChecked: boolean) => {
            return Row() {
              Text(isChecked ? '✓' : '')
                .fontColor('#FFFFFF')
                .fontSize(16)
            }
            .width(24)
            .height(24)
            .backgroundColor(isChecked ? '#007DFF' : '#FFFFFF')
            .border({ width: 1, color: '#007DFF' })
            .borderRadius(12)
            .alignItems(Align.Center)
            .justifyContent(FlexAlign.Center)
          })
      }
      .direction(FlexDirection.Row)
      .alignItems(Align.Center)
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}