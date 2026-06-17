@Entry
@Component
struct Index {
  @State showDialog: boolean = false

  build() {
    Column() {
      Button('Show Dialogue')
        .fontSize(18)
        .fontColor('#007DFF')
        .onClick(() => {
          this.showDialog = true
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)

    AlertDialog({
      show: this.showDialog,
      title: 'Dialogue Title',
      message: 'This is a sample dialogue message implemented in ArkTS.',
      primaryButton: {
        text: 'Confirm',
        action: (): void => {
          this.showDialog = false
        }
      },
      secondaryButton: {
        text: 'Cancel',
        action: (): void => {
          this.showDialog = false
        }
      }
    })
  }
}