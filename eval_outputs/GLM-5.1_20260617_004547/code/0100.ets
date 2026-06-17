@Entry
@Component
struct Index {
  build() {
    Column({ space: 15 }) {
      Circle()
        .width(150)
        .height(150)
        .fill(Color.Yellow)

      Text('shape circle')
        .fontSize(20)
        .fontColor(Color.Black)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}