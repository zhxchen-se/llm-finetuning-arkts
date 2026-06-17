import http from '@ohos.net.http';
import image from '@ohos.multimedia.image';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct Index {
  @State pixelMap: image.PixelMap | undefined = undefined;
  @State loading: boolean = false;
  @State errorMsg: string = '';

  // Image URL to fetch
  private imageUrl: string = 'https://picsum.photos/400'; // Random image 400x400

  async loadImage() {
    this.loading = true;
    this.errorMsg = '';
    this.pixelMap = undefined;

    try {
      // 1. Create HTTP request
      const httpRequest = http.createHttp();

      // 2. Request the image as ArrayBuffer
      const response = await httpRequest.request(this.imageUrl, {
        method: http.RequestMethod.GET,
        expectDataType: http.HttpDataType.ARRAY_BUFFER, // Important: get binary data
        connectTimeout: 60000,
        readTimeout: 60000
      });

      if (response.responseCode !== 200) {
        throw new Error(`HTTP error: ${response.responseCode}`);
      }

      // response.result is ArrayBuffer
      const buffer: ArrayBuffer = response.result as ArrayBuffer;

      // 3. Create ImageSource from buffer
      const imageSource: image.ImageSource = image.createImageSource(buffer);

      // 4. Create PixelMap with default decoding options
      const decodingOptions: image.DecodingOptions = {
        editable: false,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888
      };
      const pixelMap: image.PixelMap = await imageSource.createPixelMap(decodingOptions);

      // 5. Update state
      this.pixelMap = pixelMap;

      // Release imageSource (optional, but good practice)
      imageSource.release();

      // Destroy HTTP request
      httpRequest.destroy();

    } catch (err) {
      const error = err as BusinessError;
      this.errorMsg = `Failed to load image: ${error.message}`;
      console.error('Image load error:', JSON.stringify(error));
    } finally {
      this.loading = false;
    }
  }

  build() {
    Column() {
      // Title
      Text('Network Image Loader')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      // Button to trigger load
      Button('Load Image')
        .fontSize(18)
        .onClick(() => {
          this.loadImage();
        })
        .margin({ bottom: 20 })

      // Loading indicator
      if (this.loading) {
        LoadingProgress()
          .width(50)
          .height(50)
          .margin({ bottom: 20 })
      }

      // Error message
      if (this.errorMsg) {
        Text(this.errorMsg)
          .fontSize(16)
          .fontColor(Color.Red)
          .margin({ bottom: 20 })
      }

      // Image display
      if (this.pixelMap) {
        Image(this.pixelMap)
          .width('100%')
          .height(400)
          .objectFit(ImageFit.Contain)
          .margin({ top: 10 })
      } else if (!this.loading && !this.errorMsg) {
        Text('No image loaded. Press the button.')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Start)
  }
}