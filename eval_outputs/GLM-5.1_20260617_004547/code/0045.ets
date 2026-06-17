@Entry
@Component
struct Index {
  @State selectedRadio: number = 0

  build() {
    Column({ space: 40 }) {
      Row({ space: 20 }) {
        Button('Button 1')
          .width(100)
          .height(40)
          .onClick(() => {
            this.selectedRadio = 1
          })

        Button('Radio 1')
          .type(this.selectedRadio === 1 ? ButtonType.Normal : ButtonType.Capsule)
          .backgroundColor(this.selectedRadio === 1 ? Color.Red : Color.Gray)
          .borderRadius(this.selectedRadio === 1 ? 10 : 0)
          .width(120)
          .height(40)
          .animation({ duration: 300 })
      }

      Row({ space: 20 }) {
        Button('Button 2')
          .width(100)
          .height(40)
          .onClick(() => {
            this.selectedRadio = 2
          })

        Button('Radio 2')
          .type(this.selectedRadio === 2 ? ButtonType.Normal : ButtonType.Circle)
          .backgroundColor(this.selectedRadio === 2 ? Color.Red : Color.Gray)
          .borderRadius(this.selectedRadio === 2 ? 10 : 0)
          .width(this.selectedRadio === 2 ? 120 : 90)
          .height(this.selectedRadio === 2 ? 40 : 90)
          .animation({ duration: 300 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}