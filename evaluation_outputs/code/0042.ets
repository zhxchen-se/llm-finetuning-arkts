@Entry
@Component
struct Index {
  private fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'];

  build() {
    Column() {
      TextPicker({ range: this.fruits, selected: 0 })
        .onChange((value: string, index: number) => {
          console.log(`Selected fruit index: ${index}`);
        })
        .selectedTextStyle({
          fontColor: Color.Blue,
          fontSize: '24fp'
        })
        .width('100%')
        .height(200)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}