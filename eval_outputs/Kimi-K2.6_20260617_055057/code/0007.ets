@Entry
@Component
struct Index {
  @State displayText: string = 'Hello, this is a sample text on the screen.'

  build() {
    Column({ space: 20 }) {
      Text(this.displayText)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')

      Button('Refresh')
        .width(120)
        .height(40)
        .backgroundColor('#007DFF')
        .fontColor('#FFFFFF')
        .onClick(() => {
          this.displayText = ''
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}