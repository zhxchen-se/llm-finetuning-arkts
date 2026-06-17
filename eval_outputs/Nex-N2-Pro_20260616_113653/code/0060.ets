interface ModeItem {
  name: string;
  short: string;
  fit: ImageFit;
  desc: string;
}

interface AlignItem {
  label: string;
  short: string;
  position: {
    horizontal: HorizontalAlign;
    vertical: VerticalAlign;
  };
}

interface SizePreset {
  width: number;
  height: number;
  label: string;
}

interface CalculatedSize {
  width: number;
  height: number;
  scaleX: number;
  scaleY: number;
  note: string;
}

@Component
struct SamplePoster {
  build() {
    Stack() {
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor('#0F172A')

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row()
          .width(360)
          .height(3)
          .backgroundColor('#FFFFFF')
          .opacity(0.12)
          .position({ x: -130 + item * 90, y: -120 })
          .rotate(35)
      }, (item: number) => item.toString())

      Column() {
        Text('SAMPLE IMAGE')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')

        Text('800 × 500 · aspect 8:5')
          .fontSize(13)
          .fontColor('#CBD5E1')
          .margin({ top: 6 })
      }
        .width('100%')
        .height('100%')
        .padding({ left: 18, right: 18, top: 16, bottom: 16 })
        .alignItems(ItemAlign.Start)
        .justifyContent(FlexAlign.End)
    }
      .width('100%')
      .height('100%')
      .borderRadius(16)
      .clip(true)
  }
}

@Component
struct CalculatedTile {
  @Prop item: ModeItem;
  @Prop align: AlignItem;
  @Prop sourceWidth: number;
  @Prop sourceHeight: number;
  @Prop targetWidth: number;
  @Prop targetHeight: number;

  private calculateSize(fit: ImageFit): CalculatedSize {
    const sw = this.sourceWidth;
    const sh = this.sourceHeight;
    const tw = this.targetWidth;
    const th = this.targetHeight;

    if (fit === ImageFit.FILL) {
      return {
        width: tw,
        height: th,
        scaleX: tw / sw,
        scaleY: th / sh,
        note: 'Fill forces both axes to the target size, so distortion is allowed.'
      };
    }

    if (fit === ImageFit.NONE) {
      return {
        width: sw,
        height: sh,
        scaleX: 1,
        scaleY: 1,
        note: 'None keeps the natural image size; the frame clips overflow.'
      };
    }

    if (fit === ImageFit.FIT_WIDTH) {
      const scale = tw / sw;
      return {
        width: tw,
        height: sh * scale,
        scaleX: scale,
        scaleY: scale,
        note: 'Fit width locks the width and scales height by the source aspect ratio.'
      };
    }

    if (fit === ImageFit.FIT_HEIGHT) {
      const scale = th / sh;
      return {
        width: sw * scale,
        height: th,
        scaleX: scale,
        scaleY: scale,
        note: 'Fit height locks the height and scales width by the source aspect ratio.'
      };
    }

    const containScale = Math.min(tw / sw, th / sh);
    if (fit === ImageFit.CONTAIN) {
      return {
        width: sw * containScale,
        height: sh * containScale,
        scaleX: containScale,
        scaleY: containScale,
        note: 'Contain keeps the full image visible and preserves aspect ratio.'
      };
    }

    const coverScale = Math.max(tw / sw, th / sh);
    return {
      width: sw * coverScale,
      height: sh * coverScale,
      scaleX: coverScale,
      scaleY: coverScale,
      note: 'Cover fills the frame, preserves aspect ratio, and crops overflow.'
    };
  }

  private horizontalOffset(child: number, parent: number, align: HorizontalAlign): number {
    if (align === HorizontalAlign.START) {
      return 0;
    }
    if (align === HorizontalAlign.END) {
      return parent - child;
    }
    return (parent - child) / 2;
  }

  private verticalOffset(child: number, parent: number, align: VerticalAlign): number {
    if (align === VerticalAlign.TOP) {
      return 0;
    }
    if (align === VerticalAlign.BOTTOM) {
      return parent - child;
    }
    return (parent - child) / 2;
  }

