import { image } from '@kit.ImageKit';
import { resourceManager } from '@kit.LocalizationKit';

@Entry
@Component
struct Index {
  @State networkImageLoading: boolean = true;
  @State networkImageError: boolean = false;

  // A minimal 1x1 red pixel PNG in base64
  private base64RedPixel: string = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==';

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Image Types Demo')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })

        // 1. Local resource image using $r
        this.ImageTypeItem('Local Resource ($r)', () => {
          Image($r('app.media.startIcon'))
            .width(100)
            .height(100)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.startIcon')) // fallback if resource missing
        })

        // 2. Rawfile image using $rawfile
        this.ImageTypeItem('Rawfile ($rawfile)', () => {
          Image($rawfile('icon.png'))
            .width(100)
            .height(100)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.startIcon'))
        })

        // 3. Network image with loading and error handling
        this.ImageTypeItem('Network Image', () => {
          Column() {
            if (this.networkImageLoading && !this.networkImageError) {
              LoadingProgress()
                .width(100)
                .height(100)
            }
            Image('https://www.example.com/nonexistent.jpg')
              .width(100)
              .height(100)
              .objectFit(ImageFit.Contain)
              .alt($r('app.media.startIcon'))
              .visibility(this.networkImageLoading ? Visibility.Hidden : Visibility.Visible)
              .onComplete(() => {
                this.networkImageLoading = false;
                this.networkImageError = false;
              })
              .onError(() => {
                this.networkImageLoading = false;
                this.networkImageError = true;
              })
          }
        })

        // 4. Base64 encoded image
        this.ImageTypeItem('Base64 Image', () => {
          Image(this.base64RedPixel)
            .width(100)
            .height(100)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.startIcon'))
        })

        // 5. PixelMap image created programmatically
        this.ImageTypeItem('PixelMap', () => {
          Image(this.createBluePixelMap())
            .width(100)
            .height(100)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.startIcon'))
        })

        // 6. File path image (conceptual, requires actual file)
        this.ImageTypeItem('File Path (file://)', () => {
          Image('file://data/storage/el2/base/haps/entry/files/test.jpg')
            .width(100)
            .height(100)
            .objectFit(ImageFit.Contain)
            .alt($r('app.media.startIcon'))
            .onError(() => console.error('File image load error'))
        })
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ImageTypeItem(label: string, imageBuilder: () => void) {
    Column() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 8 })
      imageBuilder()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .border({ width: 1, color: '#ccc', radius: 8 })
  }

  /**
   * Creates a simple 2x2 blue PixelMap synchronously.
   */
  private createBluePixelMap(): image.PixelMap {
    const width = 2;
    const height = 2;
    const bufferSize = width * height * 4; // RGBA_8888
    const colorBuffer = new ArrayBuffer(bufferSize);
    const view = new Uint8Array(colorBuffer);
    // Fill with opaque blue (R=0, G=0, B=255, A=255)
    for (let i = 0; i < bufferSize; i += 4) {
      view[i] = 0;     // R
      view[i + 1] = 0;   // G
      view[i + 2] = 255; // B
      view[i + 3] = 255; // A
    }
    const opts: image.InitializationOptions = {
      editable: true,
      pixelFormat: image.PixelMapFormat.RGBA_8888,
      size: { width: width, height: height },
      alphaType: image.AlphaType.OPAQUE
    };
    return image.createPixelMapSync(colorBuffer, opts);
  }
}