@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'];

  build() {
    Column() {
      List() {
        ForEach(this.fruits, (fruit: string) => {
          ListItem() {
            Row() {
              Image($r('app.media.icon'))
                .width(40)
                .height(40)
                .margin({ right: 10 })
              Text(fruit)
                .fontSize(20)
            }
            .width('100%')
            .padding(10)
          }
        }, (fruit: string) => fruit)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}