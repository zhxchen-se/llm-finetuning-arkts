@Entry
@Component
struct Index {
  @State fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew']

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.fruits, (fruit: string) => {
          ListItem() {
            Row() {
              Image($r('app.media.icon'))
                .width(40)
                .height(40)
                .margin({ right: 16 })
                .objectFit(ImageFit.Contain)
              Text(fruit)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding(12)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        }, (fruit: string) => fruit)
      }
      .width('90%')
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}