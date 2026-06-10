// entry/src/main/ets/pages/Index.ets
import { Slider } from '@ohos.arkui.advanced.Slider';

@Entry
@Component
struct Index {
  @State sliderValue: number = 0;

  build() {
    Column() {
      Text(`Current Value: ${this.sliderValue}`)
        .fontSize(20)
        .margin({ bottom: 20 });

      Slider({
        value: this.sliderValue,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('80%')
        .onChange((value: number) => {
          this.sliderValue = value;
        });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}