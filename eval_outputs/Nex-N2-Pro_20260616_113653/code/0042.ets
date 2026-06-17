@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  private fruits: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Grape']

  build() {
    Column() {
      Text('Select a Fruit')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })

      TextPicker({
        selected: this.selectedIndex,
        range: this.fruits
      })
        .height(180)
        .itemTextStyle({
          fontSize: 20,
          fontColor: '#666666'
        })
        .selectedItemTextStyle({
          fontSize: 28,
          fontColor: '#007DFF',
          fontWeight: FontWeight.Bold
        })
        .onChange((index: number) => {
          this.selectedIndex = index
          console.info(`Selected fruit position: ${index + 1}`)
        })

      Text(`Selected position: ${this.selectedIndex + 1}`)
        .fontSize(20)
        .margin({ top: 20 })
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
  }
}