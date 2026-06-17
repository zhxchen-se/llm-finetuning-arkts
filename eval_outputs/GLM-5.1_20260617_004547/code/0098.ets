class ItemModel {
  id: string = ''
  title: string = ''
  description: string = ''
}

@Entry
@Component
struct Index {
  @State items: ItemModel[] = []

  aboutToAppear() {
    const totalItems = 100
    for (let i = 0; i < totalItems; i++) {
      const item = new ItemModel()
      item.id = i.toString()
      item.title = `Item ${i + 1}`
      item.description = `This is the description for item ${i + 1}. It demonstrates a long scrollable list.`
      this.items.push(item)
    }
  }

  build() {
    Column() {
      Text('Scrollable List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
        .width('100%')
        .textAlign(TextAlign.Center)

      List({ space: 12 }) {
        ForEach(this.items, (item: ItemModel) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                
                Text(item.description)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 6 })
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>')
                .fontSize(18)
                .fontColor('#999999')
                .margin({ left: 12 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#E0E0E0', offsetY: 2 })
          }
          .width('100%')
        }, (item: ItemModel) => item.id)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}