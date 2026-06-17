class Book {
  title: string;
  releaseDate: string;
  author: string;
  description: string;

  constructor(title: string, releaseDate: string, author: string, description: string) {
    this.title = title;
    this.releaseDate = releaseDate;
    this.author = author;
    this.description = description;
  }
}

@Entry
@Component
struct Index {
  @State selectedBook: Book | null = null;
  private books: Book[] = [
    new Book('The Great Gatsby', '1925-04-10', 'F. Scott Fitzgerald', 'A story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.'),
    new Book('To Kill a Mockingbird', '1960-07-11', 'Harper Lee', 'A novel about racial injustice in the Deep South, seen through the eyes of young Scout Finch.'),
    new Book('1984', '1949-06-08', 'George Orwell', 'A dystopian social science fiction novel and cautionary tale about the future of totalitarianism.'),
    new Book('Pride and Prejudice', '1813-01-28', 'Jane Austen', 'A romantic novel of manners that follows the character development of Elizabeth Bennet.'),
    new Book('The Catcher in the Rye', '1951-07-16', 'J.D. Salinger', 'A story about teenage angst and alienation, narrated by the iconic Holden Caulfield.')
  ];

  build() {
    Column() {
      if (this.selectedBook === null) {
        // Book list view
        Text('Book List')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Center)

        List({ space: 10 }) {
          ForEach(this.books, (book: Book, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Text(book.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  Text(`Released: ${book.releaseDate}`)
                    .fontSize(14)
                    .fontColor('#666666')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Image($r('app.media.ic_arrow_right'))
                  .width(24)
                  .height(24)
                  .opacity(0.5)
              }
              .width('100%')
              .padding(15)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onClick(() => {
                this.selectedBook = book;
              })
            }
          }, (book: Book) => book.title)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
      } else {
        // Detail view
        Column() {
          Row() {
            Button('Back')
              .fontSize(16)
              .backgroundColor('#007AFF')
              .fontColor(Color.White)
              .borderRadius(8)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .onClick(() => {
                this.selectedBook = null;
              })
            Blank()
            Text('Book Details')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Blank()
            // Placeholder to balance the row
            Row().width(60) // same width as button area
          }
          .width('100%')
          .padding(16)
          .margin({ top: 10 })

          Column() {
            Text(this.selectedBook!.title)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 })

            Text(`Author: ${this.selectedBook!.author}`)
              .fontSize(18)
              .fontColor('#333333')
              .margin({ bottom: 8 })

            Text(`Release Date: ${this.selectedBook!.releaseDate}`)
              .fontSize(16)
              .fontColor('#555555')
              .margin({ bottom: 20 })

            Text(this.selectedBook!.description)
              .fontSize(16)
              .fontColor('#444444')
              .lineHeight(24)
              .textAlign(TextAlign.Start)
              .width('100%')
          }
          .width('100%')
          .padding(20)
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}