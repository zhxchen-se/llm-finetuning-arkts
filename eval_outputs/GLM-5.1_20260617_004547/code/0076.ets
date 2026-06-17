import { router } from '@kit.ArkUI'

interface FavoriteItem {
  id: number
  title: string
  description: string
  category: string
  date: string
  icon: ResourceStr
  color: string
}

@Entry
@Component
struct Index {
  @State favoritesList: FavoriteItem[] = [
    { id: 1, title: 'HarmonyOS Development Guide', description: 'Complete documentation for HarmonyOS application development', category: 'Docs', date: '2024-12-01', icon: $r('sys.media.ohos_ic_public_book'), color: '#4CAF50' },
    { id: 2, title: 'ArkUI Best Practices', description: 'Learn the best patterns for building responsive UI', category: 'Tutorial', date: '2024-11-28', icon: $r('sys.media.ohos_ic_public_star'), color: '#FF9800' },
    { id: 3, title: 'State Management Tips', description: 'Deep dive into @State, @Prop, and @Link decorators', category: 'Article', date: '2024-11-25', icon: $r('sys.media.ohos_ic_public_settings'), color: '#2196F3' },
    { id: 4, title: 'Animation Framework', description: 'Create smooth animations with the ArkUI animation system', category: 'Guide', date: '2024-11-20', icon: $r('sys.media.ohos_ic_public_video'), color: '#E91E63' },
    { id: 5, title: 'Network Request Patterns', description: 'HTTP request handling and data fetching strategies', category: 'Tutorial', date: '2024-11-18', icon: $r('sys.media.ohos_ic_public_wifi'), color: '#9C27B0' },
    { id: 6, title: 'Custom Components Guide', description: 'Build reusable and composable custom components', category: 'Docs', date: '2024-11-15', icon: $r('sys.media.ohos_ic_public_files'), color: '#00BCD4' },
    { id: 7, title: 'List & Grid Optimization', description: 'Performance tips for large data sets in lists and grids', category: 'Article', date: '2024-11-10', icon: $r('sys.media.ohos_ic_public_list'), color: '#FF5722' },
    { id: 8, title: 'Navigation & Routing', description: 'Implement multi-page navigation with NavDestination', category: 'Guide', date: '2024-11-05', icon: $r('sys.media.ohos_ic_public_arrow'), color: '#607D8B' }
  ]
  @State removedItem: FavoriteItem | null = null
  @State showUndoPopup: boolean = false
  @State undoTimer: number = -1
  @State searchQuery: string = ''
  @State selectedCategory: string = 'All'
  private categories: string[] = ['All', 'Docs', 'Tutorial', 'Article', 'Guide']

