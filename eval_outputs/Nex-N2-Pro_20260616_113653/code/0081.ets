@Entry
@Component
struct Index {
  @State username: string = ''
  @State password: string = ''
  @State gender: string = 'male'

  build() {
    Column() {
      Text('Login')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40 })

      TextInput({ placeholder: 'Username', text: this.username })
        .type(InputType.Normal)
        .width('85%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ bottom: 16 })
        .onChange((value: string) => {
          this.username = value
        })

      TextInput({ placeholder: 'Password', text: this.password })
        .type(InputType.Password)
        .width('85%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ bottom: 24 })
        .onChange((value: string) => {
          this.password = value
        })

      Text('Gender')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .alignSelf(HorizontalAlign.Start)
        .margin({ left: 20 })

      Row() {
        Radio({ name: 'male', group: 'gender' })
          .selected(this.gender === 'male')
          .width(20)
          .height(20)
          .margin({ right: 8 })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.gender = 'male'
            }
          })

        Text('male')
          .fontSize(16)
      }
      .width('85%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 12 })

      Row() {
        Radio({ name: 'female', group: 'gender' })
          .selected(this.gender === 'female')
          .width(20)
          .height(20)
          .margin({ right: 8 })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.gender = 'female'
            }
          })

        Text('female')
          .fontSize(16)
      }
      .width('85%')
      .alignItems(VerticalAlign.Center)

      Button('Login')
        .width('85%')
        .height(50)
        .margin({ top: 32 })
        .onClick(() => {
          console.info(`Username: ${this.username}, Gender: ${this.gender}`)
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}