class ItemData {
  id: number = 0
  name: string = ''
}

@Entry
@Component
struct Index {
  @State items: Array<ItemData> = [
    { id: 1, name: 'Item 1' },
    { id: 2, name: 'Item 2' },
    { id: 3, name: 'Item 3' },
    { id: 4, name: 'Item 4' },
    { id: 5, name: 'Item 5' }
  ]

  build() {
    Column() {
      Text('My Items')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      List({ space: 10 }) {
        ForEach(this.items, (item: ItemData) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(18)
                .layoutWeight(1)

              Button('Delete')
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .height(32)
                .onClick(() => {
                  this.items = this.items.filter(i => i.id !== item.id)
                })
            }
            .width('100%')
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        }, (item: ItemData) => item.id.toString())
      }
      .width('90%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}