  private get filteredList(): FavoriteItem[] {
    let list = this.favoritesList
    if (this.selectedCategory !== 'All') {
      list = list.filter(item => item.category === this.selectedCategory)
    }
    if (this.searchQuery.trim() !== '') {
      const query = this.searchQuery.toLowerCase()
      list = list.filter(item =>
        item.title.toLowerCase().includes(query) ||
        item.description.toLowerCase().includes(query)
      )
    }
    return list
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('My Favorites')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a1a2e')
        Blank()
        Text(`${this.favoritesList.length} items`)
          .fontSize(14)
          .fontColor('#888')
          .backgroundColor('#f0f0f5')
          .padding({ left: 10, right: 10, top: 4, bottom: 4 })
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 8 })

      // Search Bar
      Row() {
        Image($r('sys.media.ohos_ic_public_search'))
          .width(18)
          .height(18)
          .fillColor('#999')
          .margin({ right: 8 })
        TextInput({ placeholder: 'Search favorites...', text: this.searchQuery })
          .layoutWeight(1)
          .height(36)
          .fontSize(14)
          .backgroundColor(Color.Transparent)
          .placeholderColor('#bbb')
          .onChange((value: string) => {
            this.searchQuery = value
          })
        if (this.searchQuery.length > 0) {
          Image($r('sys.media.ohos_ic_public_cancel'))
            .width(16)
            .height(16)
            .fillColor('#999')
            .onClick(() => {
              this.searchQuery = ''
            })
        }
      }
      .width('100%')
      .height(44)
      .backgroundColor('#f5f5fa')
      .borderRadius(22)
      .padding({ left: 14, right: 14 })
      .margin({ left: 20, right: 20, top: 8, bottom: 8 })

      // Category Filter
      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.categories, (category: string) => {
            Text(category)
              .fontSize(13)
              .fontColor(this.selectedCategory === category ? '#ffffff' : '#555')
              .backgroundColor(this.selectedCategory === category ? '#4a6cf7' : '#f0f0f5')
              .padding({ left: 14, right: 14, top: 6, bottom: 6 })
              .borderRadius(16)
              .onClick(() => {
                this.selectedCategory = category
              })
              .animation({ duration: 200 })
          })
        }
        .padding({ left: 20, right: 20 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .margin({ top: 4, bottom: 8 })

      // Favorites List
      if (this.filteredList.length === 0) {
        Column() {
          Image($r('sys.media.ohos_ic_public_folder'))
            .width(64)
            .height(64)
            .fillColor('#ccc')
            .margin({ bottom: 12 })
          Text('No favorites found')
            .fontSize(16)
            .fontColor('#999')
          Text(this.searchQuery ? 'Try a different search term' : 'Items you bookmark will appear here')
            .fontSize(13)
            .fontColor('#bbb')
            .margin({ top: 4 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        List({ space: 10 }) {
          ForEach(this.filteredList, (item: FavoriteItem) => {
            ListItem() {
              this.FavoriteItemBuilder(item)
            }
            .swipeAction({ end: this.SwipeDeleteBuilder(item) })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 4, bottom: 4 })
        .scrollBar(BarState.Auto)
        .edgeEffect(EdgeEffect.Spring)
      }

      // Undo Popup
      if (this.showUndoPopup && this.removedItem) {
        Row() {
          Column() {
            Text('Removed')
              .fontSize(13)
              .fontColor('#fff')
              .fontWeight(FontWeight.Medium)
            Text(this.removedItem.title)
              .fontSize(11)
              .fontColor('#ddd')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .constraintSize({ maxWidth: 180 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button('Undo')
            .fontSize(13)
            .fontColor('#4a6cf7')
            .backgroundColor('#e8ecff')
            .height(30)
            .padding({ left: 14, right: 14 })
            .borderRadius(15)
            .onClick(() => {
              this.undoRemove()
            })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#2a2a3e')
        .borderRadius(16)
        .padding({ left: 16, right: 12 })
        .margin({ left: 16, right: 16, bottom: 8 })
        .shadow({ radius: 12, color: '#2a2a3e44', offsetY: -2 })
        .transition(TransitionEffect.OPACITY.animation({ duration: 250 }))
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f8f8fc')
  }

  @Builder
  FavoriteItemBuilder(item: FavoriteItem) {
    Row() {
      // Icon
      Column() {
        Image(item.icon)
          .width(22)
          .height(22)
          .fillColor('#fff')
      }
      .width(44)
      .height(44)
      .borderRadius(12)
      .backgroundColor(item.color)
      .justifyContent(FlexAlign.Center)
      .margin({ right: 12 })

      // Content
      Column() {
        Text(item.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1a1a2e')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(item.description)
          .fontSize(12)
          .fontColor('#888')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        Row({ space: 8 }) {
          Text(item.category)
            .fontSize(10)
            .fontColor(item.color)
            .backgroundColor(item.color + '18')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
          Text(item.date)
            .fontSize(10)
            .fontColor('#aaa')
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Delete Button
      Column() {
        Image($r('sys.media.ohos_ic_public_remove'))
          .width(18)
          .height(18)
          .fillColor('#ff4d4f')
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor('#fff1f0')
      .justifyContent(FlexAlign.Center)
      .margin({ left: 8 })
      .onClick(() => {
        this.removeItem(item)
      })
    }
    .width('100%')
    .padding({ left: 14, right: 10, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .borderRadius(14)
    .shadow({ radius: 4, color: '#0000000a', offsetY: 2 })
  }

  @Builder
  SwipeDeleteBuilder(item: FavoriteItem) {
    Row() {
      Column() {
        Image($r('sys.media.ohos_ic_public_remove'))
          .width(20)
          .height(20)
          .fillColor('#fff')
        Text('Delete')
          .fontSize(10)
          .fontColor('#fff')
          .margin({ top: 2 })
      }
      .width(70)
      .height('100%')
      .backgroundColor('#ff4d4f')
      .justifyContent(FlexAlign.Center)
      .borderRadius({ topRight: 14, bottomRight: 14 })
      .onClick(() => {
        this.removeItem(item)
      })
    }
  }

  private removeItem(item: FavoriteItem) {
    const index = this.favoritesList.findIndex(fav => fav.id === item.id)
    if (index !== -1) {
      this.removedItem = item
      this.favoritesList.splice(index, 1)
      this.showUndoPopup = true

      if (this.undoTimer !== -1) {
        clearTimeout(this.undoTimer)
      }
      this.undoTimer = setTimeout(() => {
        this.showUndoPopup = false
        this.removedItem = null
        this.undoTimer = -1
      }, 4000)
    }
  }

  private undoRemove() {
    if (this.removedItem) {
      this.favoritesList.push(this.removedItem)
      this.favoritesList.sort((a, b) => b.id - a.id)
      this.showUndoPopup = false
      this.removedItem = null
      if (this.undoTimer !== -1) {
        clearTimeout(this.undoTimer)
        this.undoTimer = -1
      }
    }
  }
}