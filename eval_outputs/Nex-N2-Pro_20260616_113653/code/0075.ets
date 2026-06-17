import promptAction from '@ohos.promptAction';

interface Contact {
  id: number;
  name: string;
  phone: string;
  email: string;
  company: string;
  address: string;
  notes: string;
}

@Entry
@Component
struct Index {
  @State contacts: Contact[] = [
    {
      id: 1,
      name: 'Alice Johnson',
      phone: '+1 (555) 010-1001',
      email: 'alice.johnson@example.com',
      company: 'BlueWave Design',
      address: '120 Market Street, San Francisco, CA',
      notes: 'Prefers email for project updates.'
    },
    {
      id: 2,
      name: 'Michael Chen',
      phone: '+1 (555) 010-1002',
      email: 'michael.chen@example.com',
      company: 'NovaTech Labs',
      address: '88 Innovation Road, Austin, TX',
      notes: 'Available for calls after 3 PM.'
    },
    {
      id: 3,
      name: 'Sophia Martinez',
      phone: '+1 (555) 010-1003',
      email: 'sophia.martinez@example.com',
      company: 'GreenPath Consulting',
      address: '45 Garden Avenue, Denver, CO',
      notes: 'Interested in sustainability projects.'
    },
    {
      id: 4,
      name: 'Daniel Kim',
      phone: '+1 (555) 010-1004',
      email: 'daniel.kim@example.com',
      company: 'PixelWorks Studio',
      address: '300 Creative Lane, Seattle, WA',
      notes: 'Best contact for design reviews.'
    },
    {
      id: 5,
      name: 'Emily Davis',
      phone: '+1 (555) 010-1005',
      email: 'emily.davis@example.com',
      company: 'BrightStart Media',
      address: '77 Harbor View, Boston, MA',
      notes: 'Prefers short meetings.'
    },
    {
      id: 6,
      name: 'James Wilson',
      phone: '+1 (555) 010-1006',
      email: 'james.wilson@example.com',
      company: 'Summit Finance',
      address: '22 Finance Plaza, New York, NY',
      notes: 'Handles budget approvals.'
    }
  ];

  build() {
    Column() {
      Text('Contacts')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')
        .margin({ top: 24, bottom: 14, left: 16 })
        .alignSelf(ItemAlign.Start)

      List() {
        ForEach(this.contacts, (contact: Contact) => {
          ListItem() {
            Row() {
              Text(contact.name.charAt(0))
                .width(46)
                .height(46)
                .borderRadius(23)
                .backgroundColor('#007DFF')
                .fontColor('#FFFFFF')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
                .alignSelf(ItemAlign.Center)

              Column() {
                Text(contact.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#111827')

                Text(contact.phone)
                  .fontSize(15)
                  .fontColor('#6B7280')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .padding({ left: 14 })

              Text('›')
                .fontSize(28)
                .fontColor('#9CA3AF')
                .alignSelf(ItemAlign.Center)
            }
            .width('100%')
            .height(78)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .margin({ bottom: 10 })
            .onClick(() => {
              this.showContactDetails(contact);
            })
          }
        }, (contact: Contact) => contact.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 8, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }

  private showContactDetails(contact: Contact): void {
    promptAction.showAlert({
      title: contact.name,
      message: 'Phone: ' + contact.phone + '\n' +
        'Email: ' + contact.email + '\n' +
        'Company: ' + contact.company + '\n' +
        'Address: ' + contact.address + '\n' +
        'Notes: ' + contact.notes,
      buttons: [
        {
          text: 'Close',
          color: '#007DFF'
        }
      ]
    }).then((result) => {
      console.info('Contact dialog result: ' + JSON.stringify(result));
    });
  }
}