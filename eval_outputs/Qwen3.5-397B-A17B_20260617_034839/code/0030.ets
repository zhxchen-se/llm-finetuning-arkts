import { promptAction } from '@ohos.arkui.promptAction';

interface Contact {
  id: number;
  name: string;
  phone: string;
  avatar: string;
}

@Entry
@Component
struct Index {
  @State searchText: string = '';
  @State allContacts: Contact[] = [];
  @State filteredContacts: Contact[] = [];

  aboutToAppear() {
    this.allContacts = [
      { id: 1, name: 'Alice Johnson', phone: '123-456-7890', avatar: 'https://placehold.co/100x100/2196F3/FFFFFF?text=A' },
      { id: 2, name: 'Bob Smith', phone: '234-567-8901', avatar: 'https://placehold.co/100x100/4CAF50/FFFFFF?text=B' },
      { id: 3, name: 'Charlie Brown', phone: '345-678-9012', avatar: 'https://placehold.co/100x100/FF9800/FFFFFF?text=C' },
      { id: 4, name: 'Diana Prince', phone: '456-789-0123', avatar: 'https://placehold.co/100x100/E91E63/FFFFFF?text=D' },
      { id: 5, name: 'Evan Wright', phone: '567-890-1234', avatar: 'https://placehold.co/100x100/9C27B0/FFFFFF?text=E' },
      { id: 6, name: 'Fiona Green', phone: '678-901-2345', avatar: 'https://placehold.co/100x100/00BCD4/FFFFFF?text=F' },
      { id: 7, name: 'George King', phone: '789-012-3456', avatar: 'https://placehold.co/100x100/FFC107/FFFFFF?text=G' }
    ];
    this.filteredContacts = this.allContacts;
  }

  private filterContacts() {
    const query = this.searchText.toLowerCase();
    this.filteredContacts = this.allContacts.filter(contact =>
      contact.name.toLowerCase().includes(query) ||
      contact.phone.includes(query)
    );
  }

  build() {
    Column() {
      TextInput({ placeholder: 'Search contacts...' })
        .onChange((value: string) => {
          this.searchText = value;
          this.filterContacts();
        })
        .width('90%')
        .height(40)
        .margin({ top: 20, bottom: 10 })
        .backgroundColor('#F1F3F5')
        .borderRadius(8)
        .padding({ left: 10 })

      List() {
        ForEach(this.filteredContacts, (contact: Contact) => {
          ListItem() {
            Row() {
              Image(contact.avatar)
                .width(50)
                .height(50)
                .borderRadius(25)
                .objectFit(ImageFit.Cover)
                .margin({ right: 15 })

              Column() {
                Text(contact.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .width('100%')
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)

                Text(contact.phone)
                  .fontSize(14)
                  .fontColor('#666666')
                  .width('100%')
                  .margin({ top: 4 })
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .padding(10)
          }
        }, (contact: Contact) => contact.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: '#E0E0E0', startMargin: 70 })
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
  }
}