import { ToggleType, ButtonType } from '@ohos.arkui.component';

@Entry
@Component
struct Index {
  @State button1On: boolean = false;
  @State button2On: boolean = false;
  @State radio1Selected: boolean = false;
  @State radio2Selected: boolean = false;

  build() {
    Column() {
      // Button1 control
      Row() {
        Text('Button1')
          .fontSize(16)
          .margin({ right: 10 })
        Toggle({ type: ToggleType.Button, isOn: this.button1On })
          .onChange((isOn: boolean) => {
            this.button1On = isOn;
          })
          .width(60)
          .height(36)
      }
      .margin({ bottom: 10 })

      // Radio1
      Row() {
        Button('Radio1')
          .type(ButtonType.Normal)
          .width(100)
          .height(40)
          .borderRadius(this.button1On ? 4 : 20) // normal vs capsule
          .backgroundColor(this.radio1Selected ? Color.Red : Color.White)
          .fontColor(this.radio1Selected ? Color.White : Color.Black)
          .border({ width: 1, color: Color.Gray })
          .onClick(() => {
            this.radio1Selected = !this.radio1Selected;
          })
      }
      .margin({ bottom: 20 })

      // Button2 control
      Row() {
        Text('Button2')
          .fontSize(16)
          .margin({ right: 10 })
        Toggle({ type: ToggleType.Button, isOn: this.button2On })
          .onChange((isOn: boolean) => {
            this.button2On = isOn;
          })
          .width(60)
          .height(36)
      }
      .margin({ bottom: 10 })

      // Radio2
      Row() {
        Button('Radio2')
          .type(ButtonType.Normal)
          .width(this.button2On ? 100 : 40) // normal width or circle width
          .height(40)
          .borderRadius(this.button2On ? 4 : 20) // normal vs circle
          .backgroundColor(this.radio2Selected ? Color.Red : Color.White)
          .fontColor(this.radio2Selected ? Color.White : Color.Black)
          .border({ width: 1, color: Color.Gray })
          .onClick(() => {
            this.radio2Selected = !this.radio2Selected;
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}