  build() {
    const size = this.calculateSize(this.item.fit);
    const x = this.horizontalOffset(size.width, this.targetWidth, this.align.position.horizontal);
    const y = this.verticalOffset(size.height, this.targetHeight, this.align.position.vertical);

    Column() {
      Stack() {
        SamplePoster()
          .width(size.width)
          .height(size.height)
          .position({ x: x, y: y })
      }
        .width(this.targetWidth)
        .height(this.targetHeight)
        .borderRadius(14)
        .borderWidth(1)
        .borderColor('#CBD5E1')
        .clip(true)

      Text(this.item.short)
        .fontSize(11)
        .fontColor('#475569')
        .margin({ top: 6 })
    }
      .width(this.targetWidth + 16)
      .alignItems(ItemAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State imageSrc: string = '';
  @State targetWidth: number = 260;
  @State targetHeight: number = 170;
  @State modeIndex: number = 0;
  @State alignIndex: number = 4;

  private readonly sourceWidth: number = 800;
  private readonly sourceHeight: number = 500;
  private readonly tileWidth: number = 128;
  private readonly tileHeight: number = 88;

  private readonly modes: ModeItem[] = [
    {
      name: 'Contain',
      short: 'Ratio in',
      fit: ImageFit.CONTAIN,
      desc: 'Preserve aspect ratio, fit the whole image inside the frame, and allow empty bars.'
    },
    {
      name: 'Cover',
      short: 'Crop fill',
      fit: ImageFit.COVER,
      desc: 'Preserve aspect ratio, fill the frame completely, and crop overflow.'
    },
    {
      name: 'Fit width',
      short: 'Width only',
      fit: ImageFit.FIT_WIDTH,
      desc: 'Match the target width and calculate height from the source aspect ratio.'
    },
    {
      name: 'Fit height',
      short: 'Height only',
      fit: ImageFit.FIT_HEIGHT,
      desc: 'Match the target height and calculate width from the source aspect ratio.'
    },
    {
      name: 'Fill',
      short: 'Stretch',
      fit: ImageFit.FILL,
      desc: 'Force the image to the target width and height; aspect ratio is not preserved.'
    },
    {
      name: 'None',
      short: 'Original',
      fit: ImageFit.NONE,
      desc: 'Use the natural image size; the target frame clips overflow.'
    }
  ];

  private readonly alignments: AlignItem[] = [
    { label: 'Start / Top', short: '↖', position: { horizontal: HorizontalAlign.START, vertical: VerticalAlign.TOP } },
    { label: 'Center / Top', short: '↑', position: { horizontal: HorizontalAlign.CENTER, vertical: VerticalAlign.TOP } },
    { label: 'End / Top', short: '↗', position: { horizontal: HorizontalAlign.END, vertical: VerticalAlign.TOP } },
    { label: 'Start / Center', short: '←', position: { horizontal: HorizontalAlign.START, vertical: VerticalAlign.CENTER } },
    { label: 'Center / Center', short: '•', position: { horizontal: HorizontalAlign.CENTER, vertical: VerticalAlign.CENTER } },
    { label: 'End / Center', short: '→', position: { horizontal: HorizontalAlign.END, vertical: VerticalAlign.CENTER } },
    { label: 'Start / Bottom', short: '↙', position: { horizontal: HorizontalAlign.START, vertical: VerticalAlign.BOTTOM } },
    { label: 'Center / Bottom', short: '↓', position: { horizontal: HorizontalAlign.CENTER, vertical: VerticalAlign.BOTTOM } },
    { label: 'End / Bottom', short: '↘', position: { horizontal: HorizontalAlign.END, vertical: VerticalAlign.BOTTOM } }
  ];

  private readonly sizePresets: SizePreset[] = [
    { width: 260, height: 170, label: '260 × 170' },
    { width: 220, height: 220, label: '220 × 220' },
    { width: 300, height: 150, label: '300 × 150' },
    { width: 180, height: 260, label: '180 × 260' }
  ];

  private readonly svgSource: string = `<svg xmlns="http://www.w3.org/2000/svg" width="800" height="500" viewBox="0 0 800 500">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#0ea5e9"/>
      <stop offset="1" stop-color="#7c3aed"/>
    </linearGradient>
  </defs>
  <rect width="800" height="500" fill="url(#g)"/>
  <circle cx="640" cy="130" r="58" fill="#fbbf24"/>
  <circle cx="665" cy="115" r="28" fill="#fff7ed" opacity="0.88"/>
  <path d="M0 365 L180 225 L330 340 L470 205 L800 395 V500 H0 Z" fill="#0f172a" opacity="0.55"/>
  <path d="M0 395 L180 265 L330 375 L470 255 L800 435 V500 H0 Z" fill="#020617" opacity="0.72"/>
  <g stroke="#ffffff" stroke-opacity="0.16" stroke-width="2">
    <path d="M0 100 H800 M0 200 H800 M0 300 H800 M0 400 H800"/>
    <path d="M100 0 V500 M200 0 V500 M300 0 V500 M400 0 V500 M500 0 V500 M600 0 V500 M700 0 V500"/>
  </g>
  <rect x="48" y="48" width="310" height="96" rx="22" fill="#ffffff" opacity="0.92"/>
  <text x="70" y="86" font-family="Arial, sans-serif" font-size="34" font-weight="700" fill="#0f172a">Sample image</text>
  <text x="70" y="116" font-family="Arial, sans-serif" font-size="18" fill="#334155">800 × 500 · aspect 8:5</text>
</svg>`;

  aboutToAppear() {
    this.imageSrc = `data:image/svg+xml;charset=utf-8,${encodeURIComponent(this.svgSource)}`;
  }

  private currentMode(): ModeItem {
    return this.modes[this.modeIndex];
  }

  private currentAlign(): AlignItem {
    return this.alignments[this.alignIndex];
  }

  private formatNumber(value: number): string {
    return Math.round(value).toString();
  }

  private isDistorted(size: CalculatedSize): boolean {
    return Math.abs(size.scaleX - size.scaleY) > 0.001;
  }

  private calculateSize(fit: ImageFit): CalculatedSize {
    const sw = this.sourceWidth;
    const sh = this.sourceHeight;
    const tw = this.targetWidth;
    const th = this.targetHeight;

    if (fit === ImageFit.FILL) {
      return {
        width: tw,
        height: th,
        scaleX: tw / sw,
        scaleY: th / sh,
        note: 'Fill forces both axes to the target size, so distortion is allowed.'
      };
    }

    if (fit === ImageFit.NONE) {
      return {
        width: sw,
        height: sh,
        scaleX: 1,
        scaleY: 1,
        note: 'None keeps the natural image size; the target frame clips overflow.'
      };
    }

    if (fit === ImageFit.FIT_WIDTH) {
      const scale = tw / sw;
      return {
        width: tw,
        height: sh * scale,
        scaleX: scale,
        scaleY: scale,
        note: 'Fit width locks the width and scales height by the source aspect ratio.'
      };
    }

    if (fit === ImageFit.FIT_HEIGHT) {
      const scale = th / sh;
      return {
        width: sw * scale,
        height: th,
        scaleX: scale,
        scaleY: scale,
        note: 'Fit height locks the height and scales width by the source aspect ratio.'
      };
    }

    const containScale = Math.min(tw / sw, th / sh);
    if (fit === ImageFit.CONTAIN) {
      return {
        width: sw * containScale,
        height: sh * containScale,
        scaleX: containScale,
        scaleY: containScale,
        note: 'Contain keeps the full image visible and preserves aspect ratio.'
      };
    }

    const coverScale = Math.max(tw / sw, th / sh);
    return {
      width: sw * coverScale,
      height: sh * coverScale,
      scaleX: coverScale,
      scaleY: coverScale,
      note: 'Cover fills the frame, preserves aspect ratio, and crops overflow.'
    };
  }

  @Builder
  SectionTitle(title: string, subtitle: string) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      Text(subtitle)
        .fontSize(12)
        .fontColor('#64748B')
        .margin({ top: 4 })
    }
      .width('100%')
      .alignItems(ItemAlign.Start)
      .margin({ top: 18, bottom: 10 })
  }

