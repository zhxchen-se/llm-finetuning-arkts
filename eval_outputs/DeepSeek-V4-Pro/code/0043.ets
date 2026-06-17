@Entry
@Component
struct Index {
  @State selectedIndex: number = 0;
  private radioValues: string[] = ['Option 1', 'Option 2', 'Option 3'];

  build() {
    Column() {
      RadioGroup({ group: 'radioGroup' }) {
        ForEach(this.radioValues, (item: string, index: number) => {
          Row() {
            Radio({ value: item, group: 'radioGroup' })
              .checked(index === this.selectedIndex)
            Text(item)
              .fontSize(16)
              .margin({ left: 8 })
          }
          .width('100%')
          .padding(10)
          .backgroundColor(index === this.selectedIndex ? Color.Pink : Color.Transparent)
          .borderRadius(8)
          .margin({ bottom: 8 })
        })
      }
      .onChange((value: string) => {
        const newIndex = this.radioValues.indexOf(value);
        this.selectedIndex = newIndex;
        for (let i = 0; i < this.radioValues.length; i++) {
          console.log(`Radio ${i + 1}: ${i === newIndex ? 'checked' : 'unchecked'}`);
        }
      })
    }
    .width('100%')
    .padding(20)
  }
}