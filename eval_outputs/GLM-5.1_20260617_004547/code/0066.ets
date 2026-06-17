@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''
  @State isEmailValid: boolean = false
  @State isPasswordValid: boolean = false
  @State isFormValid: boolean = false

  validateForm() {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
    this.isEmailValid = emailRegex.test(this.email)
    this.isPasswordValid = this.password.length >= 8
    this.isFormValid = this.isEmailValid && this.isPasswordValid
  }

  build() {
    Column() {
      Text('Login Form')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      TextInput({ placeholder: 'Email' })
        .type(InputType.Email)
        .width('100%')
        .height(50)
        .padding({ left: 15, right: 15 })
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
        .onChange((value: string) => {
          this.email = value
          this.validateForm()
        })
        .margin({ bottom: (!this.isEmailValid && this.email.length > 0) ? 5 : 15 })

      if (!this.isEmailValid && this.email.length > 0) {
        Text('Please enter a valid email address')
          .fontSize(12)
          .fontColor('#FF0000')
          .margin({ bottom: 15 })
          .width('100%')
          .padding({ left: 15 })
      }

      TextInput({ placeholder: 'Password' })
        .type(InputType.Password)
        .width('100%')
        .height(50)
        .padding({ left: 15, right: 15 })
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
        .onChange((value: string) => {
          this.password = value
          this.validateForm()
        })
        .margin({ bottom: (!this.isPasswordValid && this.password.length > 0) ? 5 : 15 })

      if (!this.isPasswordValid && this.password.length > 0) {
        Text('Password must be at least 8 characters')
          .fontSize(12)
          .fontColor('#FF0000')
          .margin({ bottom: 15 })
          .width('100%')
          .padding({ left: 15 })
      }

      Button('Submit')
        .width('100%')
        .height(50)
        .borderRadius(8)
        .fontSize(18)
        .fontColor(Color.White)
        .enabled(this.isFormValid)
        .backgroundColor(this.isFormValid ? '#007DFF' : '#CCCCCC')
        .onClick(() => {
          console.info('Form submitted: Email=' + this.email + ', Password=' + this.password)
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.Center)
  }
}