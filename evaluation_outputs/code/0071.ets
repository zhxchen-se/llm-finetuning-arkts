import { promptAction } from '@kit.ArkUI';
import { focusControl } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State isSearching: boolean = false;
  @State searchText: string = '';
  private allItems: string[] = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
    'Mango', 'Nectarine', 'Orange', 'Papaya', 'Quince'
  ];

  // Filter items based on search text
  private getFilteredItems(): string[] {
    if (!this.isSearching || this.searchText.trim() === '') {
      return this.allItems;
    }
    const lowerSearch = this.searchText.toLowerCase();
    return this.allItems.filter(item => item.toLowerCase().includes(lowerSearch));
  }

  // Focus the search input after it appears
  private focusSearchInput() {
    setTimeout(() => {
      focusControl.requestFocus('searchInput');
    }, 100);
  }

  build() {
    Column() {
      // App Bar
      Row() {
        // Left: back button (optional)
        Button() {
          Text('←')
            .fontSize(24)
            .fontColor('#333333')
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          promptAction.showToast({ message: 'Back pressed' });
        })

        // Center: title or search input
        if (this.isSearching) {
          TextInput({ placeholder: 'Search...', text: this.searchText })
            .id('searchInput')
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(20)
            .padding({ left: 12, right: 12 })
            .fontSize(16)
            .onChange((value: string) => {
              this.searchText = value;
            })
            .onAppear(() => {
              this.focusSearchInput();
            })
        } else {
          Text('My App')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }

        // Right: action buttons
        if (this.isSearching) {
          Button() {
            Text('✕')
              .fontSize(20)
              .fontColor('#333333')
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.isSearching = false;
            this.searchText = '';
          })
        } else {
          Row() {
            // Search icon
            Button() {
              Text('🔍')
                .fontSize(22)
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.isSearching = true;
            })

            // Additional action (e.g., more options)
            Button() {
              Text('⋯')
                .fontSize(24)
                .fontColor('#333333')
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              promptAction.showToast({ message: 'More options' });
            })
          }
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

      // Content list
      List() {
        ForEach(this.getFilteredItems(), (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(18)
              .padding(16)
              .width('100%')
              .textAlign(TextAlign.Start)
          }
          .border({ width: { bottom: 0.5 }, color: '#E0E0E0' })
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F9F9F9')
    }
    .width('100%')
    .height('100%')
  }
}