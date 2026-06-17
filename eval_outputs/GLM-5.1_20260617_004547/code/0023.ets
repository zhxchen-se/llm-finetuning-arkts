class Book {
  id: number
  title: string
  releaseDate: string
  author: string
  description: string

  constructor(id: number, title: string, releaseDate: string, author: string, description: string) {
    this.id = id;
    this.title = title;
    this.releaseDate = releaseDate;
    this.author = author;
    this.description = description;
  }
}

const booksData: Book[] = [
  new Book(1, "The Great Gatsby", "April 10, 1925", "F. Scott Fitzgerald", "A story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, set in the Jazz Age on Long Island."),
  new Book(2, "1984", "June 8, 1949", "George Orwell", "A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism."),
  new Book(3, "To Kill a Mockingbird", "July 11, 1960", "Harper Lee", "A novel concerning the racial injustice in a small Alabama town."),
  new Book(4, "Pride and Prejudice", "January 28, 1813", "Jane Austen", "A romantic novel of manners charting the emotional development of the protagonist Elizabeth Bennet."),
  new Book(5, "The Catcher in the Rye", "July 16, 1951", "J.D. Salinger", "A story about a few days in the life of a teenager named Holden Caulfield.")
];

@Component
struct BookListView {
  private books: Book[] = booksData;
  onBookClick: (book: Book) => void = () => {};

  build() {
    Column() {
      Text('Book Library')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      List({ space: 10 }) {
        ForEach(this.books, (book: Book) => {
          ListItem() {
            Row() {
              Column() {
                Text(book.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                Text(book.releaseDate)
                  .fontSize(14)
                  .fontColor('#888888')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>')
                .fontSize(18)
                .fontColor('#CCCCCC')
            }
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(10)
            .onClick(() => this.onBookClick(book))
          }
        }, (book: Book) => book.id.toString())
      }
      .width('90%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct BookDetailView {
  @Prop book: Book;
  onBack: () => void = () => {};

  build() {
    Column() {
      Row() {
        Text('< Back')
          .fontSize(18)
          .fontColor('#007DFF')
          .onClick(() => this.onBack())
          .padding({ right: 10 })
        Text(this.book.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 40 })
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)

      Scroll() {
        Column() {
          Row() {
            Text('📖')
              .fontSize(60)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#E0E0E0')
          .borderRadius(10)
          .margin({ top: 20 })

          Text(this.book.title)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20 })

          Text(`by ${this.book.author}`)
            .fontSize(18)
            .fontColor('#555555')
            .margin({ top: 8 })

          Text(`Released: ${this.book.releaseDate}`)
            .fontSize(16)
            .fontColor('#888888')
            .margin({ top: 8 })

          Text('Description')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 30, bottom: 10 })

          Text(this.book.description)
            .fontSize(16)
            .lineHeight(24)
            .fontColor('#333333')
        }
        .padding(15)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

@Entry
@Component
struct Index {
  @State selectedBook: Book | null = null;

  build() {
    Column() {
      if (this.selectedBook) {
        BookDetailView({ book: this.selectedBook, onBack: () => { this.selectedBook = null; } })
      } else {
        BookListView({ onBookClick: (book: Book) => { this.selectedBook = book; } })
      }
    }
    .width('100%')
    .height('100%')
  }
}