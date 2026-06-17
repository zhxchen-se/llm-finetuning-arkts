import {
  Column,
  Row,
  Text,
  TextInput,
  List,
  ListItem,
  Image,
  Blank,
  Search,
  searchController,
  SearchController
} from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State searchText: string = '';
  @State filteredItems: string[] = [];

  private items: string[] = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
    'Strawberry',
    'Watermelon',
    'Blueberry',
    'Peach'
  ];

  aboutToAppear(): void {
    this.filteredItems = this.items;
  }

  build() {
    Column() {
      Search({
        placeholder: 'Search items...',
        controller: searchController
      })
        .onChange((value: string) => {
          this.searchText = value;
          this.filterItems(value);
        })
        .width('90%')
        .margin({ top: 20 })

      List() {
        ForEach(this.filteredItems, (item: string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Blank()

              Text('Item')
                .fontSize(14)
                .fontColor('#888888')
            }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
          }
            .margin({ bottom: 8 })
        }, (item: string) => item)
      }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 12, bottom: 12 })

      if (this.filteredItems.length === 0) {
        Text('No items found')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ top: 20 })
      }
    }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F5F6FA')
  }

  private filterItems(value: string): void {
    const keyword = value.trim().toLowerCase();

    if (keyword.length === 0) {
      this.filteredItems = this.items;
      return;
    }

    this.filteredItems = this.items.filter((item: string) => {
      return item.toLowerCase().includes(keyword);
    });
  }
}