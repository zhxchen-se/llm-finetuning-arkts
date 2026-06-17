import { router } from '@kit.ArkUI';

interface FavoriteItem {
  id: number;
  title: string;
  url: string;
}

@Entry
@Component
struct Index {
  @State favorites: FavoriteItem[] = [
    { id: 1, title: 'HarmonyOS Developer', url: 'https://developer.harmonyos.com' },
    { id: 2, title: 'ArkUI Overview', url: 'https://developer.harmonyos.com/en/docs/documentation/doc-guides/arkui-overview-0000001281480750' },
    { id: 3, title: 'ArkTS Language', url: 'https://developer.harmonyos.com/en/docs/documentation/doc-guides/arkts-language-0000001524108473' },
    { id: 4, title: 'Swipe Gesture', url: 'https://developer.harmonyos.com/en/docs/documentation/doc-references/ts-gesture-swipe-0000001281480778' }
  ];

  // Builder for the swipe action visual (red delete area)
  @Builder
  DeleteSwipeBuilder() {
    Row() {
      Text('Delete')
        .fontSize(16)
        .fontColor(Color.White)
        .margin({ left: 10, right: 10 })
    }
    .width(80)
    .height('100%')
    .backgroundColor(Color.Red)
    .justifyContent(FlexAlign.Center)
  }

  // Remove a favorite by id
  removeFavorite(id: number) {
    this.favorites = this.favorites.filter(item => item.id !== id);
  }

  build() {
    Column() {
      // Header
      Text('Favorites')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding(16)
        .textAlign(TextAlign.Start)

      // List or empty state
      if (this.favorites.length === 0) {
        Column() {
          Text('No favorites yet')
            .fontSize(18)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .height('80%')
        .justifyContent(FlexAlign.Center)
      } else {
        List({ space: 8 }) {
          ForEach(this.favorites, (item: FavoriteItem) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(item.url)
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // Explicit delete button
                Button('Delete')
                  .fontSize(14)
                  .fontColor(Color.White)
                  .backgroundColor(Color.Red)
                  .borderRadius(8)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .onClick(() => {
                    this.removeFavorite(item.id);
                  })
              }
              .width('100%')
              .padding(12)
              .alignItems(VerticalAlign.Center)
            }
            .swipeAction({
              end: this.DeleteSwipeBuilder,
              onAction: () => {
                this.removeFavorite(item.id);
              }
            })
          }, (item: FavoriteItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .divider({ strokeWidth: 0.5, color: Color.Gray, startMargin: 16, endMargin: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}