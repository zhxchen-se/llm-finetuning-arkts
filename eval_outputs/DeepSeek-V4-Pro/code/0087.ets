import { List, ListItem, ListItemGroup, Stack, Column, Text, ForEach, Scroller } from '@ohos.arkui.advanced';

interface Contact {
  name: string;
  phone: string;
}

interface Group {
  letter: string;
  contacts: Contact[];
}

@Entry
@Component
struct Index {
  @State contacts: Contact[] = [
    { name: 'Alice', phone: '1234567890' },
    { name: 'Bob', phone: '2345678901' },
    { name: 'Charlie', phone: '3456789012' },
    { name: 'David', phone: '4567890123' },
    { name: 'Eve', phone: '5678901234' },
    { name: 'Frank', phone: '6789012345' },
    { name: 'Grace', phone: '7890123456' },
    { name: 'Hank', phone: '8901234567' },
    { name: 'Ivy', phone: '9012345678' },
    { name: 'Jack', phone: '0123456789' },
    { name: 'Kate', phone: '1234567890' },
    { name: 'Leo', phone: '2345678901' },
    { name: 'Mia', phone: '3456789012' },
    { name: 'Nick', phone: '4567890123' },
    { name: 'Olivia', phone: '5678901234' },
    { name: 'Paul', phone: '6789012345' },
    { name: 'Quinn', phone: '7890123456' },
    { name: 'Rose', phone: '8901234567' },
    { name: 'Sam', phone: '9012345678' },
    { name: 'Tina', phone: '0123456789' },
    { name: 'Uma', phone: '1234567890' },
    { name: 'Vince', phone: '2345678901' },
    { name: 'Wendy', phone: '3456789012' },
    { name: 'Xander', phone: '4567890123' },
    { name: 'Yara', phone: '5678901234' },
    { name: 'Zack', phone: '6789012345' },
    { name: 'Aaron', phone: '7890123456' },
    { name: 'Bella', phone: '8901234567' },
    { name: 'Cathy', phone: '9012345678' },
    { name: 'Derek', phone: '0123456789' }
  ];
  @State groups: Group[] = [];
  @State selectedLetter: string = '';
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.groupContacts();
  }

  groupContacts() {
    const map = new Map<string, Contact[]>();
    this.contacts.forEach(contact => {
      const firstLetter = contact.name.charAt(0).toUpperCase();
      if (!map.has(firstLetter)) {
        map.set(firstLetter, []);
      }
      map.get(firstLetter)!.push(contact);
    });
    const letters = Array.from(map.keys()).sort();
    this.groups = letters.map(letter => ({
      letter: letter,
      contacts: map.get(letter)!
    }));
  }

  scrollToLetter(letter: string) {
    const index = this.groups.findIndex(group => group.letter === letter);
    if (index !== -1) {
      this.scroller.scrollToIndex(index);
      this.selectedLetter = letter;
    }
  }

  build() {
    Stack() {
      List({ scroller: this.scroller }) {
        ForEach(this.groups, (group: Group, groupIndex: number) => {
          ListItemGroup({ header: this.groupHeader(group.letter) }) {
            ForEach(group.contacts, (contact: Contact) => {
              ListItem() {
                Column() {
                  Text(contact.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  Text(contact.phone)
                    .fontSize(14)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .width('100%')
              }
            }, (contact: Contact) => contact.name + contact.phone)
          }
        }, (group: Group) => group.letter)
      }
      .width('100%')
      .height('100%')
      .divider({ strokeWidth: 0.5, color: '#e0e0e0' })

      // Alphabet sidebar
      Column() {
        ForEach(this.groups, (group: Group) => {
          Text(group.letter)
            .fontSize(14)
            .fontColor(this.selectedLetter === group.letter ? '#007AFF' : '#333333')
            .fontWeight(this.selectedLetter === group.letter ? FontWeight.Bold : FontWeight.Normal)
            .width(30)
            .height(30)
            .textAlign(TextAlign.Center)
            .borderRadius(15)
            .backgroundColor(this.selectedLetter === group.letter ? '#E8F0FE' : Color.Transparent)
            .onClick(() => {
              this.scrollToLetter(group.letter);
            })
        }, (group: Group) => group.letter)
      }
      .width(40)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '90%', y: 0 })
      .backgroundColor('#F5F5F5')
      .opacity(0.9)
    }
    .width('100%')
    .height('100%')
  }

  @Builder groupHeader(letter: string) {
    Text(letter)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor('#333333')
      .padding({ left: 16, top: 8, bottom: 4 })
      .width('100%')
      .backgroundColor('#F0F0F0')
  }
}