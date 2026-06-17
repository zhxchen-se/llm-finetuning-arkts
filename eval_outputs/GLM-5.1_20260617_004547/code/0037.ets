interface CardData {
  id: number;
  name: string;
  age: number;
  description: string;
  bgColor: string;
  emoji: string;
}

@Entry
@Component
struct Index {
  @State cardList: CardData[] = [
    { id: 1, name: 'Emma', age: 24, description: 'Loves hiking and outdoor adventures', bgColor: '#FF9A9E', emoji: '🌲' },
    { id: 2, name: 'Liam', age: 27, description: 'Coffee enthusiast and amateur photographer', bgColor: '#A18CD1', emoji: '☕' },
    { id: 3, name: 'Sophia', age: 22, description: 'Aspiring chef and world traveler', bgColor: '#FBC2EB', emoji: '✈️' },
    { id: 4, name: 'Noah', age: 29, description: 'Tech geek who enjoys gaming', bgColor: '#84FAB0', emoji: '🎮' },
    { id: 5, name: 'Olivia', age: 25, description: 'Bookworm with a passion for music', bgColor: '#8FD3F4', emoji: '📚' },
    { id: 6, name: 'James', age: 28, description: 'Fitness buff and yoga instructor', bgColor: '#FCCB90', emoji: '🧘' }
  ];

  @State currentIndex: number = 0;
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State angle: number = 0;

  private swipeThreshold: number = 100;

  private swipeCard(isRight: boolean) {
    animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
      this.offsetX = isRight ? 500 : -500;
      this.angle = isRight ? 30 : -30;
    });

    setTimeout(() => {
      animateTo({ duration: 0 }, () => {
        let nextIndex = this.currentIndex + 1;
        if (nextIndex >= this.cardList.length) {
          nextIndex = 0;
        }
        this.currentIndex = nextIndex;
        this.offsetX = 0;
        this.offsetY = 0;
        this.angle = 0;
      });
    }, 300);
  }

  private resetCardPosition() {
    animateTo({ duration: 200, curve: Curve.EaseOut }, () => {
      this.offsetX = 0;
      this.offsetY = 0;
      this.angle = 0;
    });
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('Discover')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
        Blank()
        Text('⚙️')
          .fontSize(24)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })

      // Card Stack
      Stack() {
        ForEach(this.cardList, (item: CardData, index?: number) => {
          if (index !== undefined && index >= this.currentIndex && index < this.currentIndex + 3) {
            Column() {
              // Card Content
              Column() {
                Text(item.emoji)
                  .fontSize(80)
                  .margin({ top: 40 })

                Text(`${item.name}, ${item.age}`)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333')
                  .margin({ top: 20 })

                Text(item.description)
                  .fontSize(16)
                  .fontColor('#666')
                  .margin({ top: 8 })
                  .textAlign(TextAlign.Center)
                  .padding({ left: 20, right: 20 })
              }
              .width('100%')
              .height('100%')
              .borderRadius(24)
              .backgroundColor(item.bgColor)
              .shadow({ radius: 20, color: '#33000000', offsetY: 10 })
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Center)

              // Like/Nope Overlays
              if (index === this.currentIndex) {
                // LIKE overlay (Right swipe)
                Text('LIKE')
                  .fontSize(48)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4CAF50')
                  .borderWidth(4)
                  .borderColor('#4CAF50')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                  .rotate({ angle: -20 })
                  .opacity(Math.min(1, Math.max(0, this.offsetX / this.swipeThreshold)))
                  .position({ x: 30, y: 60 })
                  .zIndex(10)

                // NOPE overlay (Left swipe)
                Text('NOPE')
                  .fontSize(48)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#F44336')
                  .borderWidth(4)
                  .borderColor('#F44336')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                  .rotate({ angle: 20 })
                  .opacity(Math.min(1, Math.max(0, -this.offsetX / this.swipeThreshold)))
                  .position({ x: '65%', y: 60 })
                  .zIndex(10)
              }
            }
            .width('100%')
            .height('100%')
            .zIndex(this.cardList.length - index)
            .offset({
              x: index === this.currentIndex ? this.offsetX : 0,
              y: index === this.currentIndex ? this.offsetY : (index - this.currentIndex) * 8
            })
            .rotate({ angle: index === this.currentIndex ? this.angle : 0 })
            .scale({
              x: index === this.currentIndex ? 1 : 0.95 - (index - this.currentIndex - 1) * 0.05,
              y: index === this.currentIndex ? 1 : 0.95 - (index - this.currentIndex - 1) * 0.05
            })
            .gesture(
              index === this.currentIndex
                ? PanGesture()
                    .onActionUpdate((event: GestureEvent) => {
                      this.offsetX = event.offsetX;
                      this.offsetY = event.offsetY;
                      this.angle = event.offsetX / 20;
                    })
                    .onActionEnd(() => {
                      if (Math.abs(this.offsetX) > this.swipeThreshold) {
                        this.swipeCard(this.offsetX > 0);
                      } else {
                        this.resetCardPosition();
                      }
                    })
                : GestureGroup(GestureMode.Exclusive, [])
            )
          }
        }, (item: CardData) => item.id.toString())
      }
      .width('85%')
      .height('65%')
      .margin({ top: 20 })

      // Action Buttons
      Row() {
        Button() {
          Text('✕')
            .fontSize(36)
            .fontColor('#F44336')
        }
        .width(70)
        .height(70)
        .borderRadius(35)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#22000000', offsetY: 4 })
        .type(ButtonType.Circle)
        .onClick(() => this.swipeCard(false))

        Button() {
          Text('♥')
            .fontSize(40)
            .fontColor('#4CAF50')
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#22000000', offsetY: 4 })
        .type(ButtonType.Circle)
        .onClick(() => this.swipeCard(true))
        .margin({ left: 40 })
      }
      .margin({ top: 40 })
      .justifyContent(FlexAlign.Center)

      // Progress Indicator
      Text(`${this.currentIndex + 1} / ${this.cardList.length}`)
        .fontSize(16)
        .fontColor('#888')
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}