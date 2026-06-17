import { imagePixelMap } from '@ohos.image.pixelMap';
import { util } from '@ohos.base';

@Entry
@Component
struct Index {
  @State pixelMap: PixelMap | null = null;
  private localResource: Resource = $r('app.media.icon');
  private networkUrl: string = 'https://picsum.photos/200/200';
  private base64String: string = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8DwHwAFBQIAX8jx0gAAAABJRU5ErkJggg==';

  aboutToAppear() {
    this.loadPixelMapFromBase64();
  }

  async loadPixelMapFromBase64() {
    try {
      // Decode base64 string to ArrayBuffer
      const arrayBuffer = util.base64.decode(this.base64String);
      
      // Create ImageSource from ArrayBuffer
      const imageSource = imagePixelMap.createImageSource(arrayBuffer);
      
      // Read PixelMap from ImageSource
      const pixelMap = await imageSource.createPixelMap();
      
      // Update state to trigger UI refresh
      this.pixelMap = pixelMap;
      
      // Release imageSource resource
      imageSource.release();
    } catch (error) {
      console.error('Failed to load PixelMap:', JSON.stringify(error));
    }
  }

  build() {
    Column() {
      Text('Image Type Demonstrations')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      List() {
        // 1. Local Resource Image
        ListItem() {
          Row() {
            Text('1. Local Resource')
              .width('30%')
              .fontSize(16)
            Image(this.localResource)
              .width(50)
              .height(50)
              .objectFit(ImageFit.Contain)
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        // 2. Network URL Image
        ListItem() {
          Row() {
            Text('2. Network URL')
              .width('30%')
              .fontSize(16)
            Image(this.networkUrl)
              .width(50)
              .height(50)
              .objectFit(ImageFit.Cover)
              .onComplete(() => {
                console.info('Network image loaded successfully');
              })
              .onError(() => {
                console.error('Network image load failed (Check Internet Permission)');
              })
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        // 3. PixelMap Image
        ListItem() {
          Row() {
            Text('3. PixelMap Object')
              .width('30%')
              .fontSize(16)
            if (this.pixelMap) {
              Image(this.pixelMap)
                .width(50)
                .height(50)
                .objectFit(ImageFit.Contain)
            } else {
              Text('Loading...')
                .fontSize(12)
                .fontColor(Color.Gray)
            }
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        // 4. Base64 Data (Handled via PixelMap)
        ListItem() {
          Row() {
            Text('4. Base64 Data')
              .width('30%')
              .fontSize(16)
            Text('Converted to PixelMap')
              .fontSize(12)
              .fontColor(Color.Blue)
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}