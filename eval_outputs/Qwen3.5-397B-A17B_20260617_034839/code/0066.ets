@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';
  @State isValid: boolean = false;
  @State emailError: string = '';
  @State passwordError: string = '';

  validateForm() {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const isEmailValid = emailRegex.test(this.email);
    const isPasswordValid = this.password.length >= 8;

    this.emailError = isEmailValid ? '' : 'Invalid email format';
    this.passwordError = isPasswordValid ? '' : 'Password must be at least 8 characters';

    this.isValid = isEmailValid && isPasswordValid;
  }

  build() {
    Column() {
      Text('Login Form')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Column() {
        Text('Email')
          .fontSize(14)
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 5 })

        TextInput({ placeholder: 'Enter your email', text: this.email })
          .type(InputType.Email)
          .onChange((value: string) => {
            this.email = value;
            this.validateForm();
          })
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .padding(10)
          .width('100%')

        Text(this.emailError)
          .fontSize(12)
          .fontColor('#FF0000')
          .alignSelf(ItemAlign.Start)
          .margin({ top: 5 })
          .visibility(this.emailError ? Visibility.Visible : Visibility.Hidden)
      }
      .width('90%')
      .margin({ bottom: 20 })

      Column() {
        Text('Password')
          .fontSize(14)
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 5 })

        TextInput({ placeholder: 'Enter your password', text: this.password })
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value;
            this.validateForm();
          })
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .padding(10)
          .width('100%')

        Text(this.passwordError)
          .fontSize(12)
          .fontColor('#FF0000')
          .alignSelf(ItemAlign.Start)
          .margin({ top: 5 })
          .visibility(this.passwordError ? Visibility.Visible : Visibility.Hidden)
      }
      .width('90%')
      .margin({ bottom: 30 })

      Button('Submit')
        .width('90%')
        .height(45)
        .backgroundColor(this.isValid ? '#007DFF' : '#CCCCCC')
        .enabled(this.isValid)
        .onClick(() => {
          console.info('Form submitted successfully');
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}