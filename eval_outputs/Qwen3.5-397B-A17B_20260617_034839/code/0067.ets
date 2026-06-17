@Entry
@Component
struct Index {
  @State backgroundColor: string = '#FFFFFF'

  build() {
    Column() {
      Text('Click the button to change color')
        .fontSize(20)
        .margin({ bottom: 20 })

      Box()
        .width(200)
        .height(200)
        .backgroundColor(this.backgroundColor)
        .borderRadius(10)
        .margin({ bottom: 20 })

      Button('Change Background Color')
        .onClick(() => {
          if (this.backgroundColor === '#FFFFFF') {
            this.backgroundColor = '#007DFF'
          } else {
            this.backgroundColor = '#FFFFFF'
          }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}