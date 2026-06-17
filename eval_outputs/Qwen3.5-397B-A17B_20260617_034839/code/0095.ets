import { Curve } from '@ohos.base';

@Component
export struct CustomToggle {
  @Link isChecked: boolean;

  build() {
    Row() {
      Box()
        .width(26)
        .height(26)
        .backgroundColor('#FFFFFF')
        .borderRadius(13)
        .position({ x: this.isChecked ? 22 : 2, y: 2 })
        .shadow({ radius: 1, color: '#00000026', offsetX: 0, offsetY: 1 })
    }
    .width(50)
    .height(30)
    .backgroundColor(this.isChecked ? '#007DFF' : '#E5E5E5')
    .borderRadius(15)
    .onClick(() => {
      this.handleToggle();
    })
  }

  handleToggle() {
    animateTo({ duration: 200, curve: Curve.Ease }, () => {
      this.isChecked = !this.isChecked;
    });
  }
}

@Entry
@Component
struct Index {
  @State isOn: boolean = false;

  build() {
    Column() {
      Text(this.isOn ? 'Status: ON' : 'Status: OFF')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .fontColor('#333333')

      CustomToggle({ isChecked: $isOn })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
  }
}