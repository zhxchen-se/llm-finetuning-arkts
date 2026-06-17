@Component
struct ToggleSwitch {
  @Link isOn: boolean = false;

  private width: number = 72;
  private height: number = 40;
  private knobSize: number = 32;
  private padding: number = 4;

  build() {
    Stack() {
      Circle()
        .width(this.knobSize)
        .height(this.knobSize)
        .fillColor(Color.White)
        .shadow({
          radius: 4,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 2
        })
        .position({
          x: this.isOn
            ? this.width - this.padding - this.knobSize / 2
            : this.padding + this.knobSize / 2,
          y: (this.height - this.knobSize) / 2
        })
    }
      .width(this.width)
      .height(this.height)
      .backgroundColor(this.isOn ? '#0A84FF' : '#B8B8B8')
      .borderRadius(this.height / 2)
      .onClick(() => {
        this.isOn = !this.isOn;
      })
  }
}

@Entry
@Component
struct Index {
  @State isOn: boolean = false;

  build() {
    Column() {
      Text(this.isOn ? 'Switch is ON' : 'Switch is OFF')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })

      ToggleSwitch({ isOn: $isOn })

      Text('Tap the switch to change its state')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 16 })
    }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(24)
      .backgroundColor('#F5F5F5')
  }
}