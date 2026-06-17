import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State input1: string = '';
  @State input2: string = '';

  // Check if a string represents a number (including integers and decimals)
  isNumeric(value: string): boolean {
    const trimmed = value.trim();
    if (trimmed === '') {
      return false;
    }
    return !isNaN(Number(trimmed));
  }

  // Handle form submission
  handleSubmit() {
    if (this.isNumeric(this.input1) || this.isNumeric(this.input2)) {
      // Warn the user with a prompt
      promptAction.showDialog({
        title: 'Invalid Input',
        message: 'Please enter a string, not a number.',
        buttons: [
          {
            text: 'OK',
            color: '#007DFF'
          }
        ]
      });
    } else {
      // Both fields contain non-numeric strings – proceed
      promptAction.showToast({
        message: 'Form submitted successfully!',
        duration: 2000
      });
      // Optionally clear fields
      this.input1 = '';
      this.input2 = '';
    }
  }

  build() {
    Column() {
      Text('Submit Form')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      TextInput({ placeholder: 'Enter first value (string)' })
        .onChange((value: string) => {
          this.input1 = value;
        })
        .margin({ bottom: 10 })
        .width('80%');

      TextInput({ placeholder: 'Enter second value (string)' })
        .onChange((value: string) => {
          this.input2 = value;
        })
        .margin({ bottom: 20 })
        .width('80%');

      Button('Submit')
        .onClick(() => {
          this.handleSubmit();
        })
        .width('60%')
        .backgroundColor('#007DFF')
        .fontColor(Color.White);
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20);
  }
}