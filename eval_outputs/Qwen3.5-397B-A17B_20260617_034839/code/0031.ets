import { router } from '@ohos.router';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State rememberMe: boolean = false;
  @State isLoggedIn: boolean = false;

  aboutToAppear() {
    // Simulate checking stored credentials if Remember Me was previously selected
    // In a real app, use preferences or database
  }

  build() {
    Column() {
      if (this.isLoggedIn) {
        // Home Screen View
        Column() {
          Text('Welcome Home!')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          Text(`User: ${this.username}`)
            .fontSize(18)
            .margin({ bottom: 40 })
          Button('Logout')
            .width('60%')
            .height(50)
            .backgroundColor('#E64A19')
            .onClick(() => {
              this.isLoggedIn = false;
              this.password = '';
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // Login Screen View
        Column() {
          Text('Login')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 50 })

          TextInput({ placeholder: 'Username', text: this.username })
            .width('80%')
            .height(50)
            .margin({ bottom: 20 })
            .onChange((value: string) => {
              this.username = value;
            })

          TextInput({ placeholder: 'Password', text: this.password })
            .type(InputType.Password)
            .width('80%')
            .height(50)
            .margin({ bottom: 20 })
            .onChange((value: string) => {
              this.password = value;
            })

          Row() {
            Checkbox({ name: 'rememberMe', group: 'loginGroup' })
              .select(this.rememberMe)
              .onChange((isChecked: boolean) => {
                this.rememberMe = isChecked;
              })
            Text('Remember Me')
              .fontSize(14)
              .margin({ left: 10 })
          }
          .width('80%')
          .justifyContent(FlexAlign.Start)
          .margin({ bottom: 40 })

          Button('Login')
            .width('80%')
            .height(50)
            .backgroundColor('#007DFF')
            .onClick(() => {
              if (this.username.length > 0 && this.password.length > 0) {
                this.isLoggedIn = true;
                // In a real app, validate credentials with server here
              } else {
                // Simple validation feedback could be added here
              }
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}