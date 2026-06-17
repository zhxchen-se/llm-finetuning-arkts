import { promptAction } from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State input1: string = '';
  @State input2: string = '';

  build() {
    Column() {
      TextInput({ placeholder: 'Enter text for field 1' })
        .width('80%')
        .height(40)
        .backgroundColor('#f1f3f5')
        .borderRadius(4)
        .padding(10)
        .margin({ bottom: 20 })
        .onChange((value: string) => {
          this.input1 = value;
        })

      TextInput({ placeholder: 'Enter text for field 2' })
        .width('80%')
        .height(40)
        .backgroundColor('#f1f3f5')
        .borderRadius(4)
        .padding(10)
        .margin({ bottom: 20 })
        .onChange((value: string) => {
          this.input2 = value;
        })

      Button('Submit')
        .width('80%')
        .height(40)
        .backgroundColor('#007dff')
        .onClick(() => {
          this.validateForm();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  validateForm() {
    if (this.isNumber(this.input1) || this.isNumber(this.input2)) {
      promptAction.showToast({
        message: 'Warning: Please enter strings, not numbers.',
        duration: 3000
      });
    } else {
      promptAction.showToast({
        message: 'Form submitted successfully!',
        duration: 3000
      });
    }
  }

  isNumber(value: string): boolean {
    if (!value || value.trim() === '') {
      return false;
    }
    return /^-?\d+(\.\d+)?$/.test(value);
  }
}