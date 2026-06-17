import { promptAction } from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State isDropdownVisible: boolean = false
  @State selectedOption: string = 'Select an option'
  private options: string[] = ['Option 1', 'Option 2', 'Option 3', 'Option 4']

  build() {
    Column() {
      Text('ArkTS Drop Down Menu')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40 })

      Column() {
        // Trigger Button
        Row() {
          Text(this.selectedOption)
            .fontSize(16)
            .fontColor(this.selectedOption === 'Select an option' ? Color.Gray : Color.Black)
          
          Blank()
          
          Text(this.isDropdownVisible ? '▲' : '▼')
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .width('90%')
        .height(50)
        .padding({ left: 15, right: 15 })
        .backgroundColor(Color.White)
        .borderRadius(8)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .onClick((event) => {
          this.isDropdownVisible = !this.isDropdownVisible
          event.stopPropagation()
        })

        // Dropdown List
        if (this.isDropdownVisible) {
          Column() {
            ForEach(this.options, (item: string) => {
              Row() {
                Text(item)
                  .fontSize(16)
                  .fontColor(Color.Black)
                  .width('100%')
                  .padding({ top: 12, bottom: 12, left: 15 })
              }
              .width('90%')
              .backgroundColor(Color.White)
              .onClick(() => {
                this.selectedOption = item
                this.isDropdownVisible = false
                promptAction.showToast({
                  message: `Selected: ${item}`,
                  duration: 2000
                })
              })
            }, (item: string) => item)
          }
          .padding({ top: 5 })
          .borderRadius(8)
          .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          .onTouch((event) => {
            // Prevent click from propagating to background when interacting with list
            if (event.type === TouchType.Down) {
              // Consume touch
            }
          })
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F1F3F5')
    .onClick(() => {
      if (this.isDropdownVisible) {
        this.isDropdownVisible = false
      }
    })
  }
}