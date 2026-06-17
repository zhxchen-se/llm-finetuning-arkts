@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Grape'];

  build() {
    Column() {
      ForEach(this.fruits, (fruit: string) => {
        Row() {
          Text(fruit)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Image($r('app.media.icon'))
            .width(50)
            .height(50)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(12)
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}