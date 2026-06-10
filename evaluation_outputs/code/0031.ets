import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State rememberMe: boolean = false;

  build() {
    Column() {
      // Title
      Text('Login')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      // Username field
      TextInput({ placeholder: 'Username' })
        .onChange((value: string) => {
          this.username = value;
        })
        .width('80%')
        .margin({ bottom: 15 })

      // Password field
      TextInput({ placeholder: 'Password' })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
        .width('80%')
        .margin({ bottom: 15 })

      // Remember Me checkbox
      Row() {
        Checkbox({ name: 'remember', group: 'rememberGroup' })
          .select(this.rememberMe)
          .onChange((value: boolean) => {
            this.rememberMe = value;
          })
        Text('Remember Me')
          .fontSize(16)
          .margin({ left: 5 })
      }
      .width('80%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 25 })

      // Login button
      Button('Login')
        .width('80%')
        .height(45)
        .fontSize(18)
        .onClick(() => {
          if (this.username.trim() === '' || this.password.trim() === '') {
            promptAction.showToast({
              message: 'Username and password cannot be empty',
              duration: 2000
            });
            return;
          }
          // Simulate successful login
          // Navigate to home screen
          router.pushUrl({
            url: 'pages/Home'
          }).catch((err: Error) => {
            promptAction.showToast({
              message: 'Navigation failed: ' + err.message,
              duration: 2000
            });
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}