import { promptAction } from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State imageUrl: string = 'https://picsum.photos/300/200';
  @State timeoutMs: number = 3000;
  @State isLoading: boolean = false;
  @State isTimeout: boolean = false;
  @State timerId: number = -1;
  @State placeholderUrl: string = 'https://via.placeholder.com/300x200?text=Loading...';
  @State inputTimeout: string = '3000';
  @State inputUrl: string = 'https://picsum.photos/300/200';

  aboutToAppear() {
    // Initialize states if needed
  }

  loadImage() {
    // Reset states
    this.isLoading = true;
    this.isTimeout = false;
    this.imageUrl = this.inputUrl;
    
    // Parse timeout
    const timeout = parseInt(this.inputTimeout);
    if (!isNaN(timeout) && timeout > 0) {
      this.timeoutMs = timeout;
    }

    // Clear existing timer if any
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }

    // Start timeout timer
    this.timerId = setTimeout(() => {
      this.handleTimeout();
    }, this.timeoutMs);
  }

  handleTimeout() {
    this.isLoading = false;
    this.isTimeout = true;
    this.timerId = -1;
    promptAction.showToast({
      message: 'Image load timeout',
      duration: 2000
    });
  }

  handleImageComplete() {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
    this.isLoading = false;
    this.isTimeout = false;
  }

  handleImageError() {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
    this.isLoading = false;
    this.isTimeout = true;
    promptAction.showToast({
      message: 'Failed to load image',
      duration: 2000
    });
  }

  build() {
    Column() {
      Text('Image Loader with Timeout')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Row() {
        Text('Timeout (ms):')
          .fontSize(16)
          .margin({ right: 10 })
        TextInput({ text: this.inputTimeout, placeholder: 'Enter timeout' })
          .type(InputType.Number)
          .onChange((value: string) => {
            this.inputTimeout = value;
          })
          .layoutWeight(1)
          .margin({ right: 10 })
      }
      .width('90%')
      .margin({ bottom: 10 })

      Row() {
        Text('Image URL:')
          .fontSize(16)
          .margin({ right: 10 })
        TextInput({ text: this.inputUrl, placeholder: 'Enter image URL' })
          .onChange((value: string) => {
            this.inputUrl = value;
          })
          .layoutWeight(1)
      }
      .width('90%')
      .margin({ bottom: 20 })

      Button('Load Image')
        .onClick(() => {
          this.loadImage();
        })
        .margin({ bottom: 20 })

      Stack() {
        // Main Image Component
        Image(this.imageUrl)
          .width(300)
          .height(200)
          .objectFit(ImageFit.Cover)
          .borderRadius(10)
          .alt(`Image from ${this.imageUrl}`)
          .onComplete(() => {
            this.handleImageComplete();
          })
          .onError(() => {
            this.handleImageError();
          })
          .opacity(this.isTimeout ? 0.5 : 1)

        // Placeholder Image Overlay (Visible during loading)
        if (this.isLoading) {
          Image(this.placeholderUrl)
            .width(300)
            .height(200)
            .objectFit(ImageFit.Cover)
            .borderRadius(10)
            .backgroundColor('#CCCCCC')
        }

        // Timeout/Error Overlay
        if (this.isTimeout && !this.isLoading) {
          Column() {
            Text('Load Failed / Timeout')
              .fontSize(16)
              .fontColor('#FF0000')
              .fontWeight(FontWeight.Bold)
          }
          .width(300)
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('rgba(255, 255, 255, 0.8)')
          .borderRadius(10)
        }
      }
      .width(300)
      .height(200)
      .margin({ top: 20 })

      Text(this.isLoading ? 'Loading...' : (this.isTimeout ? 'Finished (Error/Timeout)' : 'Finished (Success)'))
        .fontSize(14)
        .fontColor(this.isLoading ? '#007DFF' : (this.isTimeout ? '#FF0000' : '#00AA00'))
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
  }
}