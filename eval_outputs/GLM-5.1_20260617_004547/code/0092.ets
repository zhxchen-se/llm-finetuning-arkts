import { ChipSize } from '@ohos.arkui';

@Entry
@Component
struct Index {
  @State isSelected1: boolean = false
  @State isSelected2: boolean = true
  @State isSelected3: boolean = false
  @State isClosableVisible: boolean = true
  @State isTagVisible: boolean = true
  @State clickCount: number = 0
  @State deleteCount: number = 0
  @State lastAction: string = 'None'

  build() {
    Scroll() {
      Column({ space: 20 }) {
        // Title
        Text('Chip Component Demo')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 16, bottom: 8 })

        // Status display
        Row() {
          Text('Last Action: ')
            .fontSize(14)
            .fontColor('#666666')
          Text(this.lastAction)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#007DFF')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })

        // 1. Basic Chips
        this.SectionTitle('1. Basic Chips')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({ text: 'Default' })
            .onClick(() => { this.lastAction = 'Default chip clicked' })

          Chip({ text: 'Primary', backgroundColor: '#007DFF', fontColor: Color.White })
            .onClick(() => { this.lastAction = 'Primary chip clicked' })

          Chip({ text: 'Success', backgroundColor: '#64BB5C', fontColor: Color.White })
            .onClick(() => { this.lastAction = 'Success chip clicked' })

          Chip({ text: 'Warning', backgroundColor: '#FF9800', fontColor: Color.White })
            .onClick(() => { this.lastAction = 'Warning chip clicked' })

          Chip({ text: 'Danger', backgroundColor: '#E84026', fontColor: Color.White })
            .onClick(() => { this.lastAction = 'Danger chip clicked' })

          Chip({ text: 'Purple', backgroundColor: '#6750A4', fontColor: Color.White })
            .onClick(() => { this.lastAction = 'Purple chip clicked' })
        }
        .width('100%')

        // 2. Chips with Prefix Icon
        this.SectionTitle('2. Chips with Prefix Icon')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({
            text: 'Favorite',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_favor') }
          })
            .onClick(() => { this.lastAction = 'Favorite chip clicked' })

          Chip({
            text: 'Search',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_search') }
          })
            .onClick(() => { this.lastAction = 'Search chip clicked' })

          Chip({
            text: 'Add',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_add') }
          })
            .onClick(() => { this.lastAction = 'Add chip clicked' })

          Chip({
            text: 'Settings',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_settings') }
          })
            .onClick(() => { this.lastAction = 'Settings chip clicked' })
        }
        .width('100%')

        // 3. Chips with Suffix Icon
        this.SectionTitle('3. Chips with Suffix Icon')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({
            text: 'Arrow Right',
            suffixIcon: { src: $r('sys.media.ohos_ic_public_arrow_right') }
          })
            .onClick(() => { this.lastAction = 'Arrow Right chip clicked' })

