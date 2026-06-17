interface Book {
  id: number;
  title: string;
  releaseDate: string;
  author: string;
  description: string;
  isbn: string;
}

@Entry
@Component
struct Index {
  @State activeBook: Book | null = null;

  private books: Book[] = [
    {
      id: 1,
      title: 'The Great Gatsby',
      releaseDate: '1925-04-10',
      author: 'F. Scott Fitzgerald',
      description: 'A story of decadence and excess, Gatsby explores the American Dream in the Jazz Age.',
      isbn: '978-0743273565'
    },
    {
      id: 2,
      title: '1984',
      releaseDate: '1949-06-08',
      author: 'George Orwell',
      description: 'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.',
      isbn: '978-0451524935'
    },
    {
      id: 3,
      title: 'To Kill a Mockingbird',
      releaseDate: '1960-07-11',
      author: 'Harper Lee',
      description: 'The story of racial injustice and the loss of innocence in the American South.',
      isbn: '978-0446310789'
    },
    {
      id: 4,
      title: 'Pride and Prejudice',
      releaseDate: '1813-01-28',
      author: 'Jane Austen',
      description: 'A romantic novel of manners that follows the character development of Elizabeth Bennet.',
      isbn: '978-0141439518'
    },
    {
      id: 5,
      title: 'The Catcher in the Rye',
      releaseDate: '1951-07-16',
      author: 'J.D. Salinger',
      description: 'A story about teenage alienation and loss of innocence in post-war America.',
      isbn: '978-0316769488'
    }
  ];

  build() {
    Column() {
      if (this.activeBook === null) {
        this.ListView()
      } else {
        this.DetailView()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  ListView() {
    Column() {
      Text('Book Library')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .fontColor('#333333')

      List() {
        ForEach(this.books, (book: Book) => {
          ListItem() {
            Column() {
              Row() {
                Text(book.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1A1A1A')
                  .flexGrow(1)

                Text(book.releaseDate)
                  .fontSize(14)
                  .fontColor('#666666')
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .onClick(() => {
                this.activeBook = book;
              })

              Divider()
                .color('#E0E0E0')
                .strokeWidth(1)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
          }
          .margin({ bottom: 8 })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DetailView() {
    Column() {
      Row() {
        Text('← Back')
          .fontSize(16)
          .fontColor('#007DFF')
          .onClick(() => {
            this.activeBook = null;
          })
          .padding(10)

        Text(this.activeBook!.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ left: 10 })
          .flexGrow(1)
          .textAlign(TextAlign.Center)
          .padding({ right: 46 }) // Balance the back button width
      }
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })

      Column() {
        Text('Release Date')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 20, bottom: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.activeBook!.releaseDate)
          .fontSize(18)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Text('Author')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 20, bottom: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.activeBook!.author)
          .fontSize(18)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Text('ISBN')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 20, bottom: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.activeBook!.isbn)
          .fontSize(18)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Text('Description')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 20, bottom: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.activeBook!.description)
          .fontSize(16)
          .fontColor('#555555')
          .lineHeight(24)
          .alignSelf(ItemAlign.Start)
          .width('100%')
      }
      .width('100%')
      .padding(16)
      .margin({ top: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
  }
}