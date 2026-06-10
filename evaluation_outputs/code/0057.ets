import { Image } from '@kit.ArkUI';

// Custom component that loads an online image with a configurable timeout.
// Displays a placeholder (via the alt property) while loading.
@Component
struct TimeoutImage {
  @Prop src: string;                     // Remote image URL
  @Prop placeholder: ResourceStr;        // Placeholder image resource or string
  @Prop timeout: number = 5000;          // Timeout in milliseconds
  @State imageSrc: ResourceStr = '';     // Current source for the Image component
  private timerId: number = -1;
  private timedOut: boolean = false;

  aboutToAppear(): void {
    // Start by showing the placeholder, then initiate loading with timeout.
    this.imageSrc = this.placeholder;
    this.startLoading();
  }

  // Begins the loading process with a timeout.
  private startLoading(): void {
    // Clear any previous timer
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
    this.timedOut = false;

    // Set a timer that will switch to the placeholder permanently if it fires.
    this.timerId = setTimeout(() => {
      this.timedOut = true;
      this.imageSrc = this.placeholder; // Show placeholder permanently
    }, this.timeout);

    // Start loading the actual remote image.
    // The Image component will show the alt placeholder while loading.
    this.imageSrc = this.src;
  }

  // Called when the remote image loads successfully.
  private onImageComplete(): void {
    if (!this.timedOut) {
      clearTimeout(this.timerId);
      this.timerId = -1;
      // imageSrc is already the remote URL, so the loaded image stays.
    }
  }

  // Called when the remote image fails to load.
  private onImageError(): void {
    if (!this.timedOut) {
      clearTimeout(this.timerId);
      this.timerId = -1;
      this.imageSrc = this.placeholder; // Show placeholder on error
    }
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Image(this.imageSrc)
      .alt(this.placeholder)            // Placeholder shown during loading
      .width('100%')
      .height(200)
      .objectFit(ImageFit.Cover)
      .onComplete(() => {
        this.onImageComplete();
      })
      .onError(() => {
        this.onImageError();
      })
  }
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Timeout Image Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // Example 1: Normal loading with a generous timeout (likely succeeds)
      TimeoutImage({
        src: 'https://picsum.photos/400/300',
        placeholder: $r('app.media.placeholder'),   // Ensure you have a placeholder image in resources
        timeout: 5000
      })
        .margin({ bottom: 15 })

      // Example 2: Short timeout to demonstrate timeout behavior
      TimeoutImage({
        src: 'https://picsum.photos/400/300?random=1',
        placeholder: $r('app.media.placeholder'),
        timeout: 1000   // 1 second – likely triggers timeout on slow networks
      })
        .margin({ bottom: 15 })

      // Example 3: Invalid URL to show error handling
      TimeoutImage({
        src: 'https://invalid.url/image.jpg',
        placeholder: $r('app.media.placeholder'),
        timeout: 5000
      })
        .margin({ bottom: 15 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}