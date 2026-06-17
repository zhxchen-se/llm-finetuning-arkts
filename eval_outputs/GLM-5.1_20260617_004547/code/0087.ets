interface ContactGroup {
  letter: string;
  names: string[];
}

@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller()
  private alphabets: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  @State contacts: ContactGroup[] = [
    { letter: 'A', names: ['Alice', 'Amy', 'Anna'] },
    { letter: 'B', names: ['Bob', 'Bill', 'Bella'] },
    { letter: 'C', names: ['Charlie', 'Chloe', 'Chris'] },
    { letter: 'D', names: ['David', 'Diana', 'Daniel'] },
    { letter: 'E', names: ['Eve', 'Ethan', 'Emily'] },
    { letter: 'F', names: ['Frank', 'Fiona', 'Fred'] },
    { letter: 'G', names: ['George', 'Grace', 'Gavin'] },
    { letter: 'H', names: ['Henry', 'Hannah', 'Hugo'] },
    { letter: 'I', names: ['Ian', 'Isabella', 'Ivan'] },
    { letter: 'J', names: ['Jack', 'Julia', 'James'] },
    { letter: 'K', names: ['Kevin', 'Karen', 'Kyle'] },
    { letter: 'L', names: ['Leo', 'Lily', 'Lucas'] },
    { letter: 'M', names: ['Michael', 'Mia', 'Matthew'] },
    { letter: 'N', names: ['Nathan', 'Nora', 'Noah'] },
    { letter: 'O', names: ['Oliver', 'Olivia', 'Oscar'] },
    { letter: 'P', names: ['Peter', 'Penny', 'Patrick'] },
    { letter: 'Q', names: ['Quinn', 'Quentin'] },
    { letter: 'R', names: ['Robert', 'Rachel', 'Ryan'] },
    { letter: 'S', names: ['Samuel', 'Sarah', 'Steven'] },
    { letter: 'T', names: ['Thomas', 'Tina', 'Tyler'] },
    { letter: 'U', names: ['Ursula', 'Ulysses'] },
    { letter: 'V', names: ['Victor', 'Victoria', 'Vincent'] },
    { letter: 'W', names: ['William', 'Wendy', 'Wyatt'] },
    { letter: 'X', names: ['Xavier', 'Xena'] },
    { letter: 'Y', names: ['Yasmine', 'Yves'] },
    { letter: 'Z', names: ['Zachary', 'Zoe'] }
  ]

  build() {
    Column() {
      // Header
      Row() {
        Text('Contacts')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1a1a1a')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      .backgroundColor(Color.White)

      // Search Bar
      Row() {
        TextInput({ placeholder: 'Search contacts...' })
          .width('100%')
          .height(40)
          .backgroundColor('#f0f0f0')
          .borderRadius(20)
          .padding({ left: 15, right: 15 })
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 5, bottom: 10 })
      .backgroundColor(Color.White)

      // Contacts List and Alphabet Indexer
      Row() {
        List({ space: 0, scroller: this.scroller }) {
          ForEach(this.contacts, (group: ContactGroup, index?: number) => {
            ListItemGroup({ header: this.GroupHeader(group.letter) }) {
              ForEach(group.names, (name: string) => {
                ListItem() {
                  this.ContactItem(name)
                }
              }, (name: string) => name)
            }
          }, (group: ContactGroup) => group.letter)
        }
        .width('90%')
        .height('100%')
        .divider({ strokeWidth: 0.5, color: '#e0e0e0', startMargin: 65, endMargin: 15 })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        AlphabetIndexer({ arrayValue: this.alphabets, selected: 0 })
          .selectedColor('#007DFF')
          .popupColor('#007DFF')
          .font({ size: 12 })
          .itemSize(18)
          .onSelect((index: number) => {
            this.scroller.scrollToIndex(index, true, ScrollAlign.CENTER)
          })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder GroupHeader(letter: string) {
    Row() {
      Text(letter)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
    }
    .width('100%')
    .padding({ left: 20, top: 12, bottom: 6 })
    .backgroundColor('#F5F5F5')
  }

  @Builder ContactItem(name: string) {
    Row() {
      Text(name.charAt(0))
        .fontSize(18)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .width(40)
        .height(40)
        .borderRadius(20)
        .textAlign(TextAlign.Center)
        .backgroundColor('#007DFF')
        .margin({ right: 15 })

      Column() {
        Text(name)
          .fontSize(16)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .padding({ left: 15, top: 10, bottom: 10 })
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}