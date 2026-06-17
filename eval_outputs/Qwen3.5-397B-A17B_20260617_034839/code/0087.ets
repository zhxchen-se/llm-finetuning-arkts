@Entry
@Component
struct Index {
  private contacts: Contact[] = [];
  private indexerData: string[] = [];
  private listController: ListController = new ListController();

  interface Contact {
    name: string;
    phone: string;
  }

  aboutToAppear() {
    this.initData();
  }

  initData() {
    const names = [
      "Alice", "Andrew", "Anna", "Bob", "Brian", "Catherine", "Charlie", "David",
      "Diana", "Edward", "Eve", "Frank", "Grace", "Henry", "Ivy", "Jack", "Kate",
      "Leo", "Mary", "Nick", "Olivia", "Paul", "Quinn", "Rose", "Sam", "Tina",
      "Victor", "Wendy", "Xavier", "Yvonne", "Zoe"
    ];

    this.contacts = names.map((name, index) => ({
      name: name,
      phone: `+1 555-01${index.toString().padStart(2, '0')}`
    }));

    this.indexerData = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
  }

  getScrollIndex(letter: string): number {
    const index = this.contacts.findIndex(contact =>
      contact.name.toUpperCase().startsWith(letter)
    );
    return index !== -1 ? index : 0;
  }

  build() {
    Column() {
      Text('Contacts')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .padding(16)
        .width('100%')
        .backgroundColor('#f1f3f5')

      List({ space: 10, controller: this.listController }) {
        ForEach(this.contacts, (item: Contact) => {
          ListItem() {
            Column({ space: 4 }) {
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Text(item.phone)
                .fontSize(14)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .width('100%')
            .backgroundColor('#ffffff')
            .borderRadius(8)
          }
        }, (item: Contact) => item.name)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .indexer({
        indexerData: this.indexerData,
        onIndexChange: (index: number) => {
          const letter = this.indexerData[index];
          const targetIndex = this.getScrollIndex(letter);
          this.listController.scrollToIndex(targetIndex, ScrollPosition.Start);
        },
        selectedColor: '#007dff',
        normalColor: '#999999'
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
  }
}