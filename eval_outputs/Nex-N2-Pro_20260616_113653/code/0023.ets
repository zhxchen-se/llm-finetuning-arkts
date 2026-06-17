import {
  Button,
  Column,
  Row,
  Text,
  List,
  ListItem,
  Scroll,
  FlexAlign,
  HorizontalAlign,
  VerticalAlign,
  FontWeight,
  TextAlign
} from '@kit.ArkUI';

interface Book {
  id: number;
  title: string;
  releaseDate: string;
  author: string;
  genre: string;
  isbn: string;
  pages: number;
  description: string;
}

@Entry
@Component
struct Index {
  private books: Book[] = [
    {
      id: 1,
      title: 'The Great Gatsby',
      releaseDate: '1925-04-10',
      author: 'F. Scott Fitzgerald',
      genre: 'Classic Fiction',
      isbn: '978-0743273565',
      pages: 180,
      description: 'A classic American novel set in the Jazz Age, exploring wealth, love, ambition, and the illusion of the American Dream.'
    },
    {
      id: 2,
      title: 'To Kill a Mockingbird',
      releaseDate: '1960-07-11',
      author: 'Harper Lee',
      genre: 'Historical Fiction',
      isbn: '978-0061120084',
      pages: 324,
      description: 'A powerful story about justice, morality, and racial inequality in the American South, told through the eyes of a young girl.'
    },
    {
      id: 3,
      title: '1984',
      releaseDate: '1949-06-08',
      author: 'George Orwell',
      genre: 'Dystopian Fiction',
      isbn: '978-0451524935',
      pages: 328,
      description: 'A dystopian novel about totalitarian control, surveillance, propaganda, and the struggle for personal freedom.'
    },
    {
      id: 4,
      title: 'The Hobbit',
      releaseDate: '1937-09-21',
      author: 'J. R. R. Tolkien',
      genre: 'Fantasy',
      isbn: '978-0547928227',
      pages: 310,
      description: 'A fantasy adventure following Bilbo Baggins as he joins a quest to reclaim the lost kingdom of the Dwarves.'
    },
    {
      id: 5,
      title: 'Pride and Prejudice',
      releaseDate: '1813-01-28',
      author: 'Jane Austen',
      genre: 'Romance',
      isbn: '978-0141439518',
      pages: 432,
      description: 'A beloved romantic novel that examines manners, marriage, class, and personal growth in early nineteenth-century England.'
    },
    {
      id: 6,
      title: 'Dune',
      releaseDate: '1965-08-01',
      author: 'Frank Herbert',
      genre: 'Science Fiction',
      isbn: '978-0441172719',
      pages: 688,
      description: 'An epic science fiction novel about politics, religion, ecology, and power on the desert planet Arrakis.'
    }
  ];

  @State selectedIndex: number = -1;

  build() {
    const selectedBook: Book | undefined = this.selectedIndex >= 0 ? this.books[this.selectedIndex] : undefined;

    Column() {
      if (selectedBook) {
        this.BookDetail(selectedBook);
      } else {
        this.BookList();
      }
    }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .backgroundColor('#F8FAFC')
      .alignItems(HorizontalAlign.Start);
  }

  @Builder
  BookList() {
    Column() {
      Text('Books')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ bottom: 8 });

      Text('Tap a book title to view details')
        .fontSize(14)
        .fontColor('#64748B')
        .margin({ bottom: 20 });

      List({ space: 12 }) {
        ForEach(this.books, (book: Book, index: number) => {
          ListItem() {
            Row() {
              Text('📚')
                .fontSize(26)
                .width(44)
                .height(44)
                .textAlign(TextAlign.Center)
                .backgroundColor('#EFF6FF')
                .borderRadius(22);

              Column() {
                Text(book.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedIndex = index;
                  });

                Row() {
                  Text('Release date')
                    .fontSize(12)
                    .fontColor('#64748B');

                  Text(book.releaseDate)
                    .fontSize(12)
                    .fontColor('#64748B')
                    .margin({ left: 6 });
                }
                  .width('100%');
              }
                .layoutWeight(1)
                .margin({ left: 12 });

              Text('Details')
                .fontSize(14)
                .fontColor('#2563EB')
                .fontWeight(FontWeight.Medium);
            }
              .width('100%')
              .alignItems(VerticalAlign.Center);
          }
            .padding(16)
            .borderRadius(16)
            .backgroundColor('#FFFFFF');
        }, (book: Book) => book.id);
      }
        .width('100%')
        .layoutWeight(1);
    }
      .width('100%')
      .height('100%');
  }

  @Builder
  BookDetail(book: Book) {
    Scroll() {
      Column() {
        Row() {
          Button('Back')
            .fontSize(14)
            .height(36)
            .fontColor('#FFFFFF')
            .backgroundColor('#2563EB')
            .borderRadius(18)
            .onClick(() => {
              this.selectedIndex = -1;
            });

          Text(book.title)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A');
        }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 20 });

        Text('Book Details')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ bottom: 16 });

        this.InfoCard('Release Date', book.releaseDate);
        this.InfoCard('Author', book.author);
        this.InfoCard('Genre', book.genre);
        this.InfoCard('ISBN', book.isbn);
        this.InfoCard('Pages', `${book.pages} pages`);

        Text('Description')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ top: 20, bottom: 8 });

        Text(book.description)
          .fontSize(16)
          .lineHeight(24)
          .fontColor('#334155')
          .width('100%');
      }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ bottom: 24 });
    }
      .width('100%')
      .layoutWeight(1);
  }

  @Builder
  InfoCard(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontColor('#64748B')
        .margin({ bottom: 4 });

      Text(value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827');
    }
      .width('100%')
      .padding(14)
      .borderRadius(12)
      .backgroundColor('#FFFFFF')
      .margin({ bottom: 10 });
  }
}