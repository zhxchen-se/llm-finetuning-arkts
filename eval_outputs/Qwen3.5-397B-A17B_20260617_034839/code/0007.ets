@Entry
@Component
struct Index {
  @State displayText: string = 'Hello HarmonyOS!';

  build() {
    Column() {
      Text(this.displayText)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 50 })

      Button('Refresh')
        .onClick(() => {
          this.displayText = '';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}