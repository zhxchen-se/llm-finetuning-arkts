interface ListItemData {
  id: number;
  title: string;
  description: string;
}

@Entry
@Component
struct Index {
  @State longListItems: ListItemData[] = Array.from(
    { length: 200 },
    (_: unknown, index: number) => ({
      id: index + 1,
      title: `Item ${index + 1}`,
      description: `This is a scrollable list item with index ${index + 1}.`
    })
  );

  build() {
    Column() {
      Text('Long Scrollable List')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      List({ space: 10 }) {
        ForEach(this.longListItems, (item: ListItemData) => {
          ListItem() {
            Row() {
              Text(`${item.id}`)
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .backgroundColor('#007DFF')
                .borderRadius(20)

              Column() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Text(item.description)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .margin({ left: 12 })

              Text('Open')
                .fontSize(14)
                .fontColor('#007DFF')
            }
            .width('100%')
            .height(76)
            .padding(14)
            .backgroundColor('#F6F8FB')
            .borderRadius(12)
          }
          .width('100%')
        }, (item: ListItemData) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}