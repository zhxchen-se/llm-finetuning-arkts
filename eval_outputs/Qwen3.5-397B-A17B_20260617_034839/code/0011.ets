@Entry
@Component
struct Index {
  @State message: string = 'hello world'

  aboutToAppear() {
    console.info('hello world')
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}