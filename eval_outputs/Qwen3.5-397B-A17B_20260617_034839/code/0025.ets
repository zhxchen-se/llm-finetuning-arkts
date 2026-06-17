@Entry
@Component
struct Index {
  @State itemList: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  build() {
    Column() {
      List() {
        ForEach(this.itemList, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(16)
                .fontColor('#000000')
                .flexGrow(1)
              Button('Delete')
                .fontSize(14)
                .backgroundColor('#FF0000')
                .fontColor('#FFFFFF')
                .onClick(() => {
                  this.itemList.splice(index, 1);
                })
            }
            .width('100%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(ItemAlign.Center)
          }
        }, (item: string, index: number) => index.toString())
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}