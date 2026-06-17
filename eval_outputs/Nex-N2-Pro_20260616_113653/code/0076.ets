interface FavoriteItem {
  id: string
  title: string
  url: string
  category: string
  bookmarkedAt: string
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      FavoritesManagement()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct FavoritesManagement {
  @State favorites: FavoriteItem[] = [
    {
      id: '1',
      title: 'ArkUI Layout Guide',
      url: 'https://developer.huawei.com/consumer/cn/doc/arkui-layout',
      category: 'Docs',
      bookmarkedAt: 'Today'
    },
    {
      id: '2',
      title: 'HarmonyOS Ability Kit',
      url: 'https://developer.huawei.com/consumer/cn/doc/ability-kit',
      category: 'Kit',
      bookmarkedAt: 'Yesterday'
    },
    {
      id: '3',
      title: 'ArkTS State Management',
      url: 'https://developer.huawei.com/consumer/cn/doc/arkts-state',
      category: 'ArkTS',
      bookmarkedAt: 'Mon'
    },
    {
      id: '4',
      title: 'Component API Reference',
      url: 'https://developer.huawei.com/consumer/cn/doc/components',
      category: 'Reference',
      bookmarkedAt: 'Last week'
    }
  ]

  @State swipeOffsets: number[] = []
  @State swipeStartOffsets: number[] = []

  build() {
    Column() {
      Row() {
        Column({ space: 4 }) {
          Text('Favorites')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#101828')

          Text('Swipe left or tap Delete to remove bookmarks from the list.')
            .fontSize(13)
            .fontColor('#667085')
        }
        .layoutWeight(1)

        Row() {
          Text(`${this.favorites.length}`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D6CDF')
            .textAlign(TextAlign.Center)
        }
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor('#E8F0FF')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: 16 })

      if (this.favorites.length === 0) {
        this.EmptyState()
      } else {
        List({ space: 12 }) {
          ForEach(this.favorites, (item: FavoriteItem, index: number) => {
            ListItem() {
              this.FavoriteCard(item, index)
            }
            .width('100%')
          }, (item: FavoriteItem) => item.id)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 8 })
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 16 })
    .backgroundColor('#F5F7FB')
  }

  @Builder
  EmptyState() {
    Column() {
      Text('No favorites yet')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#101828')

      Text('Swipe left or tap Delete to remove bookmarks from the list.')
        .fontSize(14)
        .fontColor('#667085')
        .textAlign(TextAlign.Center)
        .width(260)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  FavoriteCard(item: FavoriteItem, index: number) {
    const offset = this.getOffset(index)

    Row() {
      Row() {
        Text('Delete')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(96)
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)
      .padding({ right: 28 })
      .backgroundColor('#D92D20')

      Row() {
        Column({ space: 6 }) {
          Row() {
            Text(item.category)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2D6CDF')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(8)
              .backgroundColor('#E8F0FF')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(item.bookmarkedAt)
              .fontSize(12)
              .fontColor('#98A2B3')
              .margin({ left: 8 })
              .maxLines(1)
          }
          .layoutWeight(1)
          .alignItems(VerticalAlign.Center)

          Text(item.title)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#101828')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')

          Text(item.url)
            .fontSize(13)
            .fontColor('#667085')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
        }
        .layoutWeight(1)
        .margin({ right: 10 })

        Button('Delete')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .padding({ left: 12, right: 12 })
          .borderRadius(16)
          .backgroundColor('#FFF1F0')
          .fontColor('#D92D20')
          .onClick(() => {
            this.removeFavorite(item.id)
          })
      }
      .width('100%')
      .height(96)
      .padding({ left: 16, right: 14, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 12,
        color: 'rgba(0, 0, 0, 0.08)',
        offsetX: 0,
        offsetY: 4
      })
      .alignItems(VerticalAlign.Center)
      .translate({ x: offset })
      .gesture(
        PanGesture()
          .onActionStart(() => {
            this.closeOtherSwipes(index)
          })
          .onActionUpdate((event: GestureEvent) => {
            const start = this.getSwipeStart(index)
            const nextOffset = Math.max(-132, Math.min(0, start + event.offsetX))
            this.swipeOffsets = this.favorites.map((_: FavoriteItem, i: number) => (i === index ? nextOffset : 0))
          })
          .onActionEnd(() => {
            const start = this.getSwipeStart(index)
            const current = this.getOffset(index)
            const deltaX = current - start

            if (deltaX <= -84) {
              this.removeFavorite(item.id)
            } else {
              this.resetSwipe()
            }
          })
          .onActionCancel(() => {
            this.resetSwipe()
          })
      )
    }
    .width('100%')
    .height(96)
    .clip(true)
  }

  getOffset(index: number): number {
    return this.swipeOffsets[index] || 0
  }

  getSwipeStart(index: number): number {
    return this.swipeStartOffsets[index] || 0
  }

  closeOtherSwipes(index: number): void {
    const current = this.getOffset(index)

    this.swipeOffsets = this.favorites.map((_: FavoriteItem, i: number) => (i === index ? current : 0))
    this.swipeStartOffsets = this.favorites.map((_: FavoriteItem, i: number) => (i === index ? current : 0))
  }

  resetSwipe(): void {
    this.swipeOffsets = this.favorites.map((_: FavoriteItem) => 0)
    this.swipeStartOffsets = []
  }

  removeFavorite(id: string): void {
    this.favorites = this.favorites.filter((item: FavoriteItem) => item.id !== id)
    this.resetSwipe()
  }
}