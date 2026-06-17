import { LengthMetrics } from '@ohos.arkui';

interface CustomInputProps {
  placeholder: string;
  inputType: InputType;
  icon?: ResourceStr;
  label: string;
  validationRule?: (value: string) => boolean;
  errorMessage?: string;
}

@Builder
function CustomTextInput(
  props: {
    placeholder: string;
    inputType: InputType;
    label: string;
    icon?: ResourceStr;
    errorMessage?: string;
    validationRule?: (value: string) => boolean;
    controller?: TextInputController;
  },
  state: {
    value: string;
    isValid: boolean;
    isFocused: boolean;
    hasInteracted: boolean;
  }
) {
  Column() {
    Text(props.label)
      .fontSize(14)
      .fontColor('#555555')
      .fontWeight(FontWeight.Medium)
      .margin({ bottom: 6 })

    Row() {
      if (props.icon) {
        Text(props.icon)
          .fontSize(18)
          .fontColor(state.isFocused ? '#6C63FF' : '#AAAAAA')
          .margin({ right: 10 })
      }

      TextInput({ placeholder: props.placeholder, controller: props.controller })
        .type(props.inputType)
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .placeholderColor('#BBBBBB')
        .placeholderFont({ size: 15 })
        .fontColor('#333333')
        .fontSize(15)
        .caretColor('#6C63FF')
        .onChange((val: string) => {
          state.value = val;
          if (state.hasInteracted && props.validationRule) {
            state.isValid = props.validationRule(val);
          }
        })
        .onFocus(() => {
          state.isFocused = true;
        })
        .onBlur(() => {
          state.isFocused = false;
          state.hasInteracted = true;
          if (props.validationRule) {
            state.isValid = props.validationRule(state.value);
          }
        })

      if (state.hasInteracted && state.value.length > 0 && props.validationRule) {
        Text(state.isValid ? '✓' : '✗')
          .fontSize(18)
          .fontColor(state.isValid ? '#4CAF50' : '#F44336')
          .margin({ left: 8 })
      }
    }
    .width('100%')
    .height(52)
    .padding({ left: 16, right: 16 })
    .borderRadius(16)
    .backgroundColor('#F8F8FC')
    .border({
      width: state.isFocused ? 2 : 1.5,
      color: state.hasInteracted && !state.isValid && state.value.length > 0
        ? '#F44336'
        : state.isFocused
          ? '#6C63FF'
          : '#E0E0E0',
      style: BorderStyle.Solid,
      radius: 16
    })
    .shadow(state.isFocused ? {
      radius: 12,
      color: '#1A6C63FF',
      offsetX: 0,
      offsetY: 2
    } : {
      radius: 0,
      color: Color.Transparent,
      offsetX: 0,
      offsetY: 0
    })
    .animation({ duration: 200, curve: Curve.EaseOut })

    if (state.hasInteracted && !state.isValid && state.value.length > 0 && props.errorMessage) {
      Text(props.errorMessage)
        .fontSize(12)
        .fontColor('#F44336')
        .margin({ top: 4, left: 4 })
        .transition(TransitionEffect.OPACITY.animation({ duration: 200 }))
    }
  }
  .width('100%')
  .alignItems(HorizontalAlign.Start)
}

@Entry
@Component
struct Index {
  @State nameValue: string = '';
  @State nameValid: boolean = true;
  @State nameFocused: boolean = false;
  @State nameInteracted: boolean = false;

  @State emailValue: string = '';
  @State emailValid: boolean = true;
  @State emailFocused: boolean = false;
  @State emailInteracted: boolean = false;

  @State phoneValue: string = '';
  @State phoneValid: boolean = true;
  @State phoneFocused: boolean = false;
  @State phoneInteracted: boolean = false;

  @State passwordValue: string = '';
  @State passwordValid: boolean = true;
  @State passwordFocused: boolean = false;
  @State passwordInteracted: boolean = false;

  @State confirmPasswordValue: string = '';
  @State confirmPasswordValid: boolean = true;
  @State confirmPasswordFocused: boolean = false;
  @State confirmPasswordInteracted: boolean = false;

