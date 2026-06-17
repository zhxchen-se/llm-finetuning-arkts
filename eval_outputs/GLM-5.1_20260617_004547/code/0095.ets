@Entry
@Component
struct Index {
  @State isToggled: boolean = false

  build() {
    Column() {
      Text('Toggle Component Example')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })

      Row() {
        Text('Switch Status:')
          .fontSize(20)
          .margin({ right: 20 })

        Toggle({ type: ToggleType.Switch, isOn: this.isToggled })
          .selectedColor('#007DFF')
          .switchStyle({ trackBorderRadius: 20 })
          .onChange((isOn: boolean) => {
            this.isToggled = isOn
          })
      }
      .margin({ bottom: 30 })

      Text(`Current State: ${this.isToggled ? 'ON' : 'OFF'}`)
        .fontSize(20)
        .fontColor(this.isToggled ? '#007DFF' : '#000000')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}