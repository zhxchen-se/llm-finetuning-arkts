import promptAction from '@ohos.arkui.promptAction';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Chip Component Usage')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Column() {
        Text('Basic Chip')
          .fontSize(16)
          .margin({ bottom: 10 })
        Chip({ label: 'Normal Chip' })
          .onClick(() => {
            promptAction.showToast({ message: 'Normal Chip Clicked' });
          })
      }
      .width('100%')
      .padding(10)

      Column() {
        Text('Success Chip')
          .fontSize(16)
          .margin({ bottom: 10 })
        Chip({ label: 'Success Chip', type: ChipType.Success })
          .onClick(() => {
            promptAction.showToast({ message: 'Success Chip Clicked' });
          })
      }
      .width('100%')
      .padding(10)

      Column() {
        Text('Warning Chip')
          .fontSize(16)
          .margin({ bottom: 10 })
        Chip({ label: 'Warning Chip', type: ChipType.Warning })
          .onClick(() => {
            promptAction.showToast({ message: 'Warning Chip Clicked' });
          })
      }
      .width('100%')
      .padding(10)

      Column() {
        Text('Closable Chip')
          .fontSize(16)
          .margin({ bottom: 10 })
        Chip({ label: 'Closable Chip', closable: true })
          .onClick(() => {
            promptAction.showToast({ message: 'Closable Chip Clicked' });
          })
          .onClose(() => {
            promptAction.showToast({ message: 'Chip Closed' });
          })
      }
      .width('100%')
      .padding(10)

      Column() {
        Text('Error Chip')
          .fontSize(16)
          .margin({ bottom: 10 })
        Chip({ label: 'Error Chip', type: ChipType.Error })
          .onClick(() => {
            promptAction.showToast({ message: 'Error Chip Clicked' });
          })
      }
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}