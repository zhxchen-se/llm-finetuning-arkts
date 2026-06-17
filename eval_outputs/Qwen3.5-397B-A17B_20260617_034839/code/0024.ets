@Entry
@Component
struct Index {
  @State searchText: string = ''
  @State filteredItems: Array<string> = []
  private allItems: Array<string> = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
    'Nectarine',
    'Orange',
    'Papaya',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Tangerine',
    'Ugli fruit',
    'Watermelon'
  ]

  aboutToAppear() {
    this.filteredItems = this.allItems
  }

  build() {
    Column() {
      Search({
        placeholder: 'Search fruits...',
        backgroundColor: '#F1F3F5',
        borderRadius: 20
      })
      .margin({ top: 20, left: 16, right: 16 })
      .onChange((value: string) => {
        this.searchText = value
        this.filterItems(value)
      })
      .onSubmit((value: string) => {
        this.filterItems(value)
      })

      List() {
        ForEach(this.filteredItems, (item: string) => {
          ListItem() {
            Column() {
              Text(item)
                .fontSize(18)
                .fontColor('#333333')
                .width('100%')
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              Divider()
                .color('#E5E5E5')
            }
          }
        }, (item: string) => item)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  filterItems(query: string) {
    const lowerQuery = query.toLowerCase()
    this.filteredItems = this.allItems.filter((item) =>
      item.toLowerCase().includes(lowerQuery)
    )
  }
}