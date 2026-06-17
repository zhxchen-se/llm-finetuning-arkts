@Entry
@Component
struct Index {
  @State isLoggedIn: boolean = false
  @State username: string = ''
  @State password: string = ''
  @State rememberMe: boolean = false
  @State errorMessage: string = ''

  build() {
    Column() {
      if (this.isLoggedIn) {
        this.HomeScreen()
      } else {
        this.LoginScreen()
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
  }

  @Builder
  LoginScreen() {
    Column() {
      Text('Welcome Back')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 40 })

      TextInput({ placeholder: 'Username' })
        .width('100%')
        .height(45)
        .margin({ bottom: 15 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .onChange((value: string) => {
          this.username = value
          this.errorMessage = ''
        })

      TextInput({ placeholder: 'Password' })
        .type(InputType.Password)
        .width('100%')
        .height(45)
        .margin({ bottom: 15 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .onChange((value: string) => {
          this.password = value
          this.errorMessage = ''
        })

      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontColor(Color.Red)
          .fontSize(14)
          .margin({ bottom: 10 })
          .width('100%')
      }

      Row() {
        Checkbox()
          .select(this.rememberMe)
          .shape(CheckBoxShape.ROUNDED_SQUARE)
          .onChange((value: boolean) => {
            this.rememberMe = value
          })
        Text('Remember Me')
          .fontSize(16)
          .fontColor('#555555')
          .margin({ left: 8 })
          .onClick(() => {
            this.rememberMe = !this.rememberMe
          })
      }
      .width('100%')
      .margin({ bottom: 30 })
      .justifyContent(FlexAlign.Start)

      Button('Login')
        .width('100%')
        .height(45)
        .fontSize(18)
        .fontColor(Color.White)
        .backgroundColor('#007DFF')
        .borderRadius(8)
        .onClick(() => {
          if (!this.username || !this.password) {
            this.errorMessage = 'Please enter both username and password.'
            return
          }
          this.isLoggedIn = true
        })
    }
    .width('85%')
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .shadow({ radius: 15, color: '#D5D5D5', offsetY: 5 })
  }

  @Builder
  HomeScreen() {
    Column() {
      Text('Home')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 20 })

      Divider()
        .color('#E0E0E0')
        .margin({ bottom: 20 })

      Text(`Hello, ${this.username}!`)
        .fontSize(20)
        .fontColor('#555555')
        .margin({ bottom: 10 })

      if (this.rememberMe) {
        Text('You have chosen to be remembered.')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 40 })
      } else {
        Text('You did not choose to be remembered.')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 40 })
      }

      Button('Logout')
        .width('100%')
        .height(45)
        .fontSize(18)
        .fontColor(Color.White)
        .backgroundColor('#E84026')
        .borderRadius(8)
        .onClick(() => {
          this.isLoggedIn = false
          this.password = ''
          if (!this.rememberMe) {
            this.username = ''
          }
        })
    }
    .width('85%')
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .shadow({ radius: 15, color: '#D5D5D5', offsetY: 5 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}