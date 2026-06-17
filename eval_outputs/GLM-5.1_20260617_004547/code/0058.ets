import http from '@ohos.net.http';
import image from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  @State pixelMap: PixelMap | undefined = undefined;
  @State isLoading: boolean = false;
  @State errorMessage: string = '';

  async fetchImage() {
    if (this.isLoading) {
      return;
    }
    this.isLoading = true;
    this.errorMessage = '';

    let httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(
        'https://picsum.photos/200/300',
        {
          method: http.RequestMethod.GET,
          expectDataType: http.DataType.ARRAY_BUFFER
        }
      );

      if (response.responseCode === 200) {
        const imageData = response.result as ArrayBuffer;
        const imageSource = image.createImageSource(imageData);
        this.pixelMap = await imageSource.createPixelMap();
      } else {
        this.errorMessage = `Request failed with code: ${response.responseCode}`;
      }
    } catch (error) {
      this.errorMessage = `Error: ${JSON.stringify(error)}`;
    } finally {
      httpRequest.destroy();
      this.isLoading = false;
    }
  }

  build() {
    Column({ space: 20 }) {
      if (this.pixelMap) {
        Image(this.pixelMap)
          .width(200)
          .height(300)
          .objectFit(ImageFit.Cover)
          .borderRadius(12)
      } else {
        Column() {
          if (this.isLoading) {
            LoadingProgress()
              .width(40)
              .height(40)
              .color(Color.Blue)
          } else {
            Text('No Image')
              .fontSize(16)
              .fontColor(Color.Gray)
          }
        }
        .width(200)
        .height(300)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')
        .justifyContent(FlexAlign.Center)
      }

      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor(Color.Red)
          .maxLines(2)
          .textAlign(TextAlign.Center)
          .width('80%')
      }

      Button(this.isLoading ? 'Loading...' : 'Fetch Image via HTTP')
        .width('80%')
        .height(50)
        .fontSize(18)
        .enabled(!this.isLoading)
        .onClick(() => {
          this.fetchImage();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}