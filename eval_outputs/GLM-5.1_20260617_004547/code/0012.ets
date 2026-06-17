import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Index {
  @State input1: string = ''
  @State input2: string = ''

  private isNumeric(str: string): boolean {
    if (str.trim() === '') {
      return false
    }
    return !isNaN(Number(str))
  }

  private submitForm() {
    if (this.isNumeric(this.input1) || this.isNumeric(this.input2)) {
      AlertDialog.show({
        title: 'Warning',
        message: 'Numeric values are not allowed. Please enter a valid string.',
        confirm: {
          value: 'OK',
          action: () => {}
        }
      })
    } else {
      promptAction.showToast({
        message: 'Form submitted successfully!',
        duration: 2000
      })
    }
  }

  build() {
    Column({ space: 20 }) {
      Text('Submit Form')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextInput({ placeholder: 'Enter first value' })
        .type(InputType.Normal)
        .width('80%')
        .height(50)
        .onChange((value: string) => {
          this.input1 = value
        })

      TextInput({ placeholder: 'Enter second value' })
        .type(InputType.Normal)
        .width('80%')
        .height(50)
        .onChange((value: string) => {
          this.input2 = value
        })

      Button('Submit')
        .width('80%')
        .height(50)
        .fontSize(18)
        .backgroundColor(Color.Blue)
        .onClick(() => {
          this.submitForm()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}