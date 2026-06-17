@Entry
@Component
struct Index {
  @State selectedOption: string = 'Option 1'

  private options: string[] = ['Option 1', 'Option 2', 'Option 3', 'Option 4']

  build() {
    Column() {
      Text('Drop Down Menu')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#182431')
        .margin({ bottom: 40 })

      Select({
        value: this.selectedOption,
        placeholder: 'Choose an option'
      }) {
        ForEach(this.options, (option: string) => {
          Option(option, option)
            .fontSize(16)
            .fontColor('#182431')
        })
      }
      .width('80%')
      .height(56)
      .fontSize(16)
      .fontColor('#182431')
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .padding({ left: 16, right: 16 })
      .optionMenuAlign(Align.Top)
      .onChange((value: string) => {
        this.selectedOption = value
      })

      Text('Selected: ' + this.selectedOption)
        .fontSize(18)
        .fontColor('#666666')
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
  }
}