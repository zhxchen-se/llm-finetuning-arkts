import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';
  @State isButtonEnabled: boolean = false;
  @State emailError: string = '';
  @State passwordError: string = '';

  // Email validation regex
  private emailRegex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // Validate email and update error
  private validateEmail(): boolean {
    if (this.email.trim().length === 0) {
      this.emailError = 'Email is required';
      return false;
    } else if (!this.emailRegex.test(this.email)) {
      this.emailError = 'Please enter a valid email address';
      return false;
    } else {
      this.emailError = '';
      return true;
    }
  }

  // Validate password and update error
  private validatePassword(): boolean {
    if (this.password.length === 0) {
      this.passwordError = 'Password is required';
      return false;
    } else if (this.password.length < 8) {
      this.passwordError = 'Password must be at least 8 characters';
      return false;
    } else {
      this.passwordError = '';
      return true;
    }
  }

  // Update overall form validity
  private updateFormValidity(): void {
    const emailValid = this.validateEmail();
    const passwordValid = this.validatePassword();
    this.isButtonEnabled = emailValid && passwordValid;
  }

  // Handle email input change
  private onEmailChange(value: string): void {
    this.email = value;
    this.updateFormValidity();
  }

  // Handle password input change
  private onPasswordChange(value: string): void {
    this.password = value;
    this.updateFormValidity();
  }

  // Submit action
  private onSubmit(): void {
    promptAction.showToast({
      message: 'Form submitted successfully!',
      duration: 2000
    });
    // Here you would typically send data to a server
  }

  build() {
    Column() {
      // Title
      Text('Login')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .textAlign(TextAlign.Center)

      // Email field
      Column() {
        Text('Email')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 5 })
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: 'Enter your email', text: this.email })
          .type(InputType.Normal)
          .onChange((value: string) => {
            this.onEmailChange(value);
          })
          .width('100%')
          .height(40)
          .borderRadius(8)
          .backgroundColor('#F5F5F5')
          .padding({ left: 12, right: 12 })

        if (this.emailError) {
          Text(this.emailError)
            .fontSize(12)
            .fontColor('#FF0000')
            .margin({ top: 4 })
            .alignSelf(ItemAlign.Start)
        }
      }
      .width('100%')
      .margin({ bottom: 20 })

      // Password field
      Column() {
        Text('Password')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 5 })
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: 'Enter your password', text: this.password })
          .type(InputType.Password)
          .onChange((value: string) => {
            this.onPasswordChange(value);
          })
          .width('100%')
          .height(40)
          .borderRadius(8)
          .backgroundColor('#F5F5F5')
          .padding({ left: 12, right: 12 })

        if (this.passwordError) {
          Text(this.passwordError)
            .fontSize(12)
            .fontColor('#FF0000')
            .margin({ top: 4 })
            .alignSelf(ItemAlign.Start)
        }
      }
      .width('100%')
      .margin({ bottom: 30 })

      // Submit button
      Button('Submit')
        .width('100%')
        .height(45)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .enabled(this.isButtonEnabled)
        .backgroundColor(this.isButtonEnabled ? '#007AFF' : '#CCCCCC')
        .borderRadius(8)
        .onClick(() => {
          this.onSubmit();
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20, top: 40 })
    .justifyContent(FlexAlign.Start)
    .backgroundColor('#FFFFFF')
  }
}