@Entry
@Component
struct Index {
  @State searchExpanded: boolean = false;
  @State searchText: string = '';
  @State searchMessage: string = 'Tap the search icon to open the search field.';

  private readonly actionAreaWidth: number = 136;
  private readonly actionButtonSize: number = 40;
  private readonly actionButtonSpace: number = 8;

  private toggleSearch(): void {
    if (this.searchExpanded && this.searchText.length > 0) {
      this.searchText = '';
      this.searchMessage = 'Search text cleared. Type a new query or tap again to close.';
      return;
    }

    this.searchExpanded = !this.searchExpanded;

    if (this.searchExpanded) {
      this.searchText = '';
      this.searchMessage = 'Type a search query, then press Search.';
    } else {
      this.searchMessage = 'Search closed.';
    }
  }

  private submitSearch(): void {
    const query = this.searchText.trim();

    if (query.length === 0) {
      this.searchMessage = 'Enter a search term before submitting.';
      return;
    }

    this.searchMessage = `Searching for “${query}”.`;
  }

  build() {
    Column() {
      Column() {
        Row() {
          Row()
            .width(this.actionAreaWidth)
            .height(56)

          Text('Centered Title')
            .layoutWeight(1)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .textAlign(TextAlign.Center)
            .maxLines(1)

          Row({ space: this.actionButtonSpace }) {
            Button() {
              Text(this.searchExpanded ? '×' : '⌕')
                .fontSize(this.searchExpanded ? 24 : 22)
                .fontColor(this.searchExpanded ? '#111827' : '#007DFF')
                .fontWeight(FontWeight.Bold)
            }
            .width(this.actionButtonSize)
            .height(this.actionButtonSize)
            .backgroundColor(this.searchExpanded ? '#E5E7EB' : '#00000000')
            .borderRadius(20)
            .onClick(() => {
              this.toggleSearch();
            })

            Button() {
              Text('🔔')
                .fontSize(20)
            }
            .width(this.actionButtonSize)
            .height(this.actionButtonSize)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .onClick(() => {
              this.searchMessage = 'Notification action tapped.';
            })

            Button() {
              Text('⋮')
                .fontSize(24)
                .fontColor('#374151')
                .fontWeight(FontWeight.Bold)
            }
            .width(this.actionButtonSize)
            .height(this.actionButtonSize)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .onClick(() => {
              this.searchMessage = 'More actions tapped.';
            })
          }
          .width(this.actionAreaWidth)
          .height(56)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.End)
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)

        if (this.searchExpanded) {
          Row({ space: 8 }) {
            TextInput({
              text: this.searchText,
              placeholder: 'Search apps, settings, or files'
            })
              .layoutWeight(1)
              .height(40)
              .backgroundColor('#F3F4F6')
              .borderRadius(20)
              .padding({ left: 14, right: 14 })
              .fontSize(15)
              .fontColor('#111827')
              .onChange((value: string) => {
                this.searchText = value;

                const trimmedValue = value.trim();
                this.searchMessage = trimmedValue.length > 0
                  ? `Ready to search for “${trimmedValue}”.`
                  : 'Type a search query, then press Search.';
              })

            if (this.searchText.length > 0) {
              Button('Clear')
                .height(40)
                .padding({ left: 14, right: 14 })
                .fontSize(14)
                .fontColor('#374151')
                .backgroundColor('#E5E7EB')
                .borderRadius(20)
                .onClick(() => {
                  this.searchText = '';
                  this.searchMessage = 'Search text cleared. Type a new query or press Search.';
                })
            }

            Button('Search')
              .height(40)
              .padding({ left: 16, right: 16 })
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#007DFF')
              .borderRadius(20)
              .onClick(() => {
                this.submitSearch();
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 4, bottom: 8 })
          .alignItems(VerticalAlign.Center)
        }
      }
      .width('100%')
      .backgroundColor('#FFFFFF')

      Column() {
        Text('App Bar Demo')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ top: 32, bottom: 8 })

        Text(this.searchMessage)
          .fontSize(16)
          .fontColor('#4B5563')
          .width('90%')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 16 })

        if (this.searchExpanded) {
          Text(`Current input: ${this.searchText.length > 0 ? this.searchText : 'empty'}`)
            .fontSize(15)
            .fontColor('#007DFF')
            .padding(12)
            .backgroundColor('#EFF6FF')
            .borderRadius(12)
            .width('90%')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 24 })
        }

        Button('Submit Search')
          .width('40%')
          .height(44)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#007DFF')
          .borderRadius(22)
          .onClick(() => {
            this.submitSearch();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }
}