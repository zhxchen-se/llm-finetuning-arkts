@Entry
@Component
struct Index {
  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text('First item')
        .fontSize(24)
        .fontColor('#1E88E5')

      Text('Second item')
        .fontSize(20)
        .fontColor('#43A047')

      Text('Third item')
        .fontSize(18)
        .fontColor('#F4511E')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.Start)
    .alignItems(FlexAlign.Start)
    .backgroundColor('#F5F7FA')
  }
}