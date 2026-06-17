interface FilterOption {
  name: string;
  effect: string;
  accent: string;
  hint: string;
}

@Entry
@Component
struct Index {
  @State selectedFilter: number = 0;

  private filterOptions: FilterOption[] = [
    {
      name: 'Original',
      effect: 'none',
      accent: '#E2E8F0',
      hint: 'Shows the image without any color adjustment.'
    },
    {
      name: 'Warm',
      effect: 'sepia(25%) saturate(160%) brightness(106%)',
      accent: '#F59E0B',
      hint: 'Adds golden highlights and a warmer mood.'
    },
    {
      name: 'Cool',
      effect: 'hue-rotate(190deg) saturate(130%) brightness(105%)',
      accent: '#38BDF8',
      hint: 'Shifts colors toward a cooler blue tone.'
    },
    {
      name: 'Vintage',
      effect: 'sepia(45%) contrast(110%) brightness(92%) saturate(85%)',
      accent: '#A78BFA',
      hint: 'Creates a soft faded retro look.'
    },
    {
      name: 'Vivid',
      effect: 'saturate(220%) contrast(115%) brightness(105%)',
      accent: '#22C55E',
      hint: 'Boosts color intensity for a punchy image.'
    },
    {
      name: 'Mono',
      effect: 'grayscale(100%) contrast(120%)',
      accent: '#94A3B8',
      hint: 'Converts the image to classic black and white.'
    },
    {
      name: 'Night',
      effect: 'brightness(75%) contrast(140%) saturate(85%)',
      accent: '#818CF8',
      hint: 'Darkens the image for a cinematic feel.'
    },
    {
      name: 'Candy',
      effect: 'saturate(240%) hue-rotate(-10deg) contrast(105%)',
      accent: '#F472B6',
      hint: 'Makes colors brighter and more playful.'
    },
    {
      name: 'Fade',
      effect: 'brightness(112%) contrast(88%) saturate(75%) sepia(18%)',
      accent: '#D97706',
      hint: 'Lifts shadows for a soft faded finish.'
    }
  ];

  build() {
    Scroll() {
      Column() {
        Text('Color Filter Studio')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F8FAFC')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 36, bottom: 8 })

        Text('Tap a filter chip to change the image in real time.')
          .fontSize(15)
          .fontColor('#94A3B8')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 24 })

        Image($r('app.media.icon'))
          .width('86%')
          .aspectRatio(1)
          .objectFit(ImageFit.Cover)
          .backgroundColor('#111827')
          .borderRadius(28)
          .border({ width: 1, color: 'rgba(148, 163, 184, 0.25)' })
          .shadow({ radius: 28, color: 'rgba(0, 0, 0, 0.35)', offsetX: 0, offsetY: 16 })
          .filter(this.filterOptions[this.selectedFilter].effect)
          .margin({ bottom: 22 })

        Text('Current filter')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#94A3B8')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 2 })

        Text(this.filterOptions[this.selectedFilter].name)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.filterOptions[this.selectedFilter].accent)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 6 })

        Text(this.filterOptions[this.selectedFilter].hint)
          .fontSize(15)
          .fontColor('#CBD5E1')
          .textAlign(TextAlign.Center)
          .width('100%')
          .lineHeight(22)
          .margin({ bottom: 22 })

        Divider()
          .width('100%')
          .backgroundColor('#334155')
          .margin({ bottom: 24 })

        Text('Filter effects')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F8FAFC')
          .textAlign(TextAlign.Left)
          .width('100%')
          .margin({ bottom: 6 })

        Text('Tap any chip below to apply it to the image.')
          .fontSize(14)
          .fontColor('#94A3B8')
          .textAlign(TextAlign.Left)
          .width('100%')
          .margin({ bottom: 16 })

        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
          ForEach(this.filterOptions, (option: FilterOption, index: number) => {
            Button(option.name)
              .width(145)
              .height(46)
              .borderRadius(999)
              .backgroundColor(index === this.selectedFilter ? option.accent : '#1E293B')
              .border({ width: 1, color: index === this.selectedFilter ? option.accent : '#334152' })
              .fontColor(index === this.selectedFilter ? '#0F172A' : '#E2E8F0')
              .fontSize(14)
              .fontWeight(index === this.selectedFilter ? FontWeight.Bold : FontWeight.Medium)
              .stateEffect(true)
              .onClick(() => {
                this.selectedFilter = index;
              })
          }, (option: FilterOption, index: number) => option.name + index)
        }
          .width('100%')
          .gap(12)
          .margin({ bottom: 26 })

        Text('Tip: replace the sample image resource with your own photo to preview personal images.')
          .fontSize(13)
          .fontColor('#64748B')
          .textAlign(TextAlign.Center)
          .width('100%')
          .lineHeight(20)
          .margin({ bottom: 8 })

        Text('Filters are applied instantly with ArkUI image filters.')
          .fontSize(13)
          .fontColor('#64748B')
          .textAlign(TextAlign.Center)
          .width('100%')
          .lineHeight(20)
      }
        .width('100%')
        .padding({ left: 24, right: 24, top: 20, bottom: 32 })
        .alignItems(HorizontalAlign.Center)
    }
      .width('100%')
      .height('100%')
      .backgroundColor('#0F172A')
  }
}