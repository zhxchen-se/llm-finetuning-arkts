@Entry
@Component
struct Index {
  @State selectedIndex: number = 1;

  logStatus(selected: number) {
    for (let i = 1; i <= 3; i++) {
      console.info(`Radio Button ${i}: ${i === selected ? 'Selected' : 'Unselected'}`);
    }
  }

  build() {
    Column() {
      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Radio({ value: item, group: 'radioGroup' })
            .selectedColor('#FFC0CB')
            .onChange((isSelected: boolean) => {
              if (isSelected) {
                this.selectedIndex = item;
                this.logStatus(item);
              }
            })
          Text(`Option ${item}`)
            .fontSize(18)
            .margin({ left: 10 })
        }
        .width('80%')
        .padding(10)
        .backgroundColor(this.selectedIndex === item ? '#FFC0CB' : '#FFFFFF')
        .borderRadius(8)
        .margin({ bottom: 10 })
        .justifyContent(FlexAlign.Start)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}