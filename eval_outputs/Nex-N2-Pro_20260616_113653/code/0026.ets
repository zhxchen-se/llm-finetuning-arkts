interface SlideData {
  id: number;
  title: string;
  subtitle: string;
  description: string;
  color: ResourceColor;
  accent: ResourceColor;
}

interface SwiperDataObject {
  heading: string;
  items: SlideData[];
}

interface SwiperConfigObject {
  index: number;
  loop: boolean;
  autoPlay: boolean;
  interval: number;
  vertical: boolean;
  indicator: boolean;
  curve: Curve;
}

@Entry
@Component
struct Index {
  @State swiperData: SwiperDataObject = {
    heading: 'Featured Collections',
    items: [
      {
        id: 1,
        title: 'Mountain Escape',
        subtitle: 'Nature Travel',
        description: 'Explore quiet trails, fresh air and scenic mountain views.',
        color: '#1E88E5',
        accent: '#BBDEFB'
      },
      {
        id: 2,
        title: 'Urban Lifestyle',
        subtitle: 'City Design',
        description: 'Discover modern spaces, smart tools and daily inspiration.',
        color: '#43A047',
        accent: '#C8E6C9'
      },
      {
        id: 3,
        title: 'Creative Studio',
        subtitle: 'Art & Ideas',
        description: 'Build beautiful concepts with colors, shapes and motion.',
        color: '#8E24AA',
        accent: '#E1BEE7'
      },
      {
        id: 4,
        title: 'Ocean Journey',
        subtitle: 'Adventure',
        description: 'Follow the coast, enjoy the breeze and find new horizons.',
        color: '#E53935',
        accent: '#FFCDD2'
      }
    ]
  };

  @State swiperConfig: SwiperConfigObject = {
    index: 0,
    loop: true,
    autoPlay: true,
    interval: 2500,
    vertical: false,
    indicator: false,
    curve: Curve.Ease
  };

  build() {
    Scroll() {
      Column() {
        Text('Object-bound Swiper')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ bottom: 8 });

        Text('A single data object and a single options object are bound to the custom Swiper component.')
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ bottom: 22 });

        ObjectBoundSwiper({
          data: this.swiperData,
          config: this.swiperConfig,
          height: 420
        });

        Text('Object binding keeps the Swiper configuration and slide data separate from the UI.')
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ top: 18 });
      }
      .width('100%')
      .padding(24);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F8FB');
  }
}

@Component
struct ObjectBoundSwiper {
  @Prop data: SwiperDataObject = {
    heading: 'Swiper',
    items: []
  };

  @Prop config: SwiperConfigObject = {
    index: 0,
    loop: true,
    autoPlay: true,
    interval: 2500,
    vertical: false,
    indicator: false,
    curve: Curve.Ease
  };

  @Prop height: number = 420;

  @State currentIndex: number = 0;

  build() {
    Column() {
      Text(this.data.heading)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F2937')
        .margin({ bottom: 12 });

      Swiper(this.config) {
        ForEach(this.data.items, (item: SlideData, index: number) => {
          this.SlideCard(item, index);
        }, (item: SlideData) => item.id);
      }
      .width('100%')
      .height(this.height)
      .borderRadius(28)
      .clip(true)
      .onChange((index: number) => {
        this.currentIndex = index;
      });

      Row() {
        ForEach(this.data.items, (item: SlideData, index: number) => {
          Row()
            .width(this.currentIndex === item.id - 1 ? 24 : 8)
            .height(8)
            .borderRadius(4)
            .backgroundColor(this.currentIndex === item.id - 1 ? item.color : '#D1D5DB')
            .margin({ right: index === this.data.items.length - 1 ? 0 : 6 });
        }, (item: SlideData) => item.id);
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 14 });

      Text(
        this.data.items.length > 0
          ? `${this.currentIndex + 1} / ${this.data.items.length} - ${this.data.items[this.currentIndex].title}`
          : 'No items'
      )
        .fontSize(14)
        .fontColor('#6B7280')
        .width('100%')
        .margin({ top: 10 });
    }
    .width('100%');
  }

  @Builder
  SlideCard(item: SlideData, index: number) {
    Column() {
      Row() {
        Text(`0${index + 1}`)
          .fontSize(44)
          .fontWeight(FontWeight.Bold)
          .fontColor(item.accent);

        Text('Featured')
          .fontSize(14)
          .fontColor(item.accent)
          .opacity(0.95)
          .margin({ left: 12 });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween);

      Text(item.title)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width('86%')
        .margin({ top: 54 });

      Text(item.subtitle)
        .fontSize(16)
        .fontColor(item.accent)
        .width('86%')
        .margin({ top: 8 });

      Text(item.description)
        .fontSize(14)
        .fontColor('#FFFFFF')
        .opacity(0.9)
        .width('86%')
        .lineHeight(22)
        .margin({ top: 18 });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .padding(28)
    .backgroundColor(item.color)
    .borderRadius(28)
    .shadow({
      radius: 18,
      color: 'rgba(0, 0, 0, 0.25)',
      offsetX: 0,
      offsetY: 10
    });
  }
}