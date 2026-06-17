import { ImageFit } from '@ohos.arkui.constants';

const DEMO_IMAGE_URL = 'https://picsum.photos/seed/harmony-objectfit/240/160';

interface FitItem {
  id: string;
  title: string;
  fit: ImageFit;
  description: string;
}

interface SizeItem {
  id: string;
  title: string;
  width: string;
  height: string;
  note: string;
}

const FITS: FitItem[] = [
  {
    id: 'contain',
    title: 'contain',
    fit: ImageFit.Contain,
    description: 'Scale to fit; preserve ratio; show margins.'
  },
  {
    id: 'cover',
    title: 'cover',
    fit: ImageFit.Cover,
    description: 'Fill the box; preserve ratio; crop overflow.'
  },
  {
    id: 'fill',
    title: 'fill',
    fit: ImageFit.Fill,
    description: 'Stretch to exactly fill the box.'
  },
  {
    id: 'none',
    title: 'none',
    fit: ImageFit.None,
    description: 'Draw at original size; center and clip if needed.'
  },
  {
    id: 'scaleDown',
    title: 'scaleDown',
    fit: ImageFit.ScaleDown,
    description: 'Scale down only; never upscale.'
  }
];

const SIZES: SizeItem[] = [
  {
    id: 'small',
    title: 'Small container: 120 × 80 vp',
    width: '120vp',
    height: '80vp',
    note: 'The source image is 240×160, so this container downscales most modes.'
  },
  {
    id: 'square',
    title: 'Square container: 200 × 200 vp',
    width: '200vp',
    height: '200vp',
    note: 'A square box makes cover, contain, fill and none easy to compare.'
  },
  {
    id: 'wide',
    title: 'Wide container: 260 × 180 vp',
    width: '260vp',
    height: '180vp',
    note: 'Close to the source ratio; scaleDown keeps the image at 240×160 here.'
  }
];

@Component
struct FitCard {
  title: string = '';
  fit: ImageFit = ImageFit.Contain;
  description: string = '';
  width: string = '200vp';
  height: string = '120vp';
  containerLabel: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize(13)
        .fontWeight(500)
        .fontColor('#111827')
        .margin({ bottom: 6 })

      Image(DEMO_IMAGE_URL)
        .width(this.width)
        .height(this.height)
        .objectFit(this.fit)
        .objectPosition({ x: 50, y: 50 })
        .backgroundColor('#FFFFFF')
        .borderRadius(14)
        .clip(true)
        .border({ width: 1, color: '#E5E7EB' })

      Text(this.description)
        .fontSize(11)
        .fontColor('#4B5563')
        .margin({ top: 6, bottom: 2 })

      Text(this.containerLabel)
        .fontSize(10)
        .fontColor('#9CA3AF')
    }
    .width(this.width)
    .padding(8)
    .backgroundColor('#F9FAFB')
    .borderRadius(16)
    .border({ width: 1, color: '#E5E7EB' })
    .margin({ bottom: 8 })
  }
}

@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Text('Image objectFit Demo')
          .fontSize(24)
          .fontWeight(700)
          .fontColor('#0F172A')

        Text('Same 240×160 photo, different ImageFit values and container sizes')
          .width('100%')
          .fontSize(13)
          .fontColor('#475569')
          .margin({ top: 4, bottom: 4 })

        Text('White space shows letterboxing; cropped edges show cover; stretched edges show fill.')
          .width('100%')
          .fontSize(12)
          .fontColor('#64748B')
          .margin({ bottom: 16 })

        ForEach(SIZES, (size: SizeItem) => {
          Column() {
            Text(size.title)
              .width('100%')
              .fontSize(16)
              .fontWeight(700)
              .fontColor('#0F172A')

            Text(size.note)
              .width('100%')
              .fontSize(12)
              .fontColor('#64748B')
              .margin({ top: 2, bottom: 8 })

            ForEach(FITS, (fit: FitItem) => {
              FitCard({
                title: fit.title,
                fit: fit.fit,
                description: fit.description,
                width: size.width,
                height: size.height,
                containerLabel: `${size.width} × ${size.height}`
              })
            }, (fit: FitItem) => `${size.id}-${fit.id}`)
          }
          .width('100%')
          .margin({ top: 16, bottom: 4 })
        }, (size: SizeItem) => size.id)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 18, bottom: 32 })
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
  }
}