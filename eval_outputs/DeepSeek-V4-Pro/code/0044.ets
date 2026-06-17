import { Radio, RadioIndicator } from '@ohos.arkui.advanced.Radio';

@Entry
@Component
struct Index {
  @State selectedValue: string = 'radio1';

  @Builder indicatorBuilder(checked: boolean) {
    if (checked) {
      Text('✓')
        .fontSize(20)
        .fontColor(Color.Green)
    } else {
      Text('✗')
        .fontSize(20)
        .fontColor(Color.Red)
    }
  }

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
      RadioGroup({ group: 'radioGroup' }) {
        Radio({ value: 'radio1', group: 'radioGroup' })
          .indicator(RadioIndicator.TICK)
          .checked(this.selectedValue === 'radio1')
        Radio({ value: 'radio2', group: 'radioGroup' })
          .indicator(RadioIndicator.DOT)
          .checked(this.selectedValue === 'radio2')
        Radio({ value: 'radio3', group: 'radioGroup' })
          .indicator(this.indicatorBuilder)
          .checked(this.selectedValue === 'radio3')
      }
      .direction(FlexDirection.Row)
      .onChange((value: string) => {
        this.selectedValue = value;
      })
    }
    .width('100%')
    .height('100%')
  }
}