import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State firstField: string = '';
  @State secondField: string = '';
  @State warningText: string = '';

  isNumeric(value: string): boolean {
    const trimmedValue: string = value.trim();

    if (trimmedValue.length === 0) {
      return false;
    }

    const numberPattern: RegExp = /^[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?$/;
    return numberPattern.test(trimmedValue);
  }

  build() {
    Column() {
      Text('Submit Form')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 32 });

      TextInput({ placeholder: 'First field (text only)', text: this.firstField })
        .onChange((value: string) => {
          this.firstField = value;
          this.warningText = '';
        })
        .width('90%')
        .height(56)
        .margin({ bottom: 16 })
        .padding({ left: 16, right: 16 })
        .borderRadius(8)
        .backgroundColor('#F5F5F5');

      TextInput({ placeholder: 'Second field (text only)', text: this.secondField })
        .onChange((value: string) => {
          this.secondField = value;
          this.warningText = '';
        })
        .width('90%')
        .height(56)
        .margin({ bottom: 24 })
        .padding({ left: 16, right: 16 })
        .borderRadius(8)
        .backgroundColor('#F5F5F5');

      Button('Submit')
        .width('90%')
        .height(52)
        .onClick(() => {
          const invalidFields: string[] = [];

          if (this.isNumeric(this.firstField)) {
            invalidFields.push('First field');
          }

          if (this.isNumeric(this.secondField)) {
            invalidFields.push('Second field');
          }

          if (invalidFields.length > 0) {
            this.warningText = `${invalidFields.join(' and ')} must contain text (string), not a number.`;

            promptAction.showDialog({
              title: 'Warning',
              message: this.warningText,
              buttons: [
                {
                  text: 'OK',
                  color: '#333333',
                  action: () => {}
                }
              ]
            });
          } else {
            this.warningText = 'Form submitted successfully.';

            promptAction.showToast({
              message: 'Form submitted successfully.'
            });
          }
        });

      Text(this.warningText)
        .fontSize(14)
        .fontColor(this.warningText.includes('successfully') ? '#0A59F7' : '#D12E2E')
        .margin({ top: 16 })
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.Center);
  }
}