interface TodoItem {
  id: number;
  text: string;
}

@Entry
@Component
struct Index {
  @State items: Array<TodoItem> = [
    { id: 1, text: 'Item 1' },
    { id: 2, text: 'Item 2' },
    { id: 3, text: 'Item 3' }
  ];

  build() {
    Column() {
      Text('Items')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      if (this.items.length === 0) {
        Text('No items left')
          .fontSize(16)
          .fontColor('#666666');
      }

      ForEach(this.items, (item: TodoItem) => {
        Row() {
          Text(item.text)
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1);

          Button('Delete')
            .fontSize(12)
            .backgroundColor('#FF5C5C')
            .onClick(() => {
              this.items = this.items.filter((value: TodoItem) => value.id !== item.id);
            });
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .margin({ bottom: 8 })
        .backgroundColor('#F5F5F5')
        .borderRadius(8);
      }, (item: TodoItem) => item.id);
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF');
  }
}