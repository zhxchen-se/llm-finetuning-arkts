@Entry
@Component
struct Index {
  private fruits: string[] = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango', 'Peach', 'Watermelon', 'Pineapple']

  build() {
    Column() {
      Text('Fruit Picker')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextPicker({ range: this.fruits })
        .selectedFontColor(Color.Blue)
        .selectedFontSize(30)
        .fontColor(Color.Black)
        .fontSize(20)
        .onChange((value: string | string[], index: number | number[]) => {
          if (typeof index === 'number') {
            console.info(`Selected fruit position: ${index}`);
          } else if (Array.isArray(index) && index.length > 0) {
            console.info(`Selected fruit position: ${index[0]}`);
          }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}