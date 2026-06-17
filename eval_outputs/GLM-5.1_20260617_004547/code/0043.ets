@Entry
@Component
struct Index {
  @State selectedValue: string = 'radio1'

  build() {
    Column({ space: 20 }) {
      Radio({ value: 'radio1', group: 'radioGroup' })
        .checked(this.selectedValue === 'radio1')
        .backgroundColor(this.selectedValue === 'radio1' ? Color.Pink : Color.White)
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.selectedValue = 'radio1'
            this.printStatus()
          }
        })

      Radio({ value: 'radio2', group: 'radioGroup' })
        .checked(this.selectedValue === 'radio2')
        .backgroundColor(this.selectedValue === 'radio2' ? Color.Pink : Color.White)
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.selectedValue = 'radio2'
            this.printStatus()
          }
        })

      Radio({ value: 'radio3', group: 'radioGroup' })
        .checked(this.selectedValue === 'radio3')
        .backgroundColor(this.selectedValue === 'radio3' ? Color.Pink : Color.White)
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.selectedValue = 'radio3'
            this.printStatus()
          }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  private printStatus() {
    console.log(`Radio1 status: ${this.selectedValue === 'radio1'}`)
    console.log(`Radio2 status: ${this.selectedValue === 'radio2'}`)
    console.log(`Radio3 status: ${this.selectedValue === 'radio3'}`)
  }
}