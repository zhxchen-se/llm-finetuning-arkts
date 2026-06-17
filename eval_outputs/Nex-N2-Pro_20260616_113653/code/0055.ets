import fontManager from '@ohos.fontManager';

// Add these files to entry/src/main/resources/base/font:
// DemoSans-Regular.ttf, DemoSans-Medium.ttf, DemoSans-Bold.ttf,
// DemoSans-Italic.ttf, DemoSans-BoldItalic.ttf
const CUSTOM_FONT_FAMILY: string = 'DemoSans';
const FALLBACK_FONT_FAMILY: string = 'sans-serif';
const FONT_PATH_PREFIX: string = 'resources/base/font/';

interface FontFaceDefinition {
  fileName: string;
  weight: FontWeight;
  style: FontStyle;
  title: string;
  description: string;
}

interface DemoFontFace {
  fontFamily: string;
  src: string;
  weight: FontWeight;
  style: FontStyle;
}

const FONT_FACE_DEFINITIONS: FontFaceDefinition[] = [
  {
    fileName: 'DemoSans-Regular.ttf',
    weight: FontWeight.Regular,
    style: FontStyle.Normal,
    title: 'Regular',
    description: 'Regular weight with normal font style.'
  },
  {
    fileName: 'DemoSans-Medium.ttf',
    weight: FontWeight.Medium,
    style: FontStyle.Normal,
    title: 'Medium',
    description: 'Medium weight with normal font style.'
  },
  {
    fileName: 'DemoSans-Bold.ttf',
    weight: FontWeight.Bold,
    style: FontStyle.Normal,
    title: 'Bold',
    description: 'Bold weight with normal font style.'
  },
  {
    fileName: 'DemoSans-Italic.ttf',
    weight: FontWeight.Regular,
    style: FontStyle.Italic,
    title: 'Italic',
    description: 'Regular weight with italic font style.'
  },
  {
    fileName: 'DemoSans-BoldItalic.ttf',
    weight: FontWeight.Bold,
    style: FontStyle.Italic,
    title: 'Bold Italic',
    description: 'Bold weight with italic font style.'
  }
];

const EXPECTED_FONT_FILES: string = FONT_FACE_DEFINITIONS
  .map((item: FontFaceDefinition) => item.fileName)
  .join('\n');

@Entry
@Component
struct Index {
  @State activeFontFamily: string = FALLBACK_FONT_FAMILY;
  @State statusText: string = 'Registering custom font faces...';
  @State registeredCount: number = 0;
  @State isCustomFontActive: boolean = false;

  private readonly fontFamilyName: string = CUSTOM_FONT_FAMILY;
  private readonly fontDefinitions: FontFaceDefinition[] = FONT_FACE_DEFINITIONS;
  private registeredFaces: DemoFontFace[] = [];
  private completedCount: number = 0;
  private disposed: boolean = false;

  aboutToAppear(): void {
    this.disposed = false;
    this.registerCustomFonts();
  }

  aboutToDisappear(): void {
    this.disposed = true;

    const facesToUnregister: DemoFontFace[] = this.registeredFaces.slice();
    this.registeredFaces = [];

    facesToUnregister.forEach((face: DemoFontFace) => {
      fontManager.unregisterFontFace(face, (err) => {
        if (err) {
          console.error(`Failed to unregister custom font face: ${err.message}`);
        }
      });
    });
  }

  private registerCustomFonts(): void {
    const faces: DemoFontFace[] = this.fontDefinitions.map(
      (definition: FontFaceDefinition): DemoFontFace => ({
        fontFamily: this.fontFamilyName,
        src: `${FONT_PATH_PREFIX}${definition.fileName}`,
        weight: definition.weight,
        style: definition.style
      })
    );

    this.completedCount = 0;
    this.registeredCount = 0;
    this.registeredFaces = [];
    this.activeFontFamily = FALLBACK_FONT_FAMILY;
    this.isCustomFontActive = false;
    this.statusText = 'Registering custom font faces...';

    faces.forEach((face: DemoFontFace) => {
      fontManager.registerFontFace(face, (err) => {
        if (this.disposed) {
          if (!err) {
            fontManager.unregisterFontFace(face, (unregisterErr) => {
              if (unregisterErr) {
                console.error(`Failed to unregister custom font face: ${unregisterErr.message}`);
              }
            });
          }
          return;
        }

        this.completedCount++;

        if (err) {
          console.error(`Failed to register ${face.src}: ${err.message}`);
        } else {
          this.registeredFaces.push(face);
          this.registeredCount++;
        }

        this.updateRegistrationStatus(faces.length);
      });
    });
  }

