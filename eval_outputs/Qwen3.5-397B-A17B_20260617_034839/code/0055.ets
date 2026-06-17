// ============================================================================
// CUSTOM FONT REGISTRATION GUIDE
// ============================================================================
// To use custom fonts in this application, you must register them in:
// resources/base/profile/font_config.json
//
// Example font_config.json content:
// {
//   "fonts": [
//     {
//       "familyName": "MyCustomFont",
//       "fontFile": "media/font/MyCustomFont-Regular.ttf"
//     },
//     {
//       "familyName": "MyCustomFont",
//       "fontFile": "media/font/MyCustomFont-Bold.ttf",
//       "weight": 700
//     },
//     {
//       "familyName": "MyCustomFont",
//       "fontFile": "media/font/MyCustomFont-Italic.ttf",
//       "style": "italic"
//     }
//   ]
// }
//
// Place your .ttf or .otf files in: resources/base/media/font/
// ============================================================================

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('HarmonyOS Custom Font Demo')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 30 })
        .fontColor('#007DFF')

      // 1. System Default
      Text('1. System Default Font')
        .fontSize(20)
        .margin({ bottom: 15 })
        .width('100%')

      // 2. Custom Font Regular
      // Applies the registered fontFamily 'MyCustomFont'
      Text('2. Custom Font (Regular)')
        .fontSize(20)
        .fontFamily('MyCustomFont')
        .margin({ bottom: 15 })
        .width('100%')

      // 3. Custom Font Bold
      // Uses FontWeight enum to select bold variant
      Text('3. Custom Font (Bold)')
        .fontSize(20)
        .fontFamily('MyCustomFont')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 15 })
        .width('100%')

      // 4. Custom Font Italic
      // Uses FontStyle enum for italic slant
      Text('4. Custom Font (Italic)')
        .fontSize(20)
        .fontFamily('MyCustomFont')
        .fontStyle(FontStyle.Italic)
        .margin({ bottom: 15 })
        .width('100%')

      // 5. Custom Font Custom Weight
      // Uses numeric value for specific weight (100-900)
      Text('5. Custom Font (Weight 500)')
        .fontSize(20)
        .fontFamily('MyCustomFont')
        .fontWeight(500)
        .margin({ bottom: 15 })
        .width('100%')

      // 6. Font Fallback Example
      // If 'MyCustomFont' is not registered, this falls back to system font
      Text('6. Fallback (If not registered)')
        .fontSize(20)
        .fontFamily('MyCustomFont')
        .fontColor(Color.Gray)
        .margin({ bottom: 15 })
        .width('100%')

      Divider()
        .margin({ top: 20, bottom: 20 })

      Text('Check resources/base/profile/font_config.json')
        .fontSize(14)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding(24)
  }
}