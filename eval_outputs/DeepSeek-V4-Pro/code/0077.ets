import { router } from '@kit.ArkUI';

@Component
struct CustomInput {
  @Link value: string;
  @Prop placeholder: string = '';
  @Prop inputType: string = 'text'; // 'text', 'email', 'phone', 'number'
  @Prop borderColorNormal: ResourceColor = '#cccccc';
  @Prop borderColorFocus: ResourceColor = '#007AFF';
  @Prop borderColorError: ResourceColor = '#FF3B30';
  @State errorMessage: string = '';
  @State isFocused: boolean = false;

  validate(): string {
    if (this.inputType === 'email') {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!this.value.trim()) return 'Email is required';
      if (!emailRegex.test(this.value)) return 'Invalid email format';
      return '';
    } else if (this.inputType === 'phone') {
      const phoneRegex = /^\d{10}$/;
      if (!this.value.trim()) return 'Phone number is required';
      if (!phoneRegex.test(this.value)) return 'Phone must be 10 digits';
      return '';
    } else if (this.inputType === 'number') {
      if (!this.value.trim()) return 'Number is required';
      if (isNaN(Number(this.value))) return 'Must be a valid number';
      return '';
    } else { // text
      if (!this.value.trim()) return 'This field is required';
      return '';
    }
  }

  build() {
    Column() {
      TextInput({ placeholder: this.placeholder, text: this.value })
        .onChange((value: string) => {
          this.value = value;
          if (this.errorMessage) {
            this.errorMessage = ''; // clear error on typing
          }
        })
        .onFocus(() => {
          this.isFocused = true;
        })
        .onBlur(() => {
          this.isFocused = false;
          this.errorMessage = this.validate();
        })
        .borderRadius(10)
        .borderWidth(1)
        .borderColor(this.errorMessage ? this.borderColorError : (this.isFocused ? this.borderColorFocus : this.borderColorNormal))
        .padding(10)
        .width('100%')
        .backgroundColor(Color.White)
      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(12)
          .fontColor(Color.Red)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .padding({ bottom: 16 })
  }
}

@Entry
@Component
struct Index {
  @State name: string = '';
  @State email: string = '';
  @State phone: string = '';
  @State number: string = '';
  @State allValid: boolean = false;

  validateAll(): boolean {
    // Trigger validation for all fields by simulating blur? We'll just check manually.
    // We'll use the same validation logic as in CustomInput, but we can't call methods directly.
    // Instead, we'll check conditions.
    let valid = true;
    if (!this.name.trim()) valid = false;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!this.email.trim() || !emailRegex.test(this.email)) valid = false;
    const phoneRegex = /^\d{10}$/;
    if (!this.phone.trim() || !phoneRegex.test(this.phone)) valid = false;
    if (!this.number.trim() || isNaN(Number(this.number))) valid = false;
    return valid;
  }

  build() {
    Column() {
      Text('Custom Input Fields')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)

      CustomInput({ value: $name, placeholder: 'Enter your name', inputType: 'text' })
      CustomInput({ value: $email, placeholder: 'Enter your email', inputType: 'email' })
      CustomInput({ value: $phone, placeholder: 'Enter phone (10 digits)', inputType: 'phone' })
      CustomInput({ value: $number, placeholder: 'Enter a number', inputType: 'number' })

      Button('Submit')
        .width('100%')
        .margin({ top: 20 })
        .onClick(() => {
          if (this.validateAll()) {
            AlertDialog.show({ message: 'All inputs are valid!' });
          } else {
            AlertDialog.show({ message: 'Please fix the errors.' });
          }
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#f5f5f5')
  }
}