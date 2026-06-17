@Entry
@Component
struct Index {
  private fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'];

  build() {
    Column() {
      Text('Fruit List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      List({ space: 10 }) {
        ForEach(this.fruits, (fruit: string) => {
          ListItem() {
            Text(fruit)
              .fontSize(20)
              .padding(15)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(8)
              .textAlign(TextAlign.Center)
          }
        }, (fruit: string) => fruit)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}