import { State, InputType, FlexAlign, HorizontalAlign, FontWeight } from '@ohos.arkui';

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const MIN_PASSWORD_LENGTH = 8;

@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';
  @State emailError: string = '';
  @State passwordError: string = '';
  @State submitted: boolean = false;

  get isEmailValid(): boolean {
    return EMAIL_REGEX.test(this.email.trim());
  }

  get isPasswordValid(): boolean {
    return this.password.length >= MIN_PASSWORD_LENGTH;
  }

  get canSubmit(): boolean {
    return this.isEmailValid && this.isPasswordValid;
  }

  onEmailChange(value: string): void {
    this.email = value;
    this.submitted = false;

    if (!value.trim()) {
      this.emailError = 'Email is required.';
    } else if (!EMAIL_REGEX.test(value.trim())) {
      this.emailError = 'Enter a valid email address.';
    } else {
      this.emailError = '';
    }
  }

  onPasswordChange(value: string): void {
    this.password = value;
    this.submitted = false;

    if (value.length < MIN_PASSWORD_LENGTH) {
      this.passwordError = `Password must be at least ${MIN_PASSWORD_LENGTH} characters.`;
    } else {
      this.passwordError = '';
    }
  }

  onSubmit(): void {
    if (!this.canSubmit) {
      return;
    }

    this.submitted = true;
  }

  build() {
    Column() {
      Column() {
        Text('Sign In')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 8 })

        Text('Enter your email and password to continue.')
          .fontSize(15)
          .fontColor('#6B7280')
          .margin({ bottom: 28 })

        Column() {
          Text('Email')
            .fontSize(14)
            .fontColor('#374151')
            .margin({ bottom: 6 })

          TextInput({ placeholder: 'you@example.com' })
            .type(InputType.Email)
            .onChange((value: string) => this.onEmailChange(value))
            .width('100%')
            .height(52)
            .fontSize(16)
            .fontColor('#111827')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .padding({ left: 16, right: 16 })
            .border({
              width: 1,
              color: this.email.trim().length > 0 && !this.isEmailValid ? '#EF4444' : '#D1D5DB'
            })

          if (this.emailError) {
            Text(this.emailError)
              .fontSize(13)
              .fontColor('#EF4444')
              .margin({ top: 6 })
          }
        }
          .width('100%')
          .margin({ bottom: 18 })

        Column() {
          Text('Password')
            .fontSize(14)
            .fontColor('#374151')
            .margin({ bottom: 6 })

          TextInput({ placeholder: 'Password' })
            .type(InputType.Password)
            .onChange((value: string) => this.onPasswordChange(value))
            .width('100%')
            .height(52)
            .fontSize(16)
            .fontColor('#111827')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .padding({ left: 16, right: 16 })
            .border({
              width: 1,
              color: this.password.length > 0 && !this.isPasswordValid ? '#EF4444' : '#D1D5DB'
            })

          if (this.passwordError) {
            Text(this.passwordError)
              .fontSize(13)
              .fontColor('#EF4444')
              .margin({ top: 6 })
          }
        }
          .width('100%')
          .margin({ bottom: 24 })

        Button() {
          Text('Submit')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
          .width('100%')
          .height(52)
          .enabled(this.canSubmit)
          .backgroundColor(this.canSubmit ? '#2563EB' : '#CBD5E1')
          .borderRadius(12)
          .onClick(() => this.onSubmit())

        if (this.submitted) {
          Text('Submitted successfully.')
            .fontSize(14)
            .fontColor('#16A34A')
            .margin({ top: 16 })
        }
      }
        .width('100%')
        .maxWidth(420)
        .alignItems(HorizontalAlign.Start)
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(24)
      .backgroundColor('#F9FAFB')
  }
}