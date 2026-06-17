import { CustomDialogController, DialogAlignment } from '@ohos.component';

interface Contact {
  id: number;
  name: string;
  phone: string;
  email: string;
  address: string;
}

@Component
struct ContactDialog {
  @Link contact: Contact;
  @Link isShow: boolean;

  build() {
    Column() {
      Text('Contact Details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Column() {
        Row() {
          Text('Name:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.contact.name)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 10 })

        Row() {
          Text('Phone:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.contact.phone)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 10 })

        Row() {
          Text('Email:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.contact.email)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 10 })

        Row() {
          Text('Address:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.contact.address)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .padding(10)

      Button('Close')
        .width('100%')
        .margin({ top: 20 })
        .onClick(() => {
          this.isShow = false;
        })
    }
    .width('80%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 0 })
  }
}

@Entry
@Component
struct Index {
  @State contacts: Contact[] = [];
  @State selectedContact: Contact = { id: 0, name: '', phone: '', email: '', address: '' };
  @State isDialogShow: boolean = false;
  private controller: CustomDialogController;

  aboutToAppear() {
    this.contacts = [
      { id: 1, name: 'Alice Johnson', phone: '555-0101', email: 'alice@example.com', address: '123 Main St' },
      { id: 2, name: 'Bob Smith', phone: '555-0102', email: 'bob@example.com', address: '456 Oak Ave' },
      { id: 3, name: 'Charlie Brown', phone: '555-0103', email: 'charlie@example.com', address: '789 Pine Rd' },
      { id: 4, name: 'Diana Prince', phone: '555-0104', email: 'diana@example.com', address: '101 Hero Ln' },
      { id: 5, name: 'Evan Wright', phone: '555-0105', email: 'evan@example.com', address: '202 Maple Dr' },
      { id: 6, name: 'Fiona Green', phone: '555-0106', email: 'fiona@example.com', address: '303 Cedar Blvd' },
      { id: 7, name: 'George King', phone: '555-0107', email: 'george@example.com', address: '404 Birch Way' },
      { id: 8, name: 'Hannah Lee', phone: '555-0108', email: 'hannah@example.com', address: '505 Elm St' },
      { id: 9, name: 'Ian Scott', phone: '555-0109', email: 'ian@example.com', address: '606 Willow Ct' },
      { id: 10, name: 'Julia Adams', phone: '555-0110', email: 'julia@example.com', address: '707 Spruce Ave' }
    ];

    this.controller = new CustomDialogController({
      builder: this.ContactDialogBuilder(),
      autoOpen: false,
      alignment: DialogAlignment.Center,
      offset: { dx: 0, dy: 0 },
      customStyle: true,
      autoCancel: true
    });
  }

  @Builder
  ContactDialogBuilder() {
    Column() {
      Text('Contact Details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)

      Column() {
        Row() {
          Text('Name:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.selectedContact.name)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 15 })

        Row() {
          Text('Phone:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.selectedContact.phone)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 15 })

        Row() {
          Text('Email:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.selectedContact.email)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ bottom: 15 })

        Row() {
          Text('Address:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width(80)
          Text(this.selectedContact.address)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')

      Button('Close')
        .width('100%')
        .margin({ top: 20 })
        .onClick(() => {
          this.controller.close();
        })
    }
    .width('85%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 15, color: 'rgba(0,0,0,0.25)', offsetX: 0, offsetY: 5 })
  }

  build() {
    Column() {
      Text('Contact List')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      List() {
        ForEach(this.contacts, (contact: Contact) => {
          ListItem() {
            Column() {
              Row() {
                Text(contact.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text(contact.phone)
                  .fontSize(16)
                  .fontColor(Color.Gray)
              }
              .width('100%')
              .padding({ left: 15, right: 15, top: 15, bottom: 15 })

              Divider()
                .strokeWidth(1)
                .color('#E0E0E0')
            }
            .width('100%')
            .onClick(() => {
              this.selectedContact = contact;
              this.controller.open();
            })
          }
        }, (contact: Contact) => contact.id.toString())
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}