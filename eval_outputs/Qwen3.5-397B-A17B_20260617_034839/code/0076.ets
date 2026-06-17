import { promptAction } from '@ohos.promptAction';

interface FavoriteItem {
  id: number;
  title: string;
  url: string;
}

@Entry
@Component
struct Index {
  @State favorites: FavoriteItem[] = [
    { id: 1, title: 'HarmonyOS Docs', url: 'https://developer.harmonyos.com' },
    { id: 2, title: 'ArkTS Guide', url: 'https://developer.harmonyos.com/en/docs' },
    { id: 3, title: 'GitHub', url: 'https://github.com' },
    { id: 4, title: 'Stack Overflow', url: 'https://stackoverflow.com' }
  ];

  deleteItem(id: number) {
    this.favorites = this.favorites.filter(item => item.id !== id);
  }

  build() {
    Column() {
      Text('Favorites Management')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .fontColor('#333333')

      if (this.favorites.length === 0) {
        Text('No favorites yet')
          .fontSize(16)
          .fontColor('#999999')
          .margin({ top: 50 })
      } else {
        List() {
          ForEach(this.favorites, (item: FavoriteItem) => {
            ListItem() {
              SwipeAction({
                endAction: {
                  background: Color.Red,
                  onClick: () => {
                    this.deleteItem(item.id);
                  }
                }
              }) {
                Row() {
                  Column() {
                    Text(item.title)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#333333')
                    Text(item.url)
                      .fontSize(14)
                      .fontColor('#666666')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Button() {
                    Text('🗑️')
                      .fontSize(16)
                  }
                  .type(ButtonType.Circle)
                  .backgroundColor('#FFECECEC')
                  .width(36)
                  .height(36)
                  .onClick(() => {
                    this.deleteItem(item.id);
                  })
                  .margin({ left: 10 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              }
              .width('100%')
            }
            .margin({ bottom: 8 })
          }, (item: FavoriteItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}