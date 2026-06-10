import { PanGesture, GestureEvent } from '@ohos.arkui.UIGesture';

interface CardItem {
  id: number;
  name: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State rotation: number = 0;
  @State opacity: number = 1;
  @State showLike: boolean = false;
  @State showNope: boolean = false;
  @State noMoreCards: boolean = false;
  @State isAnimating: boolean = false;

  private cards: CardItem[] = [
    { id: 1, name: 'Alex', color: '#FF6B6B' },
    { id: 2, name: 'Jordan', color: '#4ECDC4' },
    { id: 3, name: 'Taylor', color: '#45B7D1' },
    { id: 4, name: 'Morgan', color: '#96CEB4' },
    { id: 5, name: 'Casey', color: '#FFEAA7' }
  ];

  build() {
    Column() {
      if (this.noMoreCards) {
        Column() {
          Text('No more cards')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          Button('Start Over')
            .onClick(() => this.reset())
            .fontSize(18)
            .padding({ left: 30, right: 30 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Stack({ alignContent: Alignment.Center }) {
          // Next card (peeking behind)
          if (this.currentIndex + 1 < this.cards.length) {
            this.CardBuilder(this.cards[this.currentIndex + 1], false)
              .zIndex(0)
          }
          // Current card (interactive)
          if (this.currentIndex < this.cards.length) {
            this.CardBuilder(this.cards[this.currentIndex], true)
              .zIndex(1)
              .gesture(
                PanGesture({ direction: PanDirection.Horizontal })
                  .onActionUpdate((event: GestureEvent) => {
                    if (this.isAnimating) return;
                    this.offsetX = event.offsetX;
                    this.offsetY = event.offsetY;
                    this.rotation = this.offsetX / 20;
                    this.showLike = this.offsetX > 100;
                    this.showNope = this.offsetX < -100;
                  })
                  .onActionEnd((event: GestureEvent) => {
                    if (this.isAnimating) return;
                    if (this.offsetX > 150) {
                      // Swipe right - accept
                      this.isAnimating = true;
                      animateTo({
                        duration: 300,
                        curve: Curve.EaseOut,
                        onFinish: () => {
                          this.nextCard();
                          this.isAnimating = false;
                        }
                      }, () => {
                        this.offsetX = 500;
                        this.rotation = 30;
                        this.opacity = 0;
                      });
                    } else if (this.offsetX < -150) {
                      // Swipe left - reject
                      this.isAnimating = true;
                      animateTo({
                        duration: 300,
                        curve: Curve.EaseOut,
                        onFinish: () => {
                          this.nextCard();
                          this.isAnimating = false;
                        }
                      }, () => {
                        this.offsetX = -500;
                        this.rotation = -30;
                        this.opacity = 0;
                      });
                    } else {
                      // Return to center
                      animateTo({ duration: 200, curve: Curve.EaseOut }, () => {
                        this.offsetX = 0;
                        this.rotation = 0;
                        this.offsetY = 0;
                      });
                    }
                    this.showLike = false;
                    this.showNope = false;
                  })
              )
          }
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }

  @Builder CardBuilder(card: CardItem, isTop: boolean) {
    Stack() {
      Column() {
        Text(card.name)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 40 })
        // Placeholder for image/icon
        Text('👤')
          .fontSize(80)
          .margin({ top: 20 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .borderRadius(20)
      .backgroundColor(card.color)
      .shadow({
        radius: 20,
        color: '#00000030',
        offsetX: 0,
        offsetY: 5
      })

      // Like / Nope stamps
      if (isTop) {
        if (this.showLike) {
          Text('LIKE')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
            .border({ width: 4, color: '#4CAF50', style: BorderStyle.Solid })
            .padding({ left: 15, right: 15, top: 5, bottom: 5 })
            .rotate({ angle: -15 })
            .position({ x: 30, y: 50 })
        }
        if (this.showNope) {
          Text('NOPE')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F44336')
            .border({ width: 4, color: '#F44336', style: BorderStyle.Solid })
            .padding({ left: 15, right: 15, top: 5, bottom: 5 })
            .rotate({ angle: 15 })
            .position({ x: '70%', y: 50 })
        }
      }
    }
    .width('80%')
    .height('60%')
    .translate({ x: isTop ? this.offsetX : 0, y: isTop ? this.offsetY : 0 })
    .rotate({ angle: isTop ? this.rotation : 0 })
    .opacity(isTop ? this.opacity : 1)
  }

  nextCard() {
    if (this.currentIndex + 1 < this.cards.length) {
      this.currentIndex++;
      this.offsetX = 0;
      this.offsetY = 0;
      this.rotation = 0;
      this.opacity = 1;
    } else {
      this.noMoreCards = true;
    }
  }

  reset() {
    this.currentIndex = 0;
    this.noMoreCards = false;
    this.offsetX = 0;
    this.offsetY = 0;
    this.rotation = 0;
    this.opacity = 1;
    this.isAnimating = false;
  }
}