  private updateRegistrationStatus(total: number): void {
    if (this.completedCount < total) {
      this.statusText = `Registering custom fonts: ${this.completedCount}/${total} completed...`;
      return;
    }

    if (this.registeredCount === total) {
      this.activeFontFamily = this.fontFamilyName;
      this.isCustomFontActive = true;
      this.statusText = `Registered ${total} font faces for "${this.fontFamilyName}".`;
      return;
    }

    if (this.registeredCount > 0) {
      this.activeFontFamily = this.fontFamilyName;
      this.isCustomFontActive = true;
      this.statusText = `${this.registeredCount}/${total} font faces registered. Missing styles will fall back to the system font.`;
      return;
    }

    this.activeFontFamily = FALLBACK_FONT_FAMILY;
    this.isCustomFontActive = false;
    this.statusText = 'No custom font faces were registered. Add the font files under entry/src/main/resources/base/font/.';
  }

  @Builder
  FontSampleCard(definition: FontFaceDefinition) {
    Row() {
      Column() {
        Text(`${definition.weight}`)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(52)
      .height(52)
      .borderRadius(26)
      .backgroundColor('#2563EB')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(definition.title)
          .fontSize(28)
          .fontWeight(definition.weight)
          .fontStyle(definition.style)
          .fontFamily(this.activeFontFamily)
          .fontColor('#101828')

        Text(definition.description)
          .fontSize(14)
          .lineHeight(22)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .fontFamily(this.activeFontFamily)
          .fontColor('#667085')
          .margin({ top: 6 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 14, bottom: 14 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .borderRadius(18)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#EAECF0' })
    .margin({ top: 10 })
  }

  build() {
    Scroll() {
      Column() {
        Text('Custom Fonts with Styles')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontFamily(this.activeFontFamily)
          .fontColor('#101828')
          .textAlign(TextAlign.Center)
          .margin({ top: 16, bottom: 8 })

        Text('aboutToAppear() registers several font faces for one fontFamily. Each Text element then selects a different weight or style.')
          .fontSize(15)
          .lineHeight(24)
          .fontColor('#475467')
          .textAlign(TextAlign.Center)
          .fontFamily(this.activeFontFamily)
          .padding({ left: 12, right: 12 })

        Row() {
          Text(this.isCustomFontActive ? 'CUSTOM FONT ACTIVE' : 'FALLBACK FONT ACTIVE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(34)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .borderRadius(999)
        .backgroundColor(this.isCustomFontActive ? '#12B76A' : '#F79009')
        .margin({ top: 16, bottom: 12 })

        Text(this.statusText)
          .fontSize(14)
          .lineHeight(22)
          .fontColor('#344054')
          .textAlign(TextAlign.Center)
          .fontFamily(this.activeFontFamily)
          .padding({ left: 16, right: 16 })

        Text('Font files expected in entry/src/main/resources/base/font')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#667085')
          .textAlign(TextAlign.Center)
          .fontFamily(this.activeFontFamily)
          .margin({ top: 8 })

        Text(EXPECTED_FONT_FILES)
          .fontSize(12)
          .lineHeight(18)
          .fontColor('#667085')
          .textAlign(TextAlign.Center)
          .fontFamily(this.activeFontFamily)
          .padding({ left: 16, right: 16 })

        Text('Text samples')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#101828')
          .textAlign(TextAlign.Start)
          .fontFamily(this.activeFontFamily)
          .width('100%')
          .margin({ top: 22, bottom: 12 })

        ForEach(this.fontDefinitions, (definition: FontFaceDefinition) => {
          this.FontSampleCard(definition)
        }, (definition: FontFaceDefinition) => definition.fileName)

        Text('The same custom fontFamily is reused, while fontWeight and fontStyle change for each Text element.')
          .fontSize(14)
          .lineHeight(22)
          .fontColor('#475467')
          .textAlign(TextAlign.Center)
          .fontFamily(this.activeFontFamily)
          .padding({ left: 16, right: 16, top: 18, bottom: 8 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F4F7')
    .scrollBar(BarState.Auto)
  }
}