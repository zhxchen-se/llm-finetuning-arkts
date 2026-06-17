@Entry
@Component
struct Index {
  @State searchQuery: string = ''
  private items: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon', 'Mango', 'Orange', 'Papaya']
  @State filteredItems: string[] = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon', 'Mango', 'Orange', 'Papaya']

  build() {
    Column() {
      Text('Search Items')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 16 })
        .width('90%')

      Row() {
        TextInput({ placeholder: 'Type to search...', text: this.searchQuery })
          .layoutWeight(1)
          .height(45)
          .backgroundColor('#FFFFFF')
          .borderRadius(22)
          .padding({ left: 20, right: 20 })
          .placeholderColor('#AAAAAA')
          .onChange((value: string) => {
            this.searchQuery = value
            this.filterItems()
          })
      }
      .width('90%')
      .margin({ bottom: 20 })

      if (this.filteredItems.length > 0) {
        List({ space: 12 }) {
          ForEach(this.filteredItems, (item: string) => {
            ListItem() {
              Row() {
                Text(item)
                  .fontSize(18)
                  .fontColor('#333333')
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }
          }, (item: string) => item)
        }
        .width('90%')
        .layoutWeight(1)
        .edgeEffect(EdgeEffect.Spring)
      } else {
        Column() {
          Text('No items found')
            .fontSize(18)
            .fontColor('#999999')
            .margin({ top: 50 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  private filterItems() {
    if (this.searchQuery.trim() === '') {
      this.filteredItems = [...this.items]
    } else {
      this.filteredItems = this.items.filter(item =>
        item.toLowerCase().includes(this.searchQuery.trim().toLowerCase())
      )
    }
  }
}