import { CustomDialogController } from '@ohos.arkui.advanced.CustomDialogController';

interface Contact {
  name: string;
  phone: string;
  email: string;
  address: string;
}

@CustomDialog
struct ContactDetailDialog {
  controller: CustomDialogController;
  @Link contact: Contact;

  build() {
    Column() {
      Text('Contact Details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 });
      Text(`Name: ${this.contact.name}`)
        .fontSize(16)
        .margin({ bottom: 8 });
      Text(`Phone: ${this.contact.phone}`)
        .fontSize(16)
        .margin({ bottom: 8 });
      Text(`Email: ${this.contact.email}`)
        .fontSize(16)
        .margin({ bottom: 8 });
      Text(`Address: ${this.contact.address}`)
        .fontSize(16)
        .margin({ bottom: 16 });
      Button('Close')
        .onClick(() => {
          this.controller.close();
        })
    }
    .padding(20)
  }
}

@Entry
@Component
struct Index {
  @State contacts: Contact[] = [
    { name: 'Alice Johnson', phone: '555-0101', email: 'alice@example.com', address: '123 Main St' },
    { name: 'Bob Smith', phone: '555-0102', email: 'bob@example.com', address: '456 Oak Ave' },
    { name: 'Charlie Brown', phone: '555-0103', email: 'charlie@example.com', address: '789 Pine Rd' },
    { name: 'Diana Prince', phone: '555-0104', email: 'diana@example.com', address: '321 Elm St' },
    { name: 'Evan Wright', phone: '555-0105', email: 'evan@example.com', address: '654 Maple Dr' }
  ];
  @State selectedContact: Contact = {
    name: '',
    phone: '',
    email: '',
    address: ''
  };
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ContactDetailDialog({ contact: $selectedContact }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  });

  build() {
    Column() {
      Text('Contacts')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding(16)
        .textAlign(TextAlign.Center);

      List({ space: 1 }) {
        ForEach(this.contacts, (contact: Contact) => {
          ListItem() {
            Row() {
              Column() {
                Text(contact.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium);
                Text(contact.phone)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ top: 4 });
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1);

              Image($r('app.media.ic_public_arrow_right'))
                .width(24)
                .height(24)
                .fillColor('#999999');
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .onClick(() => {
              this.selectedContact = contact;
              this.dialogController.open();
            })
          }
          .backgroundColor('#FFFFFF')
        }, (contact: Contact) => contact.phone)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .divider({
        strokeWidth: 0.5,
        color: '#E0E0E0',
        startMargin: 16,
        endMargin: 16
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}