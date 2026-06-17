interface Contact {
  id: number;
  name: string;
  phone: string;
  email: string;
  address: string;
}

@CustomDialog
struct ContactDetailDialog {
  controller: CustomDialogController;
  contact: Contact = { id: 0, name: '', phone: '', email: '', address: '' };

  build() {
    Column() {
      Text(this.contact.name)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Divider().margin({ bottom: 15 })

      Row() {
        Text('Phone:')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')
          .width('30%')
        Text(this.contact.phone)
          .fontSize(16)
          .width('70%')
      }.margin({ bottom: 10 })

      Row() {
        Text('Email:')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')
          .width('30%')
        Text(this.contact.email)
          .fontSize(16)
          .width('70%')
      }.margin({ bottom: 10 })

      Row() {
        Text('Address:')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')
          .width('30%')
        Text(this.contact.address)
          .fontSize(16)
          .width('70%')
      }.margin({ bottom: 20 })

      Button('Close')
        .width('100%')
        .backgroundColor('#007DFF')
        .onClick(() => {
          this.controller.close();
        })
    }
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(20)
  }
}

@Entry
@Component
struct Index {
  @State contacts: Contact[] = [
    { id: 1, name: 'Alice Smith', phone: '555-0101', email: 'alice.smith@example.com', address: '123 Maple Street' },
    { id: 2, name: 'Bob Johnson', phone: '555-0102', email: 'bob.j@example.com', address: '456 Oak Avenue' },
    { id: 3, name: 'Charlie Brown', phone: '555-0103', email: 'cbrown@example.com', address: '789 Pine Road' },
    { id: 4, name: 'Diana Prince', phone: '555-0104', email: 'diana.p@example.com', address: '321 Elm Boulevard' },
    { id: 5, name: 'Evan Wright', phone: '555-0105', email: 'ewright@example.com', address: '654 Cedar Lane' },
    { id: 6, name: 'Fiona Gallagher', phone: '555-0106', email: 'fiona.g@example.com', address: '987 Birch Way' },
    { id: 7, name: 'George Costanza', phone: '555-0107', email: 'george.c@example.com', address: '135 Spruce Drive' },
    { id: 8, name: 'Hannah Abbott', phone: '555-0108', email: 'hannah.a@example.com', address: '246 Willow Court' },
    { id: 9, name: 'Ian Malcolm', phone: '555-0109', email: 'ian.m@example.com', address: '357 Redwood Circle' },
    { id: 10, name: 'Julia Roberts', phone: '555-0110', email: 'julia.r@example.com', address: '468 Aspen Path' }
  ];

  @State selectedContact: Contact = { id: 0, name: '', phone: '', email: '', address: '' };
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ContactDetailDialog({ contact: this.selectedContact }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  });

  build() {
    Column() {
      Text('Contacts')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)

      List({ space: 12 }) {
        ForEach(this.contacts, (contact: Contact) => {
          ListItem() {
            Row() {
              Column() {
                Text(contact.name)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                Text(contact.phone)
                  .fontSize(16)
                  .fontColor('#888888')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>')
                .fontSize(20)
                .fontColor('#AAAAAA')
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#F0F0F0', offsetY: 2 })
            .onClick(() => {
              this.selectedContact = contact;
              this.dialogController.open();
            })
          }
        }, (contact: Contact) => contact.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}