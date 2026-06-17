@Entry
@Component
struct Index {
  @State selected: number = 1;

  build() {
    Column() {
      Text('Select an option')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 });

      this.RadioItem(1, 'Option 1');
      this.RadioItem(2, 'Option 2');
      this.RadioItem(3, 'Option 3');
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  RadioItem(index: number, label: string) {
    Row() {
      Radio({
        name: label,
        group: 'radioGroup',
        checked: this.selected === index
      })
      .onChange((isChecked: boolean) => {
        if (isChecked) {
          this.selectRadio(index);
        }
      })
      .width(24)
      .height(24);

      Text(label)
        .fontSize(18)
        .margin({ left: 12 });
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.selected === index ? '#FFC0CB' : '#FFFFFF')
    .borderRadius(10)
    .onClick(() => {
      this.selectRadio(index);
    });
  }

  private selectRadio(index: number): void {
    if (this.selected !== index) {
      this.selected = index;
      this.printStatus();
    }
  }

  private printStatus(): void {
    console.info(`Option 1: ${this.selected === 1 ? 'checked' : 'unchecked'}`);
    console.info(`Option 2: ${this.selected === 2 ? 'checked' : 'unchecked'}`);
    console.info(`Option 3: ${this.selected === 3 ? 'checked' : 'unchecked'}`);
  }
}