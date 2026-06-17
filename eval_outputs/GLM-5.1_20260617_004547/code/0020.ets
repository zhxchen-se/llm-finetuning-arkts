import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State selectedIndex: number = -1
  @State isDropdownOpen: boolean = false
  @State selectedText: string = 'Select an option'
  @State menuItems: string[] = ['Dashboard', 'Settings', 'Profile', 'Messages', 'Notifications', 'Help & Support']

  build() {
    Column() {
      // Title
      Text('Drop Down Menu')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1a1a2e')
        .margin({ top: 60, bottom: 40 })

      // Dropdown Container
      Column() {
        // Dropdown Trigger Button
        Row() {
          Text(this.selectedIndex === -1 ? 'Select an option' : this.menuItems[this.selectedIndex])
            .fontSize(16)
            .fontColor(this.selectedIndex === -1 ? '#999999' : '#1a1a2e')
            .layoutWeight(1)

          Text(this.isDropdownOpen ? '▲' : '▼')
            .fontSize(14)
            .fontColor('#6c63ff')
            .margin({ left: 8 })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)
        .borderRadius(this.isDropdownOpen ? { topLeft: 12, topRight: 12 } : 12)
        .border({
          width: 1.5,
          color: this.isDropdownOpen ? '#6c63ff' : '#e0e0e0',
          style: BorderStyle.Solid
        })
        .onClick(() => {
          this.isDropdownOpen = !this.isDropdownOpen
        })
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            TapGesture().onAction(() => {
              this.isDropdownOpen = !this.isDropdownOpen
            })
          )
        )

        // Dropdown Menu Items
        if (this.isDropdownOpen) {
          Column() {
            ForEach(this.menuItems, (item: string, index: number) => {
              Row() {
                Text(item)
                  .fontSize(15)
                  .fontColor(this.selectedIndex === index ? '#6c63ff' : '#333333')
                  .layoutWeight(1)

                if (this.selectedIndex === index) {
                  Text('✓')
                    .fontSize(16)
                    .fontColor('#6c63ff')
                    .fontWeight(FontWeight.Bold)
                }
              }
              .width('100%')
              .height(48)
              .padding({ left: 16, right: 16 })
              .backgroundColor(this.selectedIndex === index ? '#f0eeff' : Color.Transparent)
              .onClick(() => {
                this.selectedIndex = index
                this.selectedText = item
                this.isDropdownOpen = false
              })

              if (index < this.menuItems.length - 1) {
                Divider()
                  .color('#f0f0f0')
                  .width('90%')
              }
            }, (item: string, index: number) => `${index}_${item}`)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius({ bottomLeft: 12, bottomRight: 12 })
          .border({
            width: 1.5,
            color: '#6c63ff',
            style: BorderStyle.Solid
          })
          .borderWidth({ top: 0 })
          .shadow({
            radius: 12,
            color: '#1a1a2e1a',
            offsetY: 4
          })
        }
      }
      .width('85%')
      .zIndex(10)

      // Selected Result Display
      if (this.selectedIndex !== -1) {
        Column() {
          Text('You selected:')
            .fontSize(14)
            .fontColor('#888888')
            .margin({ bottom: 8 })

          Text(this.menuItems[this.selectedIndex])
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6c63ff')
        }
        .margin({ top: 40 })
        .padding(20)
        .backgroundColor('#f0eeff')
        .borderRadius(12)
      }

      // Built-in Select Component Alternative
      Column() {
        Text('Using Built-in Select Component')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1a1a2e')
          .margin({ bottom: 12 })

        Select([
          { value: 'Option A' },
          { value: 'Option B' },
          { value: 'Option C' },
          { value: 'Option D' }
        ])
          .selected(0)
          .value('Choose an option')
          .font({ size: 16 })
          .fontColor('#1a1a2e')
          .selectedOptionFont({ size: 16, weight: FontWeight.Bold })
          .optionFont({ size: 16 })
          .selectedColor('#6c63ff')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .width('100%')
          .onSelect((index: number, value: string) => {
            console.log(`Selected: index=${index}, value=${value}`)
          })
      }
      .width('85%')
      .margin({ top: 40 })
      .padding(20)
      .backgroundColor('#f8f8fc')
      .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5fa')
    .alignItems(HorizontalAlign.Center)
  }
}