          Chip({
            text: 'More',
            suffixIcon: { src: $r('sys.media.ohos_ic_public_more') }
          })
            .onClick(() => { this.lastAction = 'More chip clicked' })
        }
        .width('100%')

        // 4. Chip Sizes
        this.SectionTitle('4. Chip Sizes')
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({ text: 'Small', size: ChipSize.SMALL })
            .onClick(() => { this.lastAction = 'Small chip clicked' })

          Chip({ text: 'Medium', size: ChipSize.MEDIUM })
            .onClick(() => { this.lastAction = 'Medium chip clicked' })
        }
        .width('100%')

        // 5. Selectable Chips
        this.SectionTitle('5. Selectable Chips')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({ text: 'Option A', selected: this.isSelected1 })
            .onSelected((selected: boolean) => {
              this.isSelected1 = selected
              this.lastAction = `Option A selected: ${selected}`
            })

          Chip({ text: 'Option B', selected: this.isSelected2 })
            .onSelected((selected: boolean) => {
              this.isSelected2 = selected
              this.lastAction = `Option B selected: ${selected}`
            })

          Chip({ text: 'Option C', selected: this.isSelected3 })
            .onSelected((selected: boolean) => {
              this.isSelected3 = selected
              this.lastAction = `Option C selected: ${selected}`
            })
        }
        .width('100%')

        // Selection state display
        Row() {
          Text('Selection State: ')
            .fontSize(13)
            .fontColor('#999999')
          Text(`A=${this.isSelected1 ? '✓' : '✗'} B=${this.isSelected2 ? '✓' : '✗'} C=${this.isSelected3 ? '✓' : '✗'}`)
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        .width('100%')
        .padding({ left: 8 })

        // 6. Closable Chips
        this.SectionTitle('6. Closable Chips')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          if (this.isClosableVisible) {
            Chip({ text: 'Close Me', showCloseIcon: true })
              .onDelete(() => {
                this.isClosableVisible = false
                this.lastAction = 'Closable chip deleted'
              })
          }

          if (this.isTagVisible) {
            Chip({
              text: 'Tag',
              showCloseIcon: true,
              backgroundColor: '#E8F0FE',
              fontColor: '#007DFF'
            })
              .onDelete(() => {
                this.isTagVisible = false
                this.lastAction = 'Tag chip deleted'
              })
          }

          Chip({
            text: `Deleted: ${this.deleteCount}`,
            showCloseIcon: true
          })
            .onDelete(() => {
              this.deleteCount++
              this.lastAction = `Delete count: ${this.deleteCount}`
            })
        }
        .width('100%')

        // Reset button for deleted chips
        if (!this.isClosableVisible || !this.isTagVisible) {
          Button('Reset Deleted Chips')
            .fontSize(14)
            .backgroundColor('#007DFF')
            .borderRadius(20)
            .height(36)
            .onClick(() => {
              this.isClosableVisible = true
              this.isTagVisible = true
              this.lastAction = 'Chips reset'
            })
        }

        // 7. Disabled Chips
        this.SectionTitle('7. Disabled Chips')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({ text: 'Enabled', enabled: true })
            .onClick(() => { this.lastAction = 'Enabled chip clicked' })

          Chip({ text: 'Disabled', enabled: false })
            .onClick(() => { this.lastAction = 'This should not appear' })

          Chip({
            text: 'Disabled Colored',
            enabled: false,
            backgroundColor: '#007DFF',
            fontColor: Color.White
          })
        }
        .width('100%')

        // 8. Styled Chips
        this.SectionTitle('8. Custom Styled Chips')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({
            text: 'Rounded',
            backgroundColor: '#FFF3E0',
            fontColor: '#E65100'
          })

          Chip({
            text: 'Teal',
            backgroundColor: '#E0F2F1',
            fontColor: '#00695C'
          })

          Chip({
            text: 'Indigo',
            backgroundColor: '#E8EAF6',
            fontColor: '#283593'
          })

          Chip({
            text: 'Pink',
            backgroundColor: '#FCE4EC',
            fontColor: '#AD1457'
          })
        }
        .width('100%')

        // 9. Chip with Icon and Close
        this.SectionTitle('9. Icon + Close Combined')
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({
            text: 'Filter',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_search') },
            showCloseIcon: true,
            backgroundColor: '#E8F0FE',
            fontColor: '#007DFF'
          })
            .onDelete(() => { this.lastAction = 'Filter chip deleted' })

          Chip({
            text: 'Category',
            prefixIcon: { src: $r('sys.media.ohos_ic_public_settings') },
            showCloseIcon: true,
            backgroundColor: '#FFF3E0',
            fontColor: '#E65100'
          })
            .onDelete(() => { this.lastAction = 'Category chip deleted' })
        }
        .width('100%')

        // 10. Click Counter Demo
        this.SectionTitle('10. Click Counter')
        Row() {
          Text('Click count: ')
            .fontSize(16)
            .fontColor('#333333')
          Text(`${this.clickCount}`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007DFF')
        }
        .width('100%')
        .padding({ left: 8 })

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
          Chip({ text: 'Increment' })
            .onClick(() => {
              this.clickCount++
              this.lastAction = `Count incremented to ${this.clickCount}`
            })

          Chip({ text: 'Decrement', backgroundColor: '#FFEBEE', fontColor: '#C62828' })
            .onClick(() => {
              this.clickCount--
              this.lastAction = `Count decremented to ${this.clickCount}`
            })

          Chip({ text: 'Reset', backgroundColor: '#E8F5E9', fontColor: '#2E7D32' })
            .onClick(() => {
              this.clickCount = 0
              this.lastAction = 'Count reset to 0'
            })
        }
        .width('100%')

        Blank().height(40)
      }
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor('#333333')
      .width('100%')
      .margin({ top: 8 })
  }
}