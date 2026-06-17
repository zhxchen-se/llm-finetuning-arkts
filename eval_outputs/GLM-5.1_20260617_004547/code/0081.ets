@Entry
@Component
struct Index {
  @State username: string = ''
  @State password: string = ''
  @State gender: string = 'male'

  build() {
    Column({ space: 20 }) {
      Text('Login')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      TextInput({ placeholder: 'Username', text: this.username })
        .type(InputType.Normal)
        .width('80%')
        .height(50)
        .onChange((value: string) => {
          this.username = value
        })

      TextInput({ placeholder: 'Password', text: this.password })
        .type(InputType.Password)
        .width('80%')
        .height(50)
        .onChange((value: string) => {
          this.password = value
        })

      Row({ space: 30 }) {
        Row({ space: 8 }) {
          Radio({ value: 'male', group: 'genderGroup' })
            .checked(this.gender === 'male')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.gender = 'male'
              }
            })
          Text('Male')
            .fontSize(18)
        }

        Row({ space: 8 }) {
          Radio({ value: 'female', group: 'genderGroup' })
            .checked(this.gender === 'female')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.gender = 'female'
              }
            })
          Text('Female')
            .fontSize(18)
        }
      }
      .margin({ top: 10, bottom: 20 })

      Button('Login')
        .width('80%')
        .height(50)
        .fontSize(18)
        .backgroundColor(Color.Blue)
        .onClick(() => {
          console.info(`Login attempt: Username=${this.username}, Gender=${this.gender}`)
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ left: 20, right: 20 })
  }
}