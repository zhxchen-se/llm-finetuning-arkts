const LETTERS: string[] = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

const AVATAR_COLORS: string[] = [
  '#0A84FF',
  '#34C759',
  '#FF9500',
  '#FF2D55',
  '#AF52DE',
  '#00C7BE',
  '#5856D6',
  '#8E8E93'
];

interface ContactItem {
  id: number;
  name: string;
  phone: string;
  letter: string;
  isHeader: boolean;
}

@Entry
@Component
struct Index {
  @State contacts: ContactItem[] = [];
  @State selectedLetter: string = 'A';
  @State contactCount: number = 0;

  private listScroller: Scroller = new Scroller();
  private firstIndexMap: { [key: string]: number } = {};

  aboutToAppear(): void {
    this.contacts = this.createContacts();
    this.contactCount = this.contacts.filter((item: ContactItem) => !item.isHeader).length;
    this.buildIndexMap();
  }

  build() {
    Column() {
      Column() {
        Text('Contacts')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .margin({ bottom: 4 })

        Text('Alphabet index')
          .fontSize(14)
          .fontColor('#6B7280')

        Text(this.contactCount + ' contacts')
          .fontSize(13)
          .fontColor('#8A8A8A')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 12 })

      Row() {
        List({ scroller: this.listScroller, space: 8 }) {
          ForEach(this.contacts, (contact: ContactItem) => {
            ListItem() {
              if (contact.isHeader) {
                Text(contact.name)
                  .width('100%')
                  .height(34)
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6B7280')
                  .textAlign(TextAlign.Start)
                  .padding({ left: 4, right: 4 })
                  .backgroundColor('#F5F7FA')
              } else {
                Row() {
                  Column() {
                    Text(contact.name[0])
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                  }
                  .width(44)
                  .height(44)
                  .borderRadius(22)
                  .backgroundColor(this.getAvatarColor(contact.letter))
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)

                  Column() {
                    Text(contact.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#111111')

                    Text(contact.phone)
                      .fontSize(13)
                      .fontColor('#8A8A8A')
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 12 })
                }
                .width('100%')
                .height(72)
                .padding({ left: 16, right: 16 })
                .backgroundColor('#FFFFFF')
                .borderRadius(14)
                .alignItems(VerticalAlign.Center)
              }
            }
            .width('100%')
          }, (contact: ContactItem) => contact.id)
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Auto)
        .padding({ left: 0, right: 44, top: 8, bottom: 8 })
        .backgroundColor('#F5F7FA')

        Column() {
          ForEach(LETTERS, (letter: string) => {
            Column() {
              Text(letter)
                .fontColor(this.selectedLetter === letter ? '#FFFFFF' : '#6B7280')
                .fontSize(this.selectedLetter === letter ? 14 : 12)
                .fontWeight(this.selectedLetter === letter ? FontWeight.Bold : FontWeight.Normal)
            }
            .width(30)
            .height(24)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.selectedLetter === letter ? '#0A84FF' : '#00000000')
            .borderRadius(12)
            .onClick(() => {
              this.selectLetter(letter);
            })
          }, (letter: string) => letter)
        }
        .width(36)
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 24, bottom: 0 })
    .backgroundColor('#F5F7FA')
  }

  private buildIndexMap(): void {
    this.firstIndexMap = {};

    for (let i = 0; i < this.contacts.length; i++) {
      if (this.contacts[i].isHeader) {
        this.firstIndexMap[this.contacts[i].letter] = i;
      }
    }
  }

  private selectLetter(letter: string): void {
    this.selectedLetter = letter;

    const index: number | undefined = this.firstIndexMap[letter];
    if (index !== undefined) {
      this.listScroller.scrollToIndex(index, ScrollAlign.Start);
    }
  }

  private createContacts(): ContactItem[] {
    const rawNames: string[] = [
      'Aaron Price',
      'Adam Carter',
      'Benjamin Lee',
      'Charlotte Brown',
      'Chloe Davis',
      'Daniel Harris',
      'Emma Wilson',
      'Ethan Moore',
      'Felix Martin',
      'Grace Thompson',
      'Henry Walker',
      'Isabella Clark',
      'Jack Robinson',
      'Katherine Young',
      'Liam Anderson',
      'Mia Martinez',
      'Noah King',
      'Olivia Scott',
      'Peter Green',
      'Quincy Adams',
      'Rachel Baker',
      'Samuel Nelson',
      'Thomas Hill',
      'Uma Patel',
      'Victoria Reed',
      'William Evans',
      'Xavier Brooks',
      'Yara Morgan',
      'Zoe Turner'
    ];

    const rawContacts: ContactItem[] = [];

    for (let i = 0; i < rawNames.length; i++) {
      rawContacts.push({
        id: i + 1,
        name: rawNames[i],
        phone: this.formatPhone(i),
        letter: rawNames[i].charAt(0).toUpperCase(),
        isHeader: false
      });
    }

    rawContacts.sort((a: ContactItem, b: ContactItem) => {
      if (a.letter === b.letter) {
        return a.name.localeCompare(b.name);
      }
      return a.letter.localeCompare(b.letter);
    });

    const result: ContactItem[] = [];
    let currentLetter: string = '';

    for (let i = 0; i < rawContacts.length; i++) {
      const contact: ContactItem = rawContacts[i];

      if (contact.letter !== currentLetter) {
        currentLetter = contact.letter;

        result.push({
          id: 1000 + result.length,
          name: currentLetter,
          phone: '',
          letter: currentLetter,
          isHeader: true
        });
      }

      result.push({
        id: 2000 + result.length,
        name: contact.name,
        phone: contact.phone,
        letter: contact.letter,
        isHeader: false
      });
    }

    return result;
  }

  private formatPhone(index: number): string {
    const value: string = String(index + 1);
    let paddedValue: string = value;

    if (value.length === 1) {
      paddedValue = '000' + value;
    } else if (value.length === 2) {
      paddedValue = '00' + value;
    } else if (value.length === 3) {
      paddedValue = '0' + value;
    }

    return '+1 202-555-' + paddedValue;
  }

  private getAvatarColor(letter: string): string {
    const index: number = LETTERS.indexOf(letter);
    const safeIndex: number = index < 0 ? 0 : index;
    return AVATAR_COLORS[safeIndex % AVATAR_COLORS.length];
  }
}