import { promptAction } from '@ohos.base';

enum SwipeStatus {
  None,
  Left,
  Right
}

interface CardItem {
  id: number;
  title: string;
  description: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State cards: CardItem[] = []
  @State offset: { x: number, y: number } = { x: 0, y: 0 }
  @State rotate: number = 0
  @State swipeStatus: SwipeStatus = SwipeStatus.None
  @State isAnimating: boolean = false
  private threshold: number = 100
  private screenWidth: number = 0

  aboutToAppear() {
    this.screenWidth = this.getContext(this) as any
    try {
      const window = (this.getContext(this) as any).window
      if (window) {
        const props = window.getWindowProperties()
        this.screenWidth = props.windowSize.width
      }
    } catch (e) {
      this.screenWidth = 400
    }
    this.initCards()
  }

  initCards() {
    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEEAD', '#D4A5A5']
    for (let i = 0; i < 5; i++) {
      this.cards.push({
        id: i,
        title: `Card ${i + 1}`,
        description: 'Swipe right to accept, left to reject',
        color: colors[i % colors.length]
      })
    }
  }

  @Builder
  CardContent(item: CardItem, isTop: boolean) {
    Column() {
      Text(item.title)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 10 })

      Text(item.description)
        .fontSize(16)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)

      Stack() {
        Text(this.swipeStatus === SwipeStatus.Right ? 'LIKE' : (this.swipeStatus === SwipeStatus.Left ? 'NOPE' : ''))
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.swipeStatus === SwipeStatus.Right ? '#4ECDC4' : '#FF6B6B')
          .opacity(this.swipeStatus === SwipeStatus.None ? 0 : 1)
          .rotate(this.swipeStatus === SwipeStatus.Right ? -15 : 15)
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center)
    }
    .width('90%')
    .height('60%')
    .backgroundColor(item.color)
    .borderRadius(20)
    .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: 5 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .translate({ x: this.offset.x, y: this.offset.y })
    .rotate(this.rotate)
    .opacity(isTop ? 1 : 0.8)
    .scale({ x: isTop ? 1 : 0.95, y: isTop ? 1 : 0.95 })
  }

  build() {
    Column() {
      Text('Swipe Cards')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 30 })

      Stack() {
        if (this.cards.length > 0) {
          ForEach(this.cards, (item: CardItem, index: number) => {
            let isTop = index === this.cards.length - 1
            this.CardContent(item, isTop)
              .gesture(
                isTop && !this.isAnimating
                  ? PanGesture()
                    .onActionStart((event) => {
                      this.isAnimating = true
                    })
                    .onActionUpdate((event) => {
                      this.offset = { x: event.offsetX, y: event.offsetY }
                      this.rotate = event.offsetX / 20
                      if (event.offsetX > 50) {
                        this.swipeStatus = SwipeStatus.Right
                      } else if (event.offsetX < -50) {
                        this.swipeStatus = SwipeStatus.Left
                      } else {
                        this.swipeStatus = SwipeStatus.None
                      }
                    })
                    .onActionEnd((event) => {
                      if (Math.abs(event.offsetX) > this.threshold) {
                        this.swipeCard(event.offsetX > 0)
                      } else {
                        this.resetCard()
                      }
                    })
                  : null
              )
          }, (item: CardItem) => item.id.toString())
        } else {
          Column() {
            Text('No more cards')
              .fontSize(20)
              .fontColor('#666666')
            Button('Reload')
              .margin({ top: 20 })
              .onClick(() => {
                this.initCards()
                this.offset = { x: 0, y: 0 }
                this.rotate = 0
                this.swipeStatus = SwipeStatus.None
              })
          }
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .height('60%')

      Column() {
        Text('Instructions')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ top: 20 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  swipeCard(accept: boolean) {
    const endX = accept ? this.screenWidth : -this.screenWidth
    const endRotate = accept ? 30 : -30

    animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
      this.offset = { x: endX, y: this.offset.y + 100 }
      this.rotate = endRotate
      this.swipeStatus = accept ? SwipeStatus.Right : SwipeStatus.Left
    }).finally(() => {
      if (this.cards.length > 0) {
        this.cards.pop()
      }
      this.offset = { x: 0, y: 0 }
      this.rotate = 0
      this.swipeStatus = SwipeStatus.None
      this.isAnimating = false

      if (this.cards.length === 0) {
        promptAction.showToast({ message: 'All cards swiped!' })
      }
    })
  }

  resetCard() {
    animateTo({ duration: 300, curve: Curve.Spring }, () => {
      this.offset = { x: 0, y: 0 }
      this.rotate = 0
      this.swipeStatus = SwipeStatus.None
    }).finally(() => {
      this.isAnimating = false
    })
  }
}