@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Orange', 'Mango', 'Grapes'];

  build() {
    Column() {
      Text('Fruit List')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      List() {
        ForEach(this.fruits, (fruit: string) => {
          ListItem() {
            Text(fruit)
              .fontSize(22)
              .padding(12)
          }
        }, (fruit: string) => fruit)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}