  @Builder
  ModeButton(item: ModeItem, index: number) {
    Button(item.name)
      .height(36)
      .fontSize(12)
      .fontColor(index === this.modeIndex ? '#FFFFFF' : '#0F172A')
      .backgroundColor(index === this.modeIndex ? '#2563EB' : '#E2E8F0')
      .borderRadius(12)
      .onClick(() => {
        this.modeIndex = index;
      })
  }

  @Builder
  ModeTile(item: ModeItem, align: AlignItem) {
    CalculatedTile({
      item: item,
      align: align,
      sourceWidth: this.sourceWidth,
      sourceHeight: this.sourceHeight,
      targetWidth: this.tileWidth,
      targetHeight: this.tileHeight
    })
  }

  build() {
    const mode = this.currentMode();
    const align = this.currentAlign();
    const calc = this.calculateSize(mode.fit);
    const distorted = this.isDistorted(calc);

    Scroll() {
      Column() {
        Column() {
          Text('Image Resize Techniques')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')

          Text('Maintain aspect ratio, crop, fit one axis, or deliberately distort.')
            .fontSize(14)
            .fontColor('#64748B')
            .margin({ top: 6 })

          Text('Source image: inline SVG · 800 × 500 · 8:5')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 4 })
        }
          .width('100%')
          .alignItems(ItemAlign.Start)
          .padding({ top: 18, bottom: 12 })

        this.SectionTitle('Live objectFit preview', 'Image.objectFit() plus anchor direction.')

        Column() {
          Row() {
            Column() {
              Text('Live objectFit preview')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F172A')

              Text(mode.desc)
                .fontSize(12)
                .fontColor('#64748B')
                .margin({ top: 4 })
            }
              .alignItems(ItemAlign.Start)

            Text(mode.name)
              .fontSize(12)
              .fontColor('#2563EB')
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .backgroundColor('#EFF6FF')
              .borderRadius(999)
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(ItemAlign.Start)

          Stack() {
            Image(this.imageSrc)
              .width('100%')
              .height('100%')
              .objectFit(mode.fit)
              .objectPosition(align.position)

            Column() {
              Text(mode.name)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')

              Text(align.label)
                .fontSize(11)
                .fontColor('#E2E8F0')
                .margin({ top: 3 })
            }
              .padding({ left: 10, right: 10, top: 8, bottom: 8 })
              .backgroundColor('#0F172A')
              .opacity(0.78)
              .borderRadius(14)
              .position({ x: 12, y: 12 })
          }
            .width(this.targetWidth)
            .height(this.targetHeight)
            .backgroundColor('#E2E8F0')
            .borderRadius(18)
            .borderWidth(1)
            .borderColor('#CBD5E1')
            .clip(true)

          Text(`Target frame: ${this.targetWidth} × ${this.targetHeight}`)
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 8 })
        }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .borderWidth(1)
          .borderColor('#E2E8F0')

