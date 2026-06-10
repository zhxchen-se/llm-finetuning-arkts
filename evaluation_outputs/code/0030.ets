// entry/src/main/ets/pages/Index.ets

import { promptAction } from '@kit.ArkUI';

// Contact data model
interface Contact {
  name: string;
  phone: string;
}

@Entry
@Component
struct Index {
  @State searchText: string = '';
  @State contacts: Contact[] = [
    { name: 'Alice Johnson', phone: '555-0101' },
    { name: 'Bob Smith', phone: '555-0102' },
    { name: 'Charlie Brown', phone: '555-0103' },
    { name: 'Diana Prince', phone: '555-0104' },
    { name: 'Evan Williams', phone: '555-0105' },
    { name: 'Fiona Apple', phone: '555-0106' },
    { name: 'George Lucas', phone: '555-0107' },
    { name: 'Hannah Montana', phone: '555-0108' },
    { name: 'Ivan Petrov', phone: '555-0109' },
    { name: 'Julia Roberts', phone: '555-0110' }
  ];

  // Filtered contacts based on search text
  private getFilteredContacts(): Contact[] {
    if (!this.searchText.trim()) {
      return this.contacts;
    }
    const query = this.searchText.trim().toLowerCase();
    return this.contacts.filter(contact => {
      return contact.name.toLowerCase().includes(query) ||
        contact.phone.includes(query);
    });
  }

  // Generate avatar circle with initial
  @Builder
  AvatarBuilder(name: string) {
    Stack() {
      Circle()
        .width(40)
        .height(40)
        .fill('#007AFF')
      Text(name.charAt(0).toUpperCase())
        .fontSize(18)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .width(40)
    .height(40)
  }

  build() {
    Column() {
      // Search bar
      TextInput({ placeholder: 'Search contacts...' })
        .width('100%')
        .height(40)
        .margin({ top: 16, bottom: 8, left: 16, right: 16 })
        .backgroundColor('#F1F1F1')
        .borderRadius(20)
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.searchText = value;
        })

      // Contact list
      List({ space: 8 }) {
        ForEach(this.getFilteredContacts(), (contact: Contact) => {
          ListItem() {
            Row({ space: 12 }) {
              // Avatar
              this.AvatarBuilder(contact.name)

              // Name and phone
              Column({ space: 2 }) {
                Text(contact.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Text(contact.phone)
                  .fontSize(14)
                  .fontColor('#666666')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              promptAction.showToast({ message: `Calling ${contact.name}...` });
            })
          }
        }, (contact: Contact) => contact.phone) // key generator
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}