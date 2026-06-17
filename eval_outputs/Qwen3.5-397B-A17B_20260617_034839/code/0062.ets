import { ImageFilterType, ImageFit, HorizontalAlign, FontWeight, Color } from '@ohos.base';

@Entry
@Component
struct Index {
  @State currentFilter: string = 'none';
  @State intensity: number = 50;
  private imageUrl: string = 'https://placehold.co/600x400/png';

  getFilterArray(): Array<{ type: ImageFilterType, value: number }> {
    let filters: Array<{ type: ImageFilterType, value: number }> = [];
    let value = 0;

    switch (this.currentFilter) {
      case 'grayscale':
        value = this.intensity / 100;
        filters.push({ type: ImageFilterType.Grayscale, value: value });
        break;
      case 'sepia':
        value = this.intensity / 100;
        filters.push({ type: ImageFilterType.Sepia, value: value });
        break;
      case 'blur':
        value = this.intensity / 10;
        filters.push({ type: ImageFilterType.Blur, value: value });
        break;
      case 'brightness':
        value = this.intensity / 50;
        filters.push({ type: ImageFilterType.Brightness, value: value });
        break;
      case 'contrast':
        value = this.intensity / 50;
        filters.push({ type: ImageFilterType.Contrast, value: value });
        break;
      case 'saturate':
        value = this.intensity / 50;
        filters.push({ type: ImageFilterType.Saturate, value: value });
        break;
      case 'hueRotate':
        value = this.intensity * 3.6;
        filters.push({ type: ImageFilterType.HueRotate, value: value });
        break;
      case 'none':
      default:
        break;
    }
    return filters;
  }

  build() {
    Column() {
      Text('Image Filter Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      Image(this.imageUrl)
        .width('80%')
        .height(300)
        .objectFit(ImageFit.Cover)
        .borderRadius(10)
        .filter(this.getFilterArray())
        .margin({ bottom: 20 })

      Text(`Intensity: ${this.intensity}`)
        .fontSize(16)
        .margin({ bottom: 10 })

      Slider({ value: this.intensity, min: 0, max: 100 })
        .width('80%')
        .onChange((value: number) => {
          this.intensity = value;
        })
        .margin({ bottom: 20 })

      Text('Select Filter')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Row() {
        Button('None')
          .onClick(() => { this.currentFilter = 'none'; })
          .backgroundColor(this.currentFilter === 'none' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
        Button('Gray')
          .onClick(() => { this.currentFilter = 'grayscale'; })
          .backgroundColor(this.currentFilter === 'grayscale' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
        Button('Sepia')
          .onClick(() => { this.currentFilter = 'sepia'; })
          .backgroundColor(this.currentFilter === 'sepia' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 10 })

      Row() {
        Button('Blur')
          .onClick(() => { this.currentFilter = 'blur'; })
          .backgroundColor(this.currentFilter === 'blur' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
        Button('Bright')
          .onClick(() => { this.currentFilter = 'brightness'; })
          .backgroundColor(this.currentFilter === 'brightness' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
        Button('Contrast')
          .onClick(() => { this.currentFilter = 'contrast'; })
          .backgroundColor(this.currentFilter === 'contrast' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 10 })

      Row() {
        Button('Saturate')
          .onClick(() => { this.currentFilter = 'saturate'; })
          .backgroundColor(this.currentFilter === 'saturate' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
        Button('Hue')
          .onClick(() => { this.currentFilter = 'hueRotate'; })
          .backgroundColor(this.currentFilter === 'hueRotate' ? Color.Blue : Color.LightGray)
          .margin({ right: 5 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}