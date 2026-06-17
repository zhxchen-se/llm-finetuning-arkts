import { InputType } from '@ohos/arkui';

@Component
struct ValidatedInput {
  @Link text: string;
  @State isError: boolean = false;
  placeholder: string;
  inputType: InputType;
  validationRegex?: RegExp;
  errorMessage: string;
  label: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(14)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 5 })

      TextInput({ placeholder: this.placeholder, text: this.text })
        .type(this.inputType)
        .width('100%')
        .height(50)
        .padding({ left: 15, right: 15 })
        .borderRadius(12)
        .border({
          width: 1,
          color: this.isError ? '#ff0000' : '#cccccc',
          radius: 12
        })
        .backgroundColor(this.isError ? '#fff5f5' : '#ffffff')
        .onChange((value: string) => {
          this.text = value;
          if (this.validationRegex) {
            this.isError = !this.validationRegex.test(value) && value.length > 0;
          } else {
            this.isError = false;
          }
        })
        .onBlur(() => {
          if (this.validationRegex && this.text.length > 0) {
            this.isError = !this.validationRegex.test(this.text);
          }
        })

      if (this.isError) {
        Text(this.errorMessage)
          .fontSize(12)
          .fontColor('#ff0000')
          .alignSelf(ItemAlign.Start)
          .margin({ top: 5 })
      }
    }
    .width('100%')
    .margin({ bottom: 20 })
  }
}

@Entry
@Component
struct Index {
  @State username: string = '';
  @State email: string = '';
  @State password: string = '';
  @State phone: string = '';
  @State isFormValid: boolean = false;

  aboutToAppear() {
  }

  build() {
    Column() {
      Text('Custom Input Fields')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 30 })

      ValidatedInput({
        text: $username,
        placeholder: 'Enter username',
        inputType: InputType.Normal,
        label: 'Username',
        errorMessage: 'Username cannot be empty'
      })

      ValidatedInput({
        text: $email,
        placeholder: 'Enter email address',
        inputType: InputType.Email,
        validationRegex: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        label: 'Email',
        errorMessage: 'Please enter a valid email address'
      })

      ValidatedInput({
        text: $password,
        placeholder: 'Enter password',
        inputType: InputType.Password,
        validationRegex: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/,
        label: 'Password',
        errorMessage: 'Min 6 chars, must include letter and number'
      })

      ValidatedInput({
        text: $phone,
        placeholder: 'Enter phone number',
        inputType: InputType.Number,
        validationRegex: /^\d{10,15}$/,
        label: 'Phone Number',
        errorMessage: 'Please enter a valid phone number (10-15 digits)'
      })

      Button('Submit')
        .width('100%')
        .height(50)
        .borderRadius(12)
        .backgroundColor('#007dff')
        .fontColor('#ffffff')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 20 })
        .onClick(() => {
          // Force validation check
          if (this.username.length > 0 &&
              /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.email) &&
              /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/.test(this.password) &&
              /^\d{10,15}$/.test(this.phone)) {
            this.isFormValid = true;
            alert('Form Submitted Successfully!');
          } else {
            this.isFormValid = false;
            alert('Please correct the errors in the form.');
          }
        })

      if (this.isFormValid) {
        Text('All fields validated successfully!')
          .fontSize(14)
          .fontColor('#00aa00')
          .margin({ top: 15 })
      }
    }
    .width('100%')
    .padding(20)
  }
}