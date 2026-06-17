import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State group1Value: string = '';
  @State group2Value: string = '';

  build() {
    Column() {
      // Row 1: Radio1 and Button1
      Row() {
        RadioGroup({ value: this.group1Value })
          .onChange((value: string) => {
            this.group1Value = value;
          })
        {
          Radio({ value: 'on', group: 'g1' })
            .selectedColor(Color.Red)
            .margin({ right: 20 })
        }

        Button('Button1')
          .onClick(() => {
            if (this.group1Value === 'on') {
              this.group1Value = '';
            } else {
              this.group1Value = 'on';
            }
          })
          .borderRadius(this.group1Value === 'on' ? 8 : 50)
          .width(100)
          .height(40)
          .backgroundColor(this.group1Value === 'on' ? Color.Blue : Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 30 })

      // Row 2: Radio2 and Button2
      Row() {
        RadioGroup({ value: this.group2Value })
          .onChange((value: string) => {
            this.group2Value = value;
          })
        {
          Radio({ value: 'on', group: 'g2' })
            .selectedColor(Color.Red)
            .margin({ right: 20 })
        }

        Button('Button2')
          .onClick(() => {
            if (this.group2Value === 'on') {
              this.group2Value = '';
            } else {
              this.group2Value = 'on';
            }
          })
          .borderRadius(this.group2Value === 'on' ? 8 : 50)
          .width(this.group2Value === 'on' ? 100 : 50)
          .height(this.group2Value === 'on' ? 40 : 50)
          .backgroundColor(this.group2Value === 'on' ? Color.Blue : Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}