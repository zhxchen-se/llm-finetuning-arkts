import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State email: string = ''
  @State phone: string = ''
  @State username: string = ''
  @State password: string = ''

  @State emailError: string = ''
  @State phoneError: string = ''
  @State usernameError: string = ''
  @State passwordError: string = ''

  @State submitted: boolean = false

  build() {
    Column() {
      Text('Custom Text Input Fields')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ bottom: 8 })

      Text('Rounded corners, custom borders, placeholders and validation')
        .fontSize(14)
        .fontColor('#6B7280')
        .margin({ bottom: 32 })

      CustomInput({
        label: 'Email',
        placeholder: 'example@mail.com',
        text: this.email,
        inputType: InputType.Email,
        borderColor: this.emailError ? '#EF4444' : '#CBD5E1',
        borderRadius: 14,
        borderWidth: 1.5,
        errorText: this.emailError,
        onChange: (value: string) => {
          this.email = value
          this.emailError = this.validateEmail(value)
        }
      })
        .width('92%')
        .margin({ bottom: 18 })

      CustomInput({
        label: 'Phone Number',
        placeholder: '13800138000',
        text: this.phone,
        inputType: InputType.PhoneNumber,
        borderColor: this.phoneError ? '#EF4444' : '#CBD5E1',
        borderRadius: 14,
        borderWidth: 1.5,
        errorText: this.phoneError,
        onChange: (value: string) => {
          this.phone = value
          this.phoneError = this.validatePhone(value)
        }
      })
        .width('92%')
        .margin({ bottom: 18 })

      CustomInput({
        label: 'Username',
        placeholder: 'letters, numbers, 3-16 chars',
        text: this.username,
        inputType: InputType.Text,
        borderColor: this.usernameError ? '#EF4444' : '#CBD5E1',
        borderRadius: 14,
        borderWidth: 1.5,
        errorText: this.usernameError,
        onChange: (value: string) => {
          this.username = value
          this.usernameError = this.validateUsername(value)
        }
      })
        .width('92%')
        .margin({ bottom: 18 })

      CustomInput({
        label: 'Password',
        placeholder: 'At least 8 chars with number',
        text: this.password,
        inputType: InputType.Password,
        borderColor: this.passwordError ? '#EF4444' : '#CBD5E1',
        borderRadius: 14,
        borderWidth: 1.5,
        errorText: this.passwordError,
        onChange: (value: string) => {
          this.password = value
          this.passwordError = this.validatePassword(value)
        }
      })
        .width('92%')
        .margin({ bottom: 28 })

      Button('Validate Form')
        .width('92%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(this.isFormValid() ? '#2563EB' : '#94A3B8')
        .borderRadius(14)
        .onClick(() => {
          this.submitted = true

          this.emailError = this.validateEmail(this.email)
          this.phoneError = this.validatePhone(this.phone)
          this.usernameError = this.validateUsername(this.username)
          this.passwordError = this.validatePassword(this.password)
        })

      if (this.submitted && this.isFormValid()) {
        Text('All inputs are valid.')
          .fontSize(15)
          .fontColor('#16A34A')
          .margin({ top: 20 })
      } else if (this.submitted && !this.isFormValid()) {
        Text('Please fix the highlighted fields.')
          .fontSize(15)
          .fontColor('#DC2626')
          .margin({ top: 20 })
      }
    }
    .width('100%')
    .height('100%')
    .padding({ top: 64, left: 16, right: 16, bottom: 32 })
    .backgroundColor('#F8FAFC')
  }

  validateEmail(value: string): string {
    if (value.trim().length === 0) {
      return 'Email is required.'
    }

    const emailPattern: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailPattern.test(value.trim())) {
      return 'Enter a valid email address.'
    }

    return ''
  }

  validatePhone(value: string): string {
    if (value.trim().length === 0) {
      return 'Phone number is required.'
    }

    const phonePattern: RegExp = /^1[3-9]\d{9}$/
    if (!phonePattern.test(value.trim())) {
      return 'Enter a valid 11-digit phone number.'
    }

    return ''
  }

  validateUsername(value: string): string {
    if (value.trim().length === 0) {
      return 'Username is required.'
    }

    const usernamePattern: RegExp = /^[a-zA-Z0-9_]{3,16}$/
    if (!usernamePattern.test(value.trim())) {
      return 'Use 3-16 letters, numbers or underscores.'
    }

    return ''
  }

  validatePassword(value: string): string {
    if (value.length === 0) {
      return 'Password is required.'
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters.'
    }

    const numberPattern: RegExp = /\d/
    if (!numberPattern.test(value)) {
      return 'Password must contain at least one number.'
    }

    return ''
  }

  isFormValid(): boolean {
    return (
      this.validateEmail(this.email) === '' &&
      this.validatePhone(this.phone) === '' &&
      this.validateUsername(this.username) === '' &&
      this.validatePassword(this.password) === ''
    )
  }
}

@Component
struct CustomInput {
  label: string = ''
  placeholder: string = ''
  text: string = ''
  inputType: InputType = InputType.Text
  borderColor: ResourceColor = '#CBD5E1'
  borderRadius: number = 14
  borderWidth: number = 1.5
  errorText: string = ''
  onChange: (value: string) => void = () => {}

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#334155')

        Blank()
      }
      .width('100%')
      .margin({ bottom: 8 })

      TextInput({ placeholder: this.placeholder, text: this.text })
        .type(this.inputType)
        .placeholderColor('#94A3B8')
        .fontSize(15)
        .fontColor('#111827')
        .width('100%')
        .height(50)
        .padding({ left: 14, right: 14 })
        .backgroundColor('#FFFFFF')
        .borderRadius(this.borderRadius)
        .border({
          width: this.borderWidth,
          color: this.borderColor,
          style: BorderStyle.Solid
        })
        .onChange((value: string) => {
          this.onChange(value)
        })

      if (this.errorText.length > 0) {
        Text(this.errorText)
          .fontSize(12)
          .fontColor('#DC2626')
          .margin({ top: 6 })
          .width('100%')
      }
    }
    .width('100%')
  }
}