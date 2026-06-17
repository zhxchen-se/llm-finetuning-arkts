@Entry
@Component
struct Index {
  @State message: string = 'This text will be removed when you tap the Refresh button.';

  build() {
    Column() {
      if (this.message !== '') {
        Text(this.message)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 24 })
      }

      Button('Refresh')
        .onClick(() => {
          this.message = '';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}