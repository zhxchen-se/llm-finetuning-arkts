import {
  AlignItems,
  Button,
  Column,
  FlexAlign,
  FontWeight,
  Image,
  ImageFit,
  Row,
  Scroll,
  Text,
  TextAlign
} from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { fileIo } from '@kit.ArkIO';
import { image } from '@kit.ArkGraphics2D';

@Entry
@Component
struct Index {
  private readonly networkUrl: string = 'https://picsum.photos/seed/harmonyos-image-types/420/260';
  private readonly inlinePngBase64: string = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAADElEQVR42mP8z8AARQAFAAHzA5wAAAAASUVORK5CYII=';

  @State refreshKey: number = 0;

  @State networkStatus: string = 'Loading network image…';
  @State networkError: boolean = false;

  @State pixelMap: image.PixelMap | null = null;
  @State pixelMapStatus: string = 'Waiting for local file path…';

  @State inlinePixelMap: image.PixelMap | null = null;
  @State base64Status: string = 'Decoding inline PNG base64…';

  @State localFilePath: string = '';
  @State filePathStatus: string = 'Writing inline PNG to cache…';
  @State localFileError: boolean = false;

  aboutToAppear(): void {
    this.reloadAsyncSources();
  }

  build() {
    Column() {
      this.Header()

      Scroll() {
        Column() {
          this.ResourceCard()
          this.NetworkCard()
          this.PixelMapCard()
          this.Base64Card()
          this.FilePathCard()
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F6F8FB')
  }

  @Builder
  Header(): void {
    Column() {
      Text('Image Loading Types')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#101828')

      Text('Resource • URL • PixelMap • Base64 • File path')
        .fontSize(13)
        .fontColor('#667085')
        .margin({ top: 6 })

      Button('Reload async sources')
        .width('80%')
        .height(44)
        .backgroundColor('#2563EB')
        .fontColor('#FFFFFF')
        .borderRadius(12)
        .margin({ top: 14 })
        .onClick(() => {
          this.reloadAsyncSources();
        })
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  @Builder
  Card(title: string, badge: string, description: string): void {
    Column() {
      Row() {
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#101828')
          .layoutWeight(1)

        Text(badge)
          .fontSize(12)
          .fontColor('#175CD3')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#EFF8FF')
          .borderRadius(999)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(AlignItems.Center)

      Text(description)
        .fontSize(13)
        .fontColor('#667085')
        .margin({ top: 6 })
    }
    .width('100%')
  }

  @Builder
  StatusBox(status: string): void {
    Text(status)
      .width(220)
      .height(140)
      .padding(14)
      .fontSize(14)
      .fontColor('#667085')
      .textAlign(TextAlign.Center)
      .backgroundColor('#F2F4F7')
      .borderRadius(16)
  }

  @Builder
  ImageOrStatus(pixelMap: image.PixelMap | null, status: string): void {
    if (pixelMap != null) {
      Image(pixelMap)
        .width('100%')
        .height(180)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
        .backgroundColor('#EAECF0')
    } else {
      this.StatusBox(status)
    }
  }

  @Builder
  NetworkFrame(): void {
    if (this.networkError) {
      this.StatusBox(this.networkStatus)
    } else {
      Image({ src: `${this.networkUrl}?reload=${this.refreshKey}` })
        .width('100%')
        .height(180)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
        .backgroundColor('#EAECF0')
        .onLoadComplete(() => {
          this.networkError = false;
          this.networkStatus = 'Network image loaded.';
        })
        .onError(() => {
          this.networkError = true;
          this.networkStatus = 'Network image failed. Check URL and ohos.permission.INTERNET.';
        })
    }
  }

  @Builder
  LocalFileFrame(): void {
    if (this.localFileError) {
      this.StatusBox(this.filePathStatus)
    } else if (this.localFilePath.length > 0) {
      Image({ src: this.localFilePath })
        .width('100%')
        .height(180)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
        .backgroundColor('#EAECF0')
        .onLoadComplete(() => {
          this.localFileError = false;
          this.filePathStatus = 'Local file path loaded.';
        })
        .onError(() => {
          this.localFileError = true;
          this.filePathStatus = 'Local file path failed. Check cache write path.';
        })
    } else {
      this.StatusBox(this.filePathStatus)
    }
  }

  @Builder
  ResourceCard(): void {
    Column() {
      this.Card(
        'Bundled resource',
        'Resource',
        'Directly use $r(...) for assets packaged with the app.'
      )

      Row() {
        Image($r('app.media.icon'))
          .width(120)
          .height(120)
          .objectFit(ImageFit.Contain)
          .borderRadius(18)
          .backgroundColor('#FFFFFF')

        Column() {
          Text('Handling')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#101828')

          Text('No async decode is needed; the resource manager resolves it.')
            .fontSize(13)
            .fontColor('#667085')
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        .margin({ left: 16 })
      }
      .width('100%')
      .alignItems(AlignItems.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#EAECF0' })
    .shadow({ radius: 10, color: 'rgba(16, 24, 40, 0.06)', offsetX: 0, offsetY: 4 })
    .margin({ bottom: 12 })
  }

  @Builder
  NetworkCard(): void {
    Column() {
      this.Card(
        'Network image',
        'URL',
        'Use Image with callbacks; add ohos.permission.INTERNET in module.json5.'
      )

      this.NetworkFrame()

      Text(this.networkStatus)
        .fontSize(13)
        .fontColor(this.networkError ? '#B42318' : '#475467')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#EAECF0' })
    .shadow({ radius: 10, color: 'rgba(16, 24, 40, 0.06)', offsetX: 0, offsetY: 4 })
    .margin({ bottom: 12 })
  }

  @Builder
  PixelMapCard(): void {
    Column() {
      this.Card(
        'PixelMap image',
        'PixelMap',
        'Decode first when you need to process or transform bitmap data.'
      )

      this.ImageOrStatus(this.pixelMap, this.pixelMapStatus)

      Text(this.pixelMapStatus)
        .fontSize(13)
        .fontColor('#475467')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#EAECF0' })
    .shadow({ radius: 10, color: 'rgba(16, 24, 40, 0.06)', offsetX: 0, offsetY: 4 })
    .margin({ bottom: 12 })
  }

  @Builder
  Base64Card(): void {
    Column() {
      this.Card(
        'Base64 image',
        'Base64',
        'Convert base64 text to bytes, then decode to a PixelMap.'
      )

      this.ImageOrStatus(this.inlinePixelMap, this.base64Status)

      Text(this.base64Status)
        .fontSize(13)
        .fontColor('#475467')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#EAECF0' })
    .shadow({ radius: 10, color: 'rgba(16, 24, 40, 0.06)', offsetX: 0, offsetY: 4 })
    .margin({ bottom: 12 })
  }

  @Builder
  FilePathCard(): void {
    Column() {
      this.Card(
        'Local file path',
        'File path',
        'Write bytes to cache, then display the file through a file URI.'
      )

      this.LocalFileFrame()

      Text(this.filePathStatus)
        .fontSize(13)
        .fontColor(this.localFileError ? '#B42318' : '#475467')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#EAECF0' })
    .shadow({ radius: 10, color: 'rgba(16, 24, 40, 0.06)', offsetX: 0, offsetY: 4 })
    .margin({ bottom: 12 })
  }

  private reloadAsyncSources(): void {
    this.refreshKey += 1;

    this.networkStatus = 'Loading network image…';
    this.networkError = false;

    this.pixelMap = null;
    this.pixelMapStatus = 'Waiting for local file path…';

    this.inlinePixelMap = null;
    this.base64Status = 'Decoding inline PNG base64…';

    this.localFilePath = '';
    this.filePathStatus = 'Writing inline PNG to cache…';
    this.localFileError = false;

    this.loadInlineBase64PixelMap();
    this.writeInlinePngToFile();
  }

  private async loadInlineBase64PixelMap(): Promise<void> {
    try {
      this.inlinePixelMap = await this.decodeBase64PixelMap(this.inlinePngBase64);
      this.base64Status = 'Base64 decoded to PixelMap.';
    } catch (error) {
      this.inlinePixelMap = null;
      this.base64Status = `Base64 decode failed: ${this.errorMessage(error)}`;
    }
  }

  private async writeInlinePngToFile(): Promise<void> {
    let fd: number = -1;

    try {
      const context = getContext(this) as common.UIAbilityContext;
      const baseDir: string = context.cacheDir || context.filesDir;

      if (!baseDir) {
        throw new Error('No writable app directory found');
      }

      const filePath: string = `${baseDir}/inline-sample.png`;
      const bytes: Uint8Array = this.base64ToBytes(this.inlinePngBase64);
      const arrayBuffer: ArrayBuffer = bytes.buffer as ArrayBuffer;
      const flags: number = fileIo.OpenMode.CREATE | fileIo.OpenMode.WRITE_ONLY | fileIo.OpenMode.TRUNC;

      fd = await fileIo.open(filePath, flags);
      await fileIo.write(fd, arrayBuffer);

      this.localFilePath = `file://${filePath}`;
      this.localFileError = false;
      this.filePathStatus = 'Local file path ready.';

      await this.loadPixelMapFromFile(filePath);
    } catch (error) {
      this.localFilePath = '';
      this.localFileError = true;
      this.filePathStatus = `Local file write failed: ${this.errorMessage(error)}`;
      await this.loadPixelMapFallback('Local file write failed');
    } finally {
      if (fd >= 0) {
        try {
          await fileIo.close(fd);
        } catch (_) {
          // Ignore close failure after the write has completed or failed.
        }
      }
    }
  }

  private async loadPixelMapFromFile(filePath: string): Promise<void> {
    try {
      this.pixelMapStatus = 'Decoding local file path to PixelMap…';
      const decoder = await image.createImageDecoder(filePath);
      this.pixelMap = await decoder.decode();
      this.pixelMapStatus = 'File path decoded to PixelMap.';
    } catch (error) {
      await this.loadPixelMapFallback(`File path decode failed: ${this.errorMessage(error)}`);
    }
  }

  private async loadPixelMapFallback(reason: string): Promise<void> {
    try {
      this.pixelMap = await this.decodeBase64PixelMap(this.inlinePngBase64);
      this.pixelMapStatus = `${reason}; used inline PNG fallback.`;
    } catch (error) {
      this.pixelMap = null;
      this.pixelMapStatus = `PixelMap decode failed: ${this.errorMessage(error)}`;
    }
  }

  private async decodeBase64PixelMap(base64: string): Promise<image.PixelMap> {
    const bytes: Uint8Array = this.base64ToBytes(base64);
    const arrayBuffer: ArrayBuffer = bytes.buffer as ArrayBuffer;
    const decoder = await image.createImageDecoder(arrayBuffer);
    return await decoder.decode();
  }

  private base64ToBytes(base64: string): Uint8Array {
    const alphabet: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    let clean: string = base64.replace(/\s/g, '');

    while (clean.length % 4 !== 0) {
      clean += '=';
    }

    const bytes: Uint8Array = new Uint8Array(Math.floor(clean.length * 3 / 4));
    let byteIndex: number = 0;

    for (let i: number = 0; i < clean.length; i += 4) {
      const first: number = alphabet.indexOf(clean[i]);
      const second: number = alphabet.indexOf(clean[i + 1]);
      const third: number = clean[i + 2] === '=' ? 0 : alphabet.indexOf(clean[i + 2]);
      const fourth: number = clean[i + 3] === '=' ? 0 : alphabet.indexOf(clean[i + 3]);

      if (first < 0 || second < 0 || third < 0 || fourth < 0) {
        throw new Error('Invalid base64 data');
      }

      const value: number = (first << 18) | (second << 12) | (third << 6) | fourth;
      bytes[byteIndex++] = (value >> 16) & 0xff;

      if (clean[i + 2] !== '=') {
        bytes[byteIndex++] = (value >> 8) & 0xff;
      }

      if (clean[i + 3] !== '=') {
        bytes[byteIndex++] = value & 0xff;
      }
    }

    return bytes.slice(0, byteIndex);
  }

  private errorMessage(error: unknown): string {
    if (error instanceof Error) {
      return error.message;
    }
    return String(error);
  }
}