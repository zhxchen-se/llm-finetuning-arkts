import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State searchText: string = '';
  private allItems: string[] = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
    'Mango', 'Nectarine', 'Orange', 'Papaya', 'Quince',
    'Raspberry', 'Strawberry', 'Tangerine', 'Ugli fruit', 'Watermelon'
  ];

  // Computed property for filtered items
  get filteredItems(): string[] {
    if (!this.searchText.trim()) {
      return this.allItems;
    }
    const lowerSearch = this.searchText.toLowerCase();
    return this.allItems.filter(item => item.toLowerCase().includes(lowerSearch));
  }

  build() {
    Column() {
      // Search bar
      TextInput({ placeholder: 'Search fruits...' })
        .onChange((value: string) => {
          this.searchText = value;
        })
        .width('90%')
        .margin({ top: 20, bottom: 10 })
        .padding(10)
        .fontSize(16)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

      // List of filtered items
      if (this.filteredItems.length === 0) {
        Text('No matching items found')
          .fontSize(18)
          .fontColor('#999')
          .margin({ top: 50 })
      } else {
        List() {
          ForEach(this.filteredItems, (item: string) => {
            ListItem() {
              Text(item)
                .fontSize(18)
                .padding(15)
                .width('100%')
                .textAlign(TextAlign.Start)
            }
            .border({ width: { bottom: 0.5 }, color: '#E0E0E0' })
          }, (item: string) => item) // key generator
        }
        .width('90%')
        .layoutWeight(1)
        .margin({ top: 10 })
        .divider({ strokeWidth: 0.5, color: '#E0E0E0' })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ top: 20 })
  }
}