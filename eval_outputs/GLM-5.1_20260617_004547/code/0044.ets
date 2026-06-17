@Entry
@Component
struct Index {
  @State radio1Checked: boolean = true
  @State radio2Checked: boolean = false
  @State radio3Checked: boolean = false

  @Builder
  dotIndicator() {
    Circle().width(12).height(12).fill(Color.White)
  }

  @Builder
  customIndicator() {
    Text('★').fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Bold)
  }

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, space: 30 }) {
      Row({ space: 8 }) {
        Checkbox({ name: 'radio1', group: 'radioGroup' })
          .shape(CheckBoxShape.CIRCLE)
          .width(24)
          .height(24)
          .select(this.radio1Checked)
          .onChange((value: boolean) => {
            if (value) {
              this.radio1Checked = true
              this.radio2Checked = false
              this.radio3Checked = false
            }
          })
        Text('Radio1 (Tick)').fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'radio2', group: 'radioGroup' })
          .shape(CheckBoxShape.CIRCLE)
          .width(24)
          .height(24)
          .select(this.radio2Checked)
          .indicatorBuilder(this.dotIndicator)
          .onChange((value: boolean) => {
            if (value) {
              this.radio1Checked = false
              this.radio2Checked = true
              this.radio3Checked = false
            }
          })
        Text('Radio2 (Dot)').fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'radio3', group: 'radioGroup' })
          .shape(CheckBoxShape.CIRCLE)
          .width(24)
          .height(24)
          .select(this.radio3Checked)
          .indicatorBuilder(this.customIndicator)
          .onChange((value: boolean) => {
            if (value) {
              this.radio1Checked = false
              this.radio2Checked = false
              this.radio3Checked = true
            }
          })
        Text('Radio3 (Custom)').fontSize(16)
      }
    }
    .width('100%')
    .height('100%')
  }
}