        this.SectionTitle('Resize direction controls', 'Change target size, resize mode, and crop/overflow anchor.')

        Column() {
          Text('Target size')
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor('#334155')

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.sizePresets, (preset: SizePreset) => {
              const active = this.targetWidth === preset.width && this.targetHeight === preset.height;
              Button(preset.label)
                .height(34)
                .fontSize(12)
                .fontColor(active ? '#FFFFFF' : '#0F172A')
                .backgroundColor(active ? '#2563EB' : '#E2E8F0')
                .borderRadius(12)
                .onClick(() => {
                  this.targetWidth = preset.width;
                  this.targetHeight = preset.height;
                })
            }, (preset: SizePreset) => preset.label)
          }
            .width('100%')
            .gap(8)
            .margin({ top: 8 })

          Divider()
            .margin({ top: 12, bottom: 12 })

          Text('Resize mode')
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor('#334155')

          Text('Contain/Cover/Fit keep ratio; Fill distorts; None uses natural size.')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 4 })

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.modes, (item: ModeItem, index: number) => {
              this.ModeButton(item, index)
            }, (item: ModeItem) => item.name)
          }
            .width('100%')
            .gap(8)
            .margin({ top: 8 })

          Divider()
            .margin({ top: 12, bottom: 12 })

          Text('Anchor direction')
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor('#334155')

          Text('Start/Center/End and Top/Center/Bottom choose the visible area when cropping or overflow occurs.')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 4 })

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.alignments, (item: AlignItem, index: number) => {
              const active = index === this.alignIndex;
              Button(item.short)
                .width(38)
                .height(34)
                .fontSize(14)
                .fontColor(active ? '#FFFFFF' : '#334155')
                .backgroundColor(active ? '#2563EB' : '#E2E8F0')
                .borderRadius(10)
                .onClick(() => {
                  this.alignIndex = index;
                })
            }, (item: AlignItem) => item.label)
          }
            .width('100%')
            .gap(8)
            .margin({ top: 8 })
        }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .borderWidth(1)
          .borderColor('#E2E8F0')

        this.SectionTitle('Calculated result', 'What the selected mode does mathematically.')

        Column() {
          Row() {
            Text('Calculated result')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')

            Text(mode.name)
              .fontSize(12)
              .fontColor('#2563EB')
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .backgroundColor('#EFF6FF')
              .borderRadius(999)
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(ItemAlign.Center)

          Text(mode.desc)
            .fontSize(13)
            .fontColor('#475569')
            .margin({ top: 8 })

          Divider()
            .margin({ top: 12, bottom: 12 })

          Row() {
            Text('Source image')
              .fontSize(13)
              .fontColor('#64748B')

            Text(`${this.sourceWidth} × ${this.sourceHeight} (8:5)`)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 6 })

          Row() {
            Text('Target frame')
              .fontSize(13)
              .fontColor('#64748B')

            Text(`${this.targetWidth} × ${this.targetHeight}`)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 6 })

          Row() {
            Text('Rendered image')
              .fontSize(13)
              .fontColor('#64748B')

            Text(`${this.formatNumber(calc.width)} × ${this.formatNumber(calc.height)}`)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 6 })

          Row() {
            Text('Scale')
              .fontSize(13)
              .fontColor('#64748B')

            Text(`${calc.scaleX.toFixed(2)} × ${calc.scaleY.toFixed(2)}${distorted ? ' · distorted' : ''}`)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(distorted ? '#DC2626' : '#0F172A')
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 6 })

          Text(calc.note)
            .fontSize(12)
            .fontColor('#475569')
            .padding(10)
            .backgroundColor('#F1F5F9')
            .borderRadius(12)
            .width('100%')
            .margin({ top: 8 })

          Text('Width-only and height-only modes keep the aspect ratio. Fill changes horizontal and vertical scale independently.')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 8 })
        }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .borderWidth(1)
          .borderColor('#E2E8F0')

        this.SectionTitle('Technique gallery', 'Same sample image, different resize techniques and directions.')

        Column() {
          Row() {
            Text('Technique gallery')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')

            Text(align.label)
              .fontSize(12)
              .fontColor('#2563EB')
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .backgroundColor('#EFF6FF')
              .borderRadius(999)
          }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(ItemAlign.Center)

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.modes, (item: ModeItem) => {
              this.ModeTile(item, align)
            }, (item: ModeItem) => item.name)
          }
            .width('100%')
            .gap(12)
            .justifyContent(FlexAlign.Start)

          Text('Each tile uses a small 128 × 88 frame and the selected anchor direction.')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 10 })
        }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .borderWidth(1)
          .borderColor('#E2E8F0')
      }
        .width('100%')
        .padding({ left: 16, right: 16, top: 0, bottom: 24 })
    }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')
  }
}