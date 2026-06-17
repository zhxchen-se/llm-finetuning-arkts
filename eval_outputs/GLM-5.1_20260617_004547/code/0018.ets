@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column({ space: 30 }) {
        // Example 1: Using Span with textBackgroundStyle for inline highlights
        Text() {
          Span('This is normal text. ')
          Span('This is highlighted in yellow. ')
            .textBackgroundStyle({ color: '#FFFF00', radius: 4 })
            .fontColor(Color.Black)
          Span('This is highlighted in blue. ')
            .textBackgroundStyle({ color: '#0000FF', radius: 4 })
            .fontColor(Color.White)
          Span('This is a bold green highlight. ')
            .textBackgroundStyle({ color: '#008000', radius: 4 })
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .fontSize(18)
        .lineHeight(35)

        // Example 2: Using ContainerSpan for highlights with padding and rounded corners
        Text() {
          Span('Text before highlight. ')
          ContainerSpan() {
            Span('Rounded Highlight with Padding')
              .fontColor(Color.White)
              .fontSize(18)
          }
          .textBackgroundStyle({ color: '#FF5733', radius: 12 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          Span(' Text after highlight.')
        }
        .fontSize(18)
        .lineHeight(35)

        // Example 3: Combining highlights with other text styles
        Text() {
          Span('Normal text mixed with ')
          Span('italic red highlight. ')
            .fontStyle(FontStyle.Italic)
            .textBackgroundStyle({ color: '#FF0000', radius: 2 })
            .fontColor(Color.White)
          Span('And an ')
          Span('underlined purple highlight.')
            .decoration({ type: TextDecorationType.Underline, color: Color.White })
            .textBackgroundStyle({ color: '#9B59B6', radius: 2 })
            .fontColor(Color.White)
        }
        .fontSize(18)
        .lineHeight(35)

        // Example 4: Tag-like highlights
        Text() {
          Span('Tags: ')
          ContainerSpan() {
            Span(' HarmonyOS ')
              .fontColor(Color.White)
              .fontSize(14)
          }
          .textBackgroundStyle({ color: '#1E90FF', radius: 10 })
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          
          Span(' ')
          
          ContainerSpan() {
            Span(' ArkTS ')
              .fontColor(Color.White)
              .fontSize(14)
          }
          .textBackgroundStyle({ color: '#FF8C00', radius: 10 })
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        }
        .fontSize(18)
        .lineHeight(35)
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}