  @State ageValue: string = '';
  @State ageValid: boolean = true;
  @State ageFocused: boolean = false;
  @State ageInteracted: boolean = false;

  @State websiteValue: string = '';
  @State websiteValid: boolean = true;
  @State websiteFocused: boolean = false;
  @State websiteInteracted: boolean = false;

  @State showToast: boolean = false;
  @State toastMessage: string = '';

  validateName(value: string): boolean {
    return value.length >= 2 && /^[a-zA-Z\s]+$/.test(value);
  }

  validateEmail(value: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
  }

  validatePhone(value: string): boolean {
    return /^\+?[\d\s\-()]{7,15}$/.test(value);
  }

  validatePassword(value: string): boolean {
    return value.length >= 8 && /[A-Z]/.test(value) && /[a-z]/.test(value) && /\d/.test(value);
  }

  validateConfirmPassword(value: string): boolean {
    return value.length > 0 && value === this.passwordValue;
  }

  validateAge(value: string): boolean {
    const num = parseInt(value);
    return !isNaN(num) && num >= 1 && num <= 150;
  }

  validateWebsite(value: string): boolean {
    return /^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-./?%&=]*)?$/.test(value);
  }

  isFormValid(): boolean {
    return this.validateName(this.nameValue) &&
      this.validateEmail(this.emailValue) &&
      this.validatePhone(this.phoneValue) &&
      this.validatePassword(this.passwordValue) &&
      this.validateConfirmPassword(this.confirmPasswordValue) &&
      this.validateAge(this.ageValue) &&
      this.validateWebsite(this.websiteValue);
  }

  triggerAllValidation() {
    this.nameInteracted = true;
    this.nameValid = this.validateName(this.nameValue);

    this.emailInteracted = true;
    this.emailValid = this.validateEmail(this.emailValue);

    this.phoneInteracted = true;
    this.phoneValid = this.validatePhone(this.phoneValue);

    this.passwordInteracted = true;
    this.passwordValid = this.validatePassword(this.passwordValue);

    this.confirmPasswordInteracted = true;
    this.confirmPasswordValid = this.validateConfirmPassword(this.confirmPasswordValue);

    this.ageInteracted = true;
    this.ageValid = this.validateAge(this.ageValue);

    this.websiteInteracted = true;
    this.websiteValid = this.validateWebsite(this.websiteValue);
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('📝')
          .fontSize(28)
        Text('Smart Form')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2D2B55')
          .margin({ left: 10 })
      }
      .width('100%')
      .padding({ left: 20, top: 16, bottom: 8 })

      Text('Custom input fields with validation')
        .fontSize(14)
        .fontColor('#888888')
        .width('100%')
        .padding({ left: 20, bottom: 16 })

      Scroll() {
        Column({ space: 18 }) {
          // Full Name
          CustomTextInput({
            placeholder: 'Enter your full name',
            inputType: InputType.Normal,
            label: 'Full Name',
            icon: '👤',
            errorMessage: 'Name must be at least 2 characters (letters only)',
            validationRule: (val: string) => this.validateName(val)
          }, {
            value: this.nameValue,
            isValid: this.nameValid,
            isFocused: this.nameFocused,
            hasInteracted: this.nameInteracted
          })

          // Email
          CustomTextInput({
            placeholder: 'example@domain.com',
            inputType: InputType.Email,
            label: 'Email Address',
            icon: '✉️',
            errorMessage: 'Please enter a valid email address',
            validationRule: (val: string) => this.validateEmail(val)
          }, {
            value: this.emailValue,
            isValid: this.emailValid,
            isFocused: this.emailFocused,
            hasInteracted: this.emailInteracted
          })

          // Phone
          CustomTextInput({
            placeholder: '+1 (555) 123-4567',
            inputType: InputType.PhoneNumber,
            label: 'Phone Number',
            icon: '📱',
            errorMessage: 'Please enter a valid phone number',
            validationRule: (val: string) => this.validatePhone(val)
          }, {
            value: this.phoneValue,
            isValid: this.phoneValid,
            isFocused: this.phoneFocused,
            hasInteracted: this.phoneInteracted
          })

          // Password
          Column() {
            CustomTextInput({
              placeholder: 'Min 8 chars, upper, lower, digit',
              inputType: InputType.Password,
              label: 'Password',
              icon: '🔒',
              errorMessage: 'Needs 8+ chars with upper, lower, and digit',
              validationRule: (val: string) => this.validatePassword(val)
            }, {
              value: this.passwordValue,
              isValid: this.passwordValid,
              isFocused: this.passwordFocused,
              hasInteracted: this.passwordInteracted
            })

            // Password strength indicator
            if (this.passwordValue.length > 0) {
              Row({ space: 4 }) {
                ForEach(['1', '2', '3', '4'], (item: string) => {
                  Row()
                    .width(0)
                    .height(4)
                    .flexGrow(1)
                    .borderRadius(2)
                    .backgroundColor(this.getPasswordStrengthColor(parseInt(item)))
                    .animation({ duration: 300, curve: Curve.EaseOut })
                }, (item: string) => item)
              }
              .width('100%')
              .margin({ top: 6 })

              Text(this.getPasswordStrengthLabel())
                .fontSize(11)
                .fontColor(this.getPasswordStrengthColor(0))
                .margin({ top: 2 })
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Confirm Password
          CustomTextInput({
            placeholder: 'Re-enter your password',
            inputType: InputType.Password,
            label: 'Confirm Password',
            icon: '🔐',
            errorMessage: 'Passwords do not match',
            validationRule: (val: string) => this.validateConfirmPassword(val)
          }, {
            value: this.confirmPasswordValue,
            isValid: this.confirmPasswordValid,
            isFocused: this.confirmPasswordFocused,
            hasInteracted: this.confirmPasswordInteracted
          })

          // Age
          CustomTextInput({
            placeholder: 'Enter your age',
            inputType: InputType.Number,
            label: 'Age',
            icon: '🎂',
            errorMessage: 'Please enter a valid age (1-150)',
            validationRule: (val: string) => this.validateAge(val)
          }, {
            value: this.ageValue,
            isValid: this.ageValid,
            isFocused: this.ageFocused,
            hasInteracted: this.ageInteracted
          })

          // Website
          CustomTextInput({
            placeholder: 'https://example.com',
            inputType: InputType.URL,
            label: 'Website',
            icon: '🌐',
            errorMessage: 'Please enter a valid URL',
            validationRule: (val: string) => this.validateWebsite(val)
          }, {
            value: this.websiteValue,
            isValid: this.websiteValid,
            isFocused: this.websiteFocused,
            hasInteracted: this.websiteInteracted
          })

          // Validation Summary
          this.ValidationSummary()

          // Submit Button
          Button() {
            Row({ space: 8 }) {
              Text('Submit Form')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(Color.White)
              Text('→')
                .fontSize(18)
                .fontColor(Color.White)
            }
          }
          .width('100%')
          .height(54)
          .borderRadius(16)
          .backgroundColor(this.isFormValid() ? '#6C63FF' : '#C0BDE6')
          .enabled(this.isFormValid())
          .shadow(this.isFormValid() ? {
            radius: 16,
            color: '#336C63FF',
            offsetX: 0,
            offsetY: 6
          } : {
            radius: 0,
            color: Color.Transparent,
            offsetX: 0,
            offsetY: 0
          })
          .animation({ duration: 300, curve: Curve.EaseOut })
          .onClick(() => {
            this.triggerAllValidation();
            if (this.isFormValid()) {
              this.toastMessage = '✅ Form submitted successfully!';
              this.showToast = true;
              setTimeout(() => { this.showToast = false; }, 2500);
            } else {
              this.toastMessage = '❌ Please fix the errors above';
              this.showToast = true;
              setTimeout(() => { this.showToast = false; }, 2500);
            }
          })

          // Reset Button
          Button('Reset Form')
            .width('100%')
            .height(48)
            .borderRadius(16)
            .backgroundColor(Color.Transparent)
            .fontColor('#6C63FF')
            .fontWeight(FontWeight.Medium)
            .border({ width: 1.5, color: '#6C63FF', style: BorderStyle.Solid, radius: 16 })
            .onClick(() => {
              this.nameValue = ''; this.nameValid = true; this.nameInteracted = false;
              this.emailValue = ''; this.emailValid = true; this.emailInteracted = false;
              this.phoneValue = ''; this.phoneValid = true; this.phoneInteracted = false;
              this.passwordValue = ''; this.passwordValid = true; this.passwordInteracted = false;
              this.confirmPasswordValue = ''; this.confirmPasswordValid = true; this.confirmPasswordInteracted = false;
              this.ageValue = ''; this.ageValid = true; this.ageInteracted = false;
              this.websiteValue = ''; this.websiteValid = true; this.websiteInteracted = false;
            })

          Blank().height(40)
        }
        .padding({ left: 20, right: 20 })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  ValidationSummary() {
    Column() {
      Text('Validation Summary')
        .fontSize(15)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#2D2B55')
        .margin({ bottom: 10 })

      this.SummaryItem('Name', this.nameInteracted ? this.validateName(this.nameValue) : null)
      this.SummaryItem('Email', this.emailInteracted ? this.validateEmail(this.emailValue) : null)
      this.SummaryItem('Phone', this.phoneInteracted ? this.validatePhone(this.phoneValue) : null)
      this.SummaryItem('Password', this.passwordInteracted ? this.validatePassword(this.passwordValue) : null)
      this.SummaryItem('Confirm', this.confirmPasswordInteracted ? this.validateConfirmPassword(this.confirmPasswordValue) : null)
      this.SummaryItem('Age', this.ageInteracted ? this.validateAge(this.ageValue) : null)
      this.SummaryItem('Website', this.websiteInteracted ? this.validateWebsite(this.websiteValue) : null)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#F5F3FF')
    .border({ width: 1, color: '#E8E5FF', style: BorderStyle.Solid, radius: 16 })
  }

  @Builder
  SummaryItem(label: string, isValid: boolean | null) {
    Row() {
      Text(isValid === null ? '○' : isValid ? '✓' : '✗')
        .fontSize(14)
        .fontColor(isValid === null ? '#CCCCCC' : isValid ? '#4CAF50' : '#F44336')
        .margin({ right: 8 })
      Text(label)
        .fontSize(13)
        .fontColor(isValid === null ? '#AAAAAA' : isValid ? '#4CAF50' : '#F44336')
      Blank()
      Text(isValid === null ? 'Pending' : isValid ? 'Valid' : 'Invalid')
        .fontSize(11)
        .fontColor(isValid === null ? '#BBBBBB' : isValid ? '#4CAF50' : '#F44336')
        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
        .borderRadius(8)
        .backgroundColor(isValid === null ? '#EEEEEE' : isValid ? '#E8F5E9' : '#FFEBEE')
    }
    .width('100%')
    .height(32)
  }

  getPasswordStrength(): number {
    const val = this.passwordValue;
    if (val.length === 0) return 0;
    let strength = 0;
    if (val.length >= 6) strength++;
    if (val.length >= 8) strength++;
    if (/[A-Z]/.test(val) && /[a-z]/.test(val)) strength++;
    if (/\d/.test(val)) strength++;
    if (/[^A-Za-z0-9]/.test(val)) strength++;
    return Math.min(4, strength);
  }

  getPasswordStrengthColor(barIndex: number): string {
    const strength = this.getPasswordStrength();
    if (strength === 0) return '#E0E0E0';
    if (strength === 1) return '#F44336';
    if (strength === 2) return '#FF9800';
    if (strength === 3) return '#FFC107';
    return '#4CAF50';
  }

  getPasswordStrengthLabel(): string {
    const strength = this.getPasswordStrength();
    if (strength === 0) return '';
    if (strength === 1) return 'Weak';
    if (strength === 2) return 'Fair';
    if (strength === 3) return 'Good';
    return 'Strong';
  }
}