import { Toggle, ToggleType } from '@ohos.arkui.advanced.Toggle';

@Entry
@Component
struct Index {
  @State isOn: boolean = false;

  build() {
    Column() {
      Text('Toggle Switch')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Toggle({ type: ToggleType.Switch, isOn: this.isOn })
        .onChange((isOn: boolean) => {
          this.isOn = isOn;
        })
        .width(60)
        .height(30)

      Text(`Switch is ${this.isOn ? 'ON' : 'OFF'}`)
        .fontSize(18)
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}