@Entry
@Component
struct Index {
  @State username: string = ''
  @State password: string = ''
  @State gender: string = 'Male'

  build() {
    Column() {
      Text('Login Page')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      TextInput({ placeholder: 'Username' })
        .width('80%')
        .height(45)
        .backgroundColor('#f1f1f1')
        .borderRadius(8)
        .padding(10)
        .margin({ bottom: 20 })
        .onChange((value: string) => {
          this.username = value
        })

      TextInput({ placeholder: 'Password' })
        .type(InputType.Password)
        .width('80%')
        .height(45)
        .backgroundColor('#f1f1f1')
        .borderRadius(8)
        .padding(10)
        .margin({ bottom: 30 })
        .onChange((value: string) => {
          this.password = value
        })

      Text('Gender')
        .fontSize(16)
        .margin({ bottom: 10 })
        .alignSelf(ItemAlign.Start)
        .margin({ left: '10%' })

      RadioGroup({ value: this.gender })
        .onChange((value: string) => {
          this.gender = value
        })
        .margin({ bottom: 30 })
      {
        Radio({ name: 'Male', value: 'Male' })
          .margin({ right: 20 })
        Radio({ name: 'Female', value: 'Female' })
      }

      Button('Login')
        .width('80%')
        .height(45)
        .backgroundColor('#007DFF')
        .fontColor('#ffffff')
        .borderRadius(8)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}