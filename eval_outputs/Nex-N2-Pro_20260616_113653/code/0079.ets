@Entry
@Component
struct Index {
  @State message: string = 'hello world';

  build() {
    Column() {
      Text(this.message)
        .fontSize(32)

      Button('Click me')
        .margin({ top: 20 })
        .onClick(() => {
          this.message = 'goodbye world';
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}