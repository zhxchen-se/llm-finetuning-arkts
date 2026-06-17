import {
  Align,
  AnimationOptions,
  Column,
  Curve,
  Flex,
  FlexAlign,
  FontSize,
  FontWeight,
  Image,
  LinearGradient,
  ObjectFit,
  PanGesture,
  Row,
  Stack,
  Text,
  animateTo,
  @Builder,
  @Component,
  @Entry,
  @State,
  @Styles
} from '@kit.ArkUI';

interface CardItem {
  id: number;
  name: string;
  age: number;
  bio: string;
  gradient: string[];
  tag: string;
}

@Entry
@Component
struct Index {
  @State cards: CardItem[] = [
    {
      id: 1,
      name: 'Ava',
      age: 26,
      bio: 'Designer, coffee lover, and weekend hiker.',
      gradient: ['#FF7A90', '#FFB199'],
      tag: 'Creative'
    },
    {
      id: 2,
      name: 'Liam',
      age: 29,
      bio: 'Photographer exploring cities and street food.',
      gradient: ['#4FACFE', '#00F2FE'],
      tag: 'Adventurous'
    },
    {
      id: 3,
      name: 'Maya',
      age: 24,
      bio: 'Musician, bookworm, and sunset chaser.',
      gradient: ['#A18CD1', '#FBC2EB'],
      tag: 'Music'
    },
    {
      id: 4,
      name: 'Noah',
      age: 31,
      bio: 'Chef who believes breakfast is the best meal.',
      gradient: ['#84FAB0', '#8FD3F4'],
      tag: 'Foodie'
    },
    {
      id: 5,
      name: 'Sofia',
      age: 27,
      bio: 'Travel blogger with a passion for ocean views.',
      gradient: ['#F6D365', '#FDA085'],
      tag: 'Travel'
    }
  ];

  @State activeIndex: number = 0;
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State isDragging: boolean = false;
  @State result: string = 'Swipe right to accept, left to reject';

  private readonly cardWidth: number = 320;
  private readonly cardHeight: number = 460;
  private readonly swipeThreshold: number = 120;

  aboutToAppear(): void {
    this.result = 'Swipe right to accept, left to reject';
  }

  build() {
    Column() {
      Text('Swipe Cards')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ top: 40, bottom: 12 })

      Text(this.result)
        .fontSize(15)
        .fontColor('#6B7280')
        .margin({ bottom: 24 })

      Stack({ alignContent: Align.Center }) {
        ForEach(this.getVisibleCards(), (item: CardItem) => {
          this.Card(item, this.activeIndex === item.id - 1)
        }, (item: CardItem) => item.id.toString())
      }
      .width('100%')
      .height(560)
      .margin({ bottom: 28 })

      Row() {
        this.ActionButton('✕', '#FF4D6D', () => this.swipeLeft())
        this.ActionButton('★', '#FFC857', () => {
          this.result = 'Super liked!';
          this.swipeRight(true);
        })
        this.ActionButton('✓', '#22C55E', () => this.swipeRight(false))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .gap(44)

      if (this.cards.length === 0) {
        Text('No more cards. Refresh to try again.')
          .fontSize(18)
          .fontColor('#6B7280')
          .margin({ top: 24 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  ActionButton(label: string, color: string, action: () => void) {
    Column() {
      Text(label)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
    }
    .width(62)
    .height(62)
    .borderRadius(31)
    .backgroundColor(color)
    .shadow({ radius: 16, color: '#00000018', offsetX: 0, offsetY: 8 })
    .onClick(() => action())
  }

  @Builder
  Card(item: CardItem, isActive: boolean) {
    Stack({ alignContent: Align.BottomLeft }) {
      Column() {
        Stack({ alignContent: Align.Center }) {
          Text(item.name.charAt(0))
            .fontSize(86)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .opacity(0.9)
        }
        .width('100%')
        .height(this.cardHeight - 120)
        .borderRadius(28)
        .background(this.cardGradient(item.gradient))
        .clip(true)

        Column() {
          Row() {
            Text(item.name)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')

            Text(` · ${item.age}`)
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#374151')
          }
          .width('100%')
          .margin({ top: 16, bottom: 8 })

          Row() {
            Text(item.tag)
              .fontSize(13)
              .fontColor('#FFFFFF')
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .borderRadius(999)
              .backgroundColor('#111827')
              .opacity(0.82)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .margin({ bottom: 10 })

          Text(item.bio)
            .fontSize(16)
            .fontColor('#4B5563')
            .width('100%')
            .lineHeight(24)
        }
        .width('100%')
        .padding(18)
        .backgroundColor('#FFFFFF')
      }
      .width(this.cardWidth)
      .height(this.cardHeight)
      .borderRadius(28)
      .shadow({ radius: 24, color: '#00000022', offsetX: 0, offsetY: 14 })
      .translate({ x: this.offsetX, y: this.offsetY })
      .rotate({ angle: this.isDragging ? this.offsetX / 18 : 0 })
      .opacity(this.getCardOpacity(item.id))
      .scale(this.getCardScale(item.id))
      .gesture(
        isActive
          ? PanGesture()
              .onActionStart(() => {
                this.isDragging = true;
              })
              .onActionUpdate((event: GestureEvent) => {
                this.offsetX = event.offsetX;
                this.offsetY = event.offsetY;
              })
              .onActionEnd((event: GestureEvent) => {
                this.isDragging = false;

                if (event.offsetX > this.swipeThreshold) {
                  this.swipeRight(false);
                } else if (event.offsetX < -this.swipeThreshold) {
                  this.swipeLeft();
                } else {
                  this.resetCard();
                }
              })
          : undefined
      )

      if (isActive && this.isDragging) {
        Column() {
          if (this.offsetX > 0) {
            Text('ACCEPT')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor('#22C55E')
              .rotate({ angle: -18 })
              .padding({ left: 14, right: 14 })
              .borderWidth(4)
              .borderColor('#22C55E')
              .borderRadius(8)
          } else {
            Text('REJECT')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF4D6D')
              .rotate({ angle: 18 })
              .padding({ left: 14, right: 14 })
              .borderWidth(4)
              .borderColor('#FF4D6D')
              .borderRadius(8)
          }
        }
        .position({ x: this.offsetX > 0 ? 28 : undefined, y: 54 })
        .alignSelf(this.offsetX > 0 ? Align.Start : Align.End)
      }
    }
    .width(this.cardWidth)
    .height(this.cardHeight)
    .zIndex(this.getZIndex(item.id))
  }

  private getVisibleCards(): CardItem[] {
    const visible = this.cards.slice(0, 3);
    return visible.reverse();
  }

  private getZIndex(id: number): number {
    const index = this.cards.findIndex((item: CardItem) => item.id === id);
    return 10 - index;
  }

  private getCardOpacity(id: number): number {
    const index = this.cards.findIndex((item: CardItem) => item.id === id);
    if (index === 0) {
      return 1;
    }
    if (index === 1) {
      return 0.86;
    }
    if (index === 2) {
      return 0.72;
    }
    return 0;
  }

  private getCardScale(id: number): number {
    const index = this.cards.findIndex((item: CardItem) => item.id === id);
    if (index === 0) {
      return 1;
    }
    if (index === 1) {
      return 0.94;
    }
    if (index === 2) {
      return 0.88;
    }
    return 0.82;
  }

  private cardGradient(colors: string[]): LinearGradient {
    return new LinearGradient(Direction.RightTop, colors);
  }

  private resetCard(): void {
    animateTo(
      {
        duration: 260,
        curve: Curve.EaseOut
      } as AnimationOptions,
      () => {
        this.offsetX = 0;
        this.offsetY = 0;
      }
    );
  }

  private swipeLeft(): void {
    if (this.cards.length === 0) {
      return;
    }

    const rejected = this.cards[0];

    animateTo(
      {
        duration: 320,
        curve: Curve.EaseIn
      } as AnimationOptions,
      () => {
        this.offsetX = -this.cardWidth * 1.4;
        this.offsetY = 80;
      }
    ).finally(() => {
      this.cards.shift();
      this.activeIndex = this.activeIndex + 1;
      this.result = `Rejected ${rejected.name}`;
      this.resetCard();
    });
  }

  private swipeRight(isSuperLike: boolean): void {
    if (this.cards.length === 0) {
      return;
    }

    const accepted = this.cards[0];

    animateTo(
      {
        duration: 320,
        curve: Curve.EaseIn
      } as AnimationOptions,
      () => {
        this.offsetX = this.cardWidth * 1.4;
        this.offsetY = 80;
      }
    ).finally(() => {
      this.cards.shift();
      this.activeIndex = this.activeIndex + 1;
      this.result = isSuperLike ? `Super liked ${accepted.name}!` : `Accepted ${accepted.name}`;
      this.resetCard();
    });
  }
}