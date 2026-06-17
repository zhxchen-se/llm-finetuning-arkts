import font from '@ohos.font';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct Index {
  @State regularFontFamily: string = 'HarmonyOS Sans';
  @State boldFontFamily: string = 'HarmonyOS Sans';
  @State italicFontFamily: string = 'HarmonyOS Sans';
  @State registrationError: string = '';

  async aboutToAppear(): Promise<void> {
    try {
      // Register custom regular font
      await font.registerFont({
        familyName: 'CustomFontRegular',
        familySrc: $rawfile('CustomFont-Regular.ttf')
      });
      this.regularFontFamily = 'CustomFontRegular';

      // Register custom bold font
      await font.registerFont({
        familyName: 'CustomFontBold',
        familySrc: $rawfile('CustomFont-Bold.ttf')
      });
      this.boldFontFamily = 'CustomFontBold';

      // Register custom italic font
      await font.registerFont({
        familyName: 'CustomFontItalic',
        familySrc: $rawfile('CustomFont-Italic.ttf')
      });
      this.italicFontFamily = 'CustomFontItalic';
    } catch (err) {
      let error = err as BusinessError;
      this.registrationError = `Font registration failed: ${error.message}`;
      // Fallback to default fonts
      this.regularFontFamily = 'HarmonyOS Sans';
      this.boldFontFamily = 'HarmonyOS Sans';
      this.italicFontFamily = 'HarmonyOS Sans';
    }
  }

  async aboutToDisappear(): Promise<void> {
    // Unregister fonts to free resources (optional)
    try {
      await font.unregisterFont({ familyName: 'CustomFontRegular' });
      await font.unregisterFont({ familyName: 'CustomFontBold' });
      await font.unregisterFont({ familyName: 'CustomFontItalic' });
    } catch (err) {
      console.error('Font unregistration failed:', JSON.stringify(err));
    }
  }

  build() {
    Column() {
      if (this.registrationError) {
        Text(this.registrationError)
          .fontSize(14)
          .fontColor(Color.Red)
          .margin({ bottom: 12 });
      }

      Text('Custom Fonts Demo')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      // Regular custom font
      Text('This is Regular Custom Font')
        .fontFamily(this.regularFontFamily)
        .fontSize(18)
        .fontColor('#333333')
        .margin({ bottom: 12 });

      // Bold custom font (using separate bold family)
      Text('This is Bold Custom Font')
        .fontFamily(this.boldFontFamily)
        .fontSize(18)
        .fontColor('#333333')
        .margin({ bottom: 12 });

      // Italic custom font (using separate italic family)
      Text('This is Italic Custom Font')
        .fontFamily(this.italicFontFamily)
        .fontSize(18)
        .fontColor('#333333')
        .margin({ bottom: 12 });

      // Using system font with custom weight and style (fallback example)
      Text('System Font with Bold and Italic')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .fontColor('#666666')
        .margin({ bottom: 12 });

      // Mixed: custom regular family with explicit bold weight (may not work if font lacks bold variant)
      Text('Custom Regular + Bold weight (fallback)')
        .fontFamily(this.regularFontFamily)
        .fontWeight(FontWeight.Bold)
        .fontSize(18)
        .fontColor('#999999')
        .margin({ bottom: 12 });
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}