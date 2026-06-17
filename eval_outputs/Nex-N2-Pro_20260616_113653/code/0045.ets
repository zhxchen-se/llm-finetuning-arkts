@Entry
@Component
struct Index {
  @State radio1Selected: boolean = true
  @State radio2Selected: boolean = true

  build() {
    Column() {
      Text('Radio Button Control Demo')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 32 })

      Row() {
        Text('radio1')
          .fontSize(20)
          .margin({ right: 12 })

        Radio({ name: 'radio1', group: 'group1', value: 1 })
          .type(RadioType.Radio)
          .selected(this.radio1Selected)
          .selectedColor('#FF0000')
          .unSelectedColor('#AAAAAA')
          .onChange((value: boolean) => {
            this.radio1Selected = value
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 20 })

      Button() {
        Text(this.radio1Selected ? 'button1 on' : 'button1 off')
          .fontSize(18)
          .fontColor('#FFFFFF')
      }
      .type(this.radio1Selected ? ButtonType.Normal : ButtonType.Capsule)
      .backgroundColor(this.radio1Selected ? '#FF0000' : '#3B82F6')
      .width(180)
      .height(56)
      .onClick(() => {
        this.radio1Selected = !this.radio1Selected
      })
      .margin({ bottom: 28 })

      Row() {
        Text('radio2')
          .fontSize(20)
          .margin({ right: 12 })

        Radio({ name: 'radio2', group: 'group2', value: 1 })
          .type(RadioType.Radio)
          .selected(this.radio2Selected)
          .selectedColor('#FF0000')
          .unSelectedColor('#AAAAAA')
          .onChange((value: boolean) => {
            this.radio2Selected = value
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 20 })

      Button() {
        Text(this.radio2Selected ? 'button2 on' : 'button2 off')
          .fontSize(18)
          .fontColor('#FFFFFF')
      }
      .type(this.radio2Selected ? ButtonType.Normal : ButtonType.Circle)
      .backgroundColor(this.radio2Selected ? '#FF0000' : '#3B82F6')
      .width(120)
      .height(120)
      .onClick(() => {
        this.radio2Selected = !this.radio2Selected
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}