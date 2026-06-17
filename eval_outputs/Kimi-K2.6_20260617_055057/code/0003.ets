@Entry
@Component
struct Index {
  @State items: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon'];
  @State colors: string[] = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9'];

  build() {
    Column() {
      Text('Horizontal Scroll List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ top: 40, bottom: 20, left: 20 })

      List({ space: 16 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Column() {
              Text(`${index + 1}`)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ bottom: 8 })
              Text(item)
                .fontSize(16)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
            }
            .width(140)
            .height(180)
            .backgroundColor(this.colors[index % this.colors.length])
            .borderRadius(20)
            .justifyContent(FlexAlign.Center)
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.15)', offsetX: 2, offsetY: 4 })
          }
        }, (item: string, index: number) => index.toString())
      }
      .listDirection(Axis.Horizontal)
      .padding({ left: 20, right: 20 })
      .height(200)
      .edgeEffect(EdgeEffect.Spring)
      .scrollBar(BarState.Auto)

      Blank()

      Text('Swipe left or right to scroll')
        .fontSize(14)
        .fontColor('#999999')
        .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Start)
  }
}