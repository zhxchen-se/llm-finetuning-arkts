import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State gender: string = 'male';

  build() {
    Column() {
      Text('Login')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      TextInput({ placeholder: 'Username', text: this.username })
        .onChange((value: string) => {
          this.username = value;
        })
        .margin({ bottom: 10 });

      TextInput({ placeholder: 'Password', text: this.password })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
        .margin({ bottom: 20 });

      Text('Gender')
        .fontSize(18)
        .margin({ bottom: 10 });

      Row() {
        Radio({ value: 'male', group: 'genderGroup', checked: this.gender === 'male' })
          .checkedColor('#007DFF')
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.gender = 'male';
            }
          });
        Text('Male')
          .margin({ left: 5, right: 20 });

        Radio({ value: 'female', group: 'genderGroup', checked: this.gender === 'female' })
          .checkedColor('#007DFF')
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.gender = 'female';
            }
          });
        Text('Female')
          .margin({ left: 5 });
      }
      .margin({ bottom: 20 });

      Button('Login')
        .width('100%')
        .onClick(() => {
          promptAction.showToast({
            message: `Username: ${this.username}, Gender: ${this.gender}`
          });
        });
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center);
  }
}