@Entry
@Component
struct Index {
  @State isLoggedIn: boolean = false
  @State username: string = ''
  @State password: string = ''
  @State rememberMe: boolean = false

  build() {
    Column() {
      if (this.isLoggedIn) {
        HomeScreen({
          username: this.username,
          onLogout: () => {
            this.isLoggedIn = false
            this.password = ''
          }
        })
      } else {
        LoginScreen({
          username: this.username,
          password: this.password,
          rememberMe: this.rememberMe,
          onUsernameChange: (value: string) => {
            this.username = value
          },
          onPasswordChange: (value: string) => {
            this.password = value
          },
          onRememberMeChange: (value: boolean) => {
            this.rememberMe = value
          },
          onLogin: () => {
            this.isLoggedIn = true
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
  }
}

@Component
struct LoginScreen {
  @Prop username: string = ''
  @Prop password: string = ''
  @Prop rememberMe: boolean = false

  onUsernameChange: (value: string) => void = () => {}
  onPasswordChange: (value: string) => void = () => {}
  onRememberMeChange: (value: boolean) => void = () => {}
  onLogin: () => void = () => {}

  @State loginError: string = ''

  validateLogin(): boolean {
    if (this.username.trim().length === 0 || this.password.trim().length === 0) {
      this.loginError = 'Please enter username and password.'
      return false
    }

    this.loginError = ''
    return true
  }

  build() {
    Column() {
      Text('Login')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ bottom: 32 })

      TextInput({ placeholder: 'Username', text: this.username })
        .width('85%')
        .height(48)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.loginError = ''
          this.onUsernameChange(value)
        })

      TextInput({ placeholder: 'Password', text: this.password, type: InputType.Password })
        .width('85%')
        .height(48)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })
        .onChange((value: string) => {
          this.loginError = ''
          this.onPasswordChange(value)
        })

      Row() {
        Checkbox({ name: 'Remember Me', group: 'remember', checked: this.rememberMe })
          .onChange((isChecked: boolean) => {
            this.onRememberMeChange(isChecked)
          })

        Text('Remember Me')
          .fontSize(14)
          .fontColor('#4B5563')
      }
      .width('85%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 18 })

      if (this.loginError.length > 0) {
        Text(this.loginError)
          .fontSize(14)
          .fontColor('#E60012')
          .width('85%')
          .margin({ top: 12 })
      }

      Button('Login')
        .width('85%')
        .height(50)
        .backgroundColor('#007DFF')
        .borderRadius(12)
        .margin({ top: 24 })
        .onClick(() => {
          if (this.validateLogin()) {
            this.onLogin()
          }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 32, right: 32, top: 48, bottom: 24 })
  }
}

@Component
struct HomeScreen {
  @Prop username: string = ''
  onLogout: () => void = () => {}

  build() {
    Column() {
      Text('Home')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')

      Text(`Welcome, ${this.username.trim()}!`)
        .fontSize(22)
        .fontColor('#374151')
        .margin({ top: 16 })

      Text('You have successfully logged in.')
        .fontSize(16)
        .fontColor('#6B7280')
        .margin({ top: 12 })

      Button('Logout')
        .width('85%')
        .height(50)
        .backgroundColor('#007DFF')
        .borderRadius(12)
        .margin({ top: 40 })
        .onClick(() => {
          this.onLogout()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(32)
  }
}