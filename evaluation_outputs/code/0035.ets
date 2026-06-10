import { Slider, Progress, ProgressType } from '@ohos.arkui.advanced.Slider';
import { SliderStyle } from '@ohos.arkui.advanced.Slider';

@Entry
@Component
struct Index {
  @State sliderValue: number = 50;

  build() {
    Column() {
      // Title
      Text('Slider & Progress Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // Display current value
      Text(`Selected Value: ${this.sliderValue}`)
        .fontSize(20)
        .margin({ bottom: 20 })

      // Slider component
      Slider({
        value: this.sliderValue,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .onChange((value: number) => {
          this.sliderValue = value;
        })
        .width('80%')
        .margin({ bottom: 30 })

      // Progress bar
      Progress({
        value: this.sliderValue,
        total: 100,
        type: ProgressType.Linear
      })
        .width('80%')
        .height(20)
        .color('#0A59F7')
        .backgroundColor('#E5E5E5')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}