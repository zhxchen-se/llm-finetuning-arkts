import { image } from '@kit.ImageKit';

@Entry
@Component
struct Index {
  @State pixelMapImg: PixelMap | undefined = undefined;
  @State base64Img: string = '';
  @State networkLoadState: string = 'Loading...';
  @State base64LoadState: string = 'Loading...';
  @State pixelMapLoadState: string = 'Loading...';
  @State resourceLoadState: string = 'Loaded';
  @State rawfileLoadState: string = 'Loaded';
  @State fileLoadState: string = 'Loading...';
  @State fileImgSrc: string = '';

  aboutToAppear() {
    this.createPixelMap();
    this.createBase64Image();
    this.prepareFilePath();
  }

  async createPixelMap() {
    try {
      const color = new ArrayBuffer(160 * 160 * 4);
      const colorArr = new Uint8Array(color);
      for (let i = 0; i < 160 * 160; i++) {
        const idx = i * 4;
        const x = i % 160;
        const y = Math.floor(i / 160);
        const cx = x - 80;
        const cy = y - 80;
        const dist = Math.sqrt(cx * cx + cy * cy);
        if (dist < 60) {
          colorArr[idx] = 66;
          colorArr[idx + 1] = 133;
          colorArr[idx + 2] = 244;
          colorArr[idx + 3] = 255;
        } else if (dist < 75) {
          colorArr[idx] = 234;
          colorArr[idx + 1] = 67;
          colorArr[idx + 2] = 53;
          colorArr[idx + 3] = 255;
        } else {
          colorArr[idx] = 52;
          colorArr[idx + 1] = 168;
          colorArr[idx + 2] = 83;
          colorArr[idx + 3] = 255;
        }
      }
      const opts: image.PixelMapOptions = {
        size: { width: 160, height: 160 },
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        editable: true
      };
      this.pixelMapImg = await image.createPixelMap(color, opts);
      this.pixelMapLoadState = 'Loaded';
    } catch (e) {
      this.pixelMapLoadState = 'Failed: ' + e;
    }
  }

  async createBase64Image() {
    try {
      const color = new ArrayBuffer(80 * 80 * 4);
      const colorArr = new Uint8Array(color);
      for (let i = 0; i < 80 * 80; i++) {
        const idx = i * 4;
        const x = i % 80;
        const y = Math.floor(i / 80);
        const r = Math.floor(255 * (x / 80));
        const g = Math.floor(255 * (y / 80));
        const b = 200;
        colorArr[idx] = r;
        colorArr[idx + 1] = g;
        colorArr[idx + 2] = b;
        colorArr[idx + 3] = 255;
      }
      const opts: image.PixelMapOptions = {
        size: { width: 80, height: 80 },
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        editable: true
      };
      const pm = await image.createPixelMap(color, opts);
      const packingOpts: image.PackingOption = {
        format: 'image/png',
        quality: 100
      };
      const packer = image.createImagePacker();
      const data = await packer.packing(pm, packingOpts);
      const buf = buffer.fromArrayBuffer(data);
      this.base64Img = 'data:image/png;base64,' + buf.toString('base64');
      this.base64LoadState = 'Loaded';
      packer.release();
      pm.release();
    } catch (e) {
      this.base64LoadState = 'Failed: ' + e;
    }
  }

  async prepareFilePath() {
    try {
      const context = getContext(this);
      const files = context.resourceManager.getRawFileList('');
      if (files.includes('sample.png')) {
        this.fileImgSrc = context.filesDir + '/sample.png';
        this.fileLoadState = 'Loaded (rawfile copy)';
      } else {
        const color = new ArrayBuffer(60 * 60 * 4);
        const colorArr = new Uint8Array(color);
        for (let i = 0; i < 60 * 60; i++) {
          const idx = i * 4;
          colorArr[idx] = 255;
          colorArr[idx + 1] = 193;
          colorArr[idx + 2] = 7;
          colorArr[idx + 3] = 255;
        }
        const opts: image.PixelMapOptions = {
          size: { width: 60, height: 60 },
          pixelFormat: image.PixelMapFormat.RGBA_8888,
          editable: true
        };
        const pm = await image.createPixelMap(color, opts);
        const packingOpts: image.PackingOption = { format: 'image/png', quality: 100 };
        const packer = image.createImagePacker();
        const data = await packer.packing(pm, packingOpts);
        const filePath = context.filesDir + '/generated_file.png';
        const file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
        fs.writeSync(file.fd, data);
        fs.closeSync(file);
        this.fileImgSrc = filePath;
        this.fileLoadState = 'Loaded (generated file)';
        packer.release();
        pm.release();
      }
    } catch (e) {
      this.fileLoadState = 'Failed: ' + e;
    }
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Image Type Gallery')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a73e8')
          .margin({ top: 20, bottom: 8 })

        Text('Demonstrates different image source types in ArkTS')
          .fontSize(14)
          .fontColor('#666666')
          .margin({ bottom: 12 })

        // Type 1: Resource Reference ($r)
        this.ImageTypeCard(
          '1. Resource Reference ($r)',
          'Loads image from app resources using $r("app.media.name") syntax. Best for static assets bundled with the app.',
          this.resourceLoadState,
          () => {
            Image($r('app.media.startIcon'))
              .width(160)
              .height(120)
              .objectFit(ImageFit.Contain)
              .borderRadius(8)
              .backgroundColor('#f5f5f5')
              .alt($r('app.media.startIcon'))
          }
        )

        // Type 2: Rawfile Resource
        this.ImageTypeCard(
          '2. Rawfile Resource ($rawfile)',
          'Loads image from rawfile directory using $rawfile("filename"). Supports PNG, JPG, GIF, SVG, WebP and more.',
          this.rawfileLoadState,
          () => {
            Image($rawfile('app.json'))
              .width(160)
              .height(120)
              .objectFit(ImageFit.Contain)
              .borderRadius(8)
              .backgroundColor('#f5f5f5')
              .alt($r('app.media.startIcon'))
          }
        )

        // Type 3: Network URL (String)
        this.ImageTypeCard(
          '3. Network URL (String)',
          'Loads image from a remote URL. Requires internet permission (ohos.permission.INTERNET). Supports progressive loading.',
          this.networkLoadState,
          () => {
            Image('https://www.example.com/sample.png')
              .width(160)
              .height(120)
              .objectFit(ImageFit.Contain)
              .borderRadius(8)
              .backgroundColor('#f5f5f5')
              .alt($r('app.media.startIcon'))
              .onComplete(() => {
                this.networkLoadState = 'Loaded';
              })
              .onError(() => {
                this.networkLoadState = 'Failed (no internet or invalid URL)';
              })
          }
        )

        // Type 4: PixelMap
        this.ImageTypeCard(
          '4. PixelMap (Programmatic)',
          'Created programmatically using image.createPixelMap(). Useful for dynamically generated images, image processing, and pixel-level manipulation.',
          this.pixelMapLoadState,
          () => {
            if (this.pixelMapImg) {
              Image(this.pixelMapImg)
                .width(160)
                .height(160)
                .objectFit(ImageFit.Fill)
                .borderRadius(8)
            } else {
              Text('Generating...')
                .width(160)
                .height(160)
                .textAlign(TextAlign.Center)
                .fontSize(14)
                .fontColor('#999999')
                .borderRadius(8)
                .backgroundColor('#f5f5f5')
            }
          }
        )

        // Type 5: Base64 String
        this.ImageTypeCard(
          '5. Base64 Data URI (String)',
          'Loads image from a Base64-encoded data URI string. Format: "data:image/<type>;base64,<data>". Useful for small inline images or API responses.',
          this.base64LoadState,
          () => {
            if (this.base64Img) {
              Image(this.base64Img)
                .width(160)
                .height(160)
                .objectFit(ImageFit.Fill)
                .borderRadius(8)
            } else {
              Text('Encoding...')
                .width(160)
                .height(160)
                .textAlign(TextAlign.Center)
                .fontSize(14)
                .fontColor('#999999')
                .borderRadius(8)
                .backgroundColor('#f5f5f5')
            }
          }
        )

        // Type 6: Local File Path (String)
        this.ImageTypeCard(
          '6. Local File Path (String)',
          'Loads image from a local file path (e.g., filesDir or cacheDir). Useful for downloaded or generated images stored on device.',
          this.fileLoadState,
          () => {
            if (this.fileImgSrc) {
              Image('file://' + this.fileImgSrc)
                .width(160)
                .height(120)
                .objectFit(ImageFit.Contain)
                .borderRadius(8)
                .backgroundColor('#f5f5f5')
                .alt($r('app.media.startIcon'))
            } else {
              Text('Preparing file...')
                .width(160)
                .height(120)
                .textAlign(TextAlign.Center)
                .fontSize(14)
                .fontColor('#999999')
                .borderRadius(8)
                .backgroundColor('#f5f5f5')
            }
          }
        )

        // Summary Section
        Column() {
          Text('Image Source Type Summary')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 12 })

          this.SummaryRow('$r("app.media.name")', 'Resource', 'Static bundled assets')
          this.SummaryRow('$rawfile("name")', 'Rawfile', 'Raw files in resources/rawfile')
          this.SummaryRow('https://...', 'Network', 'Remote images (needs INTERNET permission)')
          this.SummaryRow('PixelMap', 'PixelMap', 'Programmatically created/processed images')
          this.SummaryRow('data:image/...;base64,...', 'Base64', 'Inline encoded image data')
          this.SummaryRow('file:///path/to/file', 'File Path', 'Local filesystem images')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#ffffff')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1a000000', offsetY: 2 })

        // Handling Tips
        Column() {
          Text('Best Practices & Tips')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 12 })

          Text('• Always set .alt() for fallback when network/file images fail to load')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• Use .onComplete() and .onError() callbacks to handle load states')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• Use objectFit to control how images fit within their container')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• For PixelMap, remember to call .release() when done to free memory')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• Network images require ohos.permission.INTERNET in module.json5')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• Use image.createImagePacker() to convert PixelMap to Base64 or file')
            .fontSize(13)
            .fontColor('#555555')
            .margin({ bottom: 6 })
          Text('• Supported formats: PNG, JPG, BMP, GIF, WebP, SVG, HEIF, ICO')
            .fontSize(13)
            .fontColor('#555555')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#ffffff')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1a000000', offsetY: 2 })
        .margin({ bottom: 20 })
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f0f2f5')
    .scrollBar(BarState.Auto)
  }

  @Builder
  ImageTypeCard(title: string, description: string, status: string, imageContent: () => void) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 6 })

      Text(description)
        .fontSize(13)
        .fontColor('#666666')
        .margin({ bottom: 12 })

      Row({ space: 16 }) {
        imageContent()

        Column({ space: 8 }) {
          Row() {
            Text('Status: ')
              .fontSize(13)
              .fontColor('#888888')
            Text(status)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(status === 'Loaded' || status.startsWith('Loaded') ? '#34a853' :
                         status === 'Loading...' ? '#fbbc04' : '#ea4335')
          }

          Text('Type: ' + this.getTypeLabel(title))
            .fontSize(12)
            .fontColor('#888888')

          Text('Source: ' + this.getSourceExample(title))
            .fontSize(11)
            .fontColor('#aaaaaa')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1a000000', offsetY: 2 })
  }

  @Builder
  SummaryRow(source: string, type: string, desc: string) {
    Row() {
      Text(source)
        .fontSize(12)
        .fontColor('#1a73e8')
        .fontWeight(FontWeight.Medium)
        .width('35%')
      Text(type)
        .fontSize(12)
        .fontColor('#333333')
        .fontWeight(FontWeight.Medium)
        .width('15%')
      Text(desc)
        .fontSize(12)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 6, bottom: 6 })
    .borderWidth({ bottom: 0.5 })
    .borderColor('#eeeeee')
  }

  getTypeLabel(title: string): string {
    if (title.includes('Resource')) return 'Resource';
    if (title.includes('Rawfile')) return 'Rawfile';
    if (title.includes('Network')) return 'String (URL)';
    if (title.includes('PixelMap')) return 'PixelMap';
    if (title.includes('Base64')) return 'String (Data URI)';
    if (title.includes('File Path')) return 'String (File URI)';
    return 'Unknown';
  }

  getSourceExample(title: string): string {
    if (title.includes('Resource')) return '$r("app.media.startIcon")';
    if (title.includes('Rawfile')) return '$rawfile("image.png")';
    if (title.includes('Network')) return '"https://example.com/img.png"';
    if (title.includes('PixelMap')) return 'image.createPixelMap(buf, opts)';
    if (title.includes('Base64')) return '"data:image/png;base64,..."';
    if (title.includes('File Path')) return '"file:///data/.../image.png"';
    return '';
  }
}

import { fs, buffer } from '@kit.CoreFileKit';