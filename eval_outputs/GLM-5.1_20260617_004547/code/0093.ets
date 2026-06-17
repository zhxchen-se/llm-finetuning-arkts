import router from '@ohos.router'

interface CardData {
  id: number
  title: string
  subtitle: string
  color: string
  icon: string
}

@Builder
function NavDestBuilder(name: string, param: Object) {
  if (name === 'Detail') {
    DetailPage({ data: param as CardData })
  }
}

@Entry
@Component
struct Index {
  @Provide pageStack: NavPathStack = new NavPathStack()

  private items: CardData[] = [
    { id: 0, title: 'Sunset', subtitle: 'Warm evening glow', color: '#FF6B6B', icon: '🌅' },
    { id: 1, title: 'Ocean', subtitle: 'Deep blue waves', color: '#4ECDC4', icon: '🌊' },
    { id: 2, title: 'Forest', subtitle: 'Lush green canopy', color: '#2ECC71', icon: '🌲' },
    { id: 3, title: 'Mountain', subtitle: 'Peak above clouds', color: '#45B7D1', icon: '⛰️' },
    { id: 4, title: 'Desert', subtitle: 'Golden sand dunes', color: '#F39C12', icon: '🏜️' },
    { id: 5, title: 'Aurora', subtitle: 'Northern lights', color: '#9B59B6', icon: '✨' }
  ]

  build() {
    Navigation(this.pageStack) {
      Column() {
        // Header
        Column() {
          Text('Page Transition')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Text('Shared Element Transition Demo')
            .fontSize(14)
            .fontColor('#CCFFFFFF')
            .margin({ top: 6 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 56, bottom: 24 })
        .linearGradient({
          direction: GradientDirection.BottomRight,
          colors: [['#667eea', 0.0], ['#764ba2', 1.0]]
        })

        // Card grid
        Scroll() {
          Grid() {
            ForEach(this.items, (item: CardData) => {
              GridItem() {
                Column() {
                  Text(item.icon)
                    .fontSize(40)
                    .margin({ bottom: 8 })
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  Text(item.subtitle)
                    .fontSize(11)
                    .fontColor('#CCFFFFFF')
                    .margin({ top: 2 })
                }
                .width('100%')
                .height(160)
                .backgroundColor(item.color)
                .borderRadius(20)
                .justifyContent(FlexAlign.Center)
                .shadow({ radius: 8, color: '#20000000', offsetY: 4 })
                .sharedTransition('card_' + item.id, {
                  duration: 500,
                  curve: Curve.SpringMotion
                })
                .onClick(() => {
                  this.pageStack.pushPath({ name: 'Detail', param: item })
                })
              }
              .padding(6)
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(0)
          .columnsGap(0)
          .width('100%')
          .padding({ left: 10, right: 10, top: 12, bottom: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F2F5')
    }
    .mode(NavigationMode.Stack)
    .navDestination(NavDestBuilder)
  }
}

@Component
struct DetailPage {
  @Consume pageStack: NavPathStack
  @Prop data: CardData
  @State detailOpacity: number = 0
  @State detailOffsetY: number = 30

  build() {
    Column() {
      // Back button
      Row() {
        Text('← Back')
          .fontSize(16)
          .fontColor(Color.White)
          .onClick(() => {
            this.pageStack.pop()
          })
      }
      .width('100%')
      .padding({ left: 20, top: 52, bottom: 12 })

      // Hero card with shared transition
      Column() {
        Text(this.data.icon)
          .fontSize(72)
          .margin({ bottom: 12 })
        Text(this.data.title)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        Text(this.data.subtitle)
          .fontSize(14)
          .fontColor('#CCFFFFFF')
          .margin({ top: 4 })
      }
      .width('92%')
      .padding(24)
      .backgroundColor(this.data.color)
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .margin({ top: 12 })
      .sharedTransition('card_' + this.data.id, {
        duration: 500,
        curve: Curve.SpringMotion
      })

      // Detail content with fade-in animation
      Column() {
        Text('About This Theme')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2C3E50')
          .margin({ bottom: 10 })

        Text('This page demonstrates a shared element transition in HarmonyOS ArkTS. The card smoothly animates from the grid on the previous page into this expanded detail view, creating a visually cohesive navigation experience with spatial continuity.')
          .fontSize(14)
          .fontColor('#555555')
          .lineHeight(22)

        Row() {
          Column() {
            Text('Duration')
              .fontSize(12)
              .fontColor('#999999')
            Text('500ms')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2C3E50')
              .margin({ top: 4 })
          }
          .layoutWeight(1)

          Column() {
            Text('Curve')
              .fontSize(12)
              .fontColor('#999999')
            Text('Spring')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2C3E50')
              .margin({ top: 4 })
          }
          .layoutWeight(1)

          Column() {
            Text('Type')
              .fontSize(12)
              .fontColor('#999999')
            Text('Shared')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2C3E50')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 20 })
        .padding(16)
        .backgroundColor('#F8F9FA')
        .borderRadius(12)
      }
      .width('92%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .margin({ top: 20 })
      .shadow({ radius: 6, color: '#15000000', offsetY: 3 })
      .opacity(this.detailOpacity)
      .translate({ y: this.detailOffsetY })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F2F5')
    .onAppear(() => {
      animateTo({ duration: 400, delay: 350, curve: Curve.EaseOut }, () => {
        this.detailOpacity = 1
        this.detailOffsetY = 0
      })
    })
  }
}