@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State count: number = 0;
  @State inputValue: string = '';
  @State itemList: Array<string> = ['Item 1', 'Item 2', 'Item 3'];
  @State isVisible: boolean = true;

  aboutToAppear() {
    console.info('Index aboutToAppear');
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Row() {
        Button('Count: ' + this.count)
          .onClick(() => {
            this.count++;
          })
        Button('Reset')
          .onClick(() => {
            this.count = 0;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 20 })

      TextInput({ placeholder: 'Enter text', text: this.inputValue })
        .onChange((value: string) => {
          this.inputValue = value;
          this.message = 'Hello ' + value;
        })
        .width('90%')
        .margin({ bottom: 20 })

      if (this.isVisible) {
        Text('This text is conditionally rendered')
          .fontSize(16)
          .fontColor(Color.Blue)
          .margin({ bottom: 20 })
      }

      Button('Toggle Visibility')
        .onClick(() => {
          this.isVisible = !this.isVisible;
        })
        .margin({ bottom: 20 })

      Text('List Items:')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      ForEach(this.itemList, (item: string) => {
        Row() {
          Text(item)
            .fontSize(14)
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#f0f0f0')
        .margin({ bottom: 5 })
      }, (item: string) => item)

      Button('Add Item')
        .onClick(() => {
          this.itemList.push('Item ' + (this.itemList.length + 1));
        })
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}