@Entry
@Component
struct Index {
  @State searchText: string = ''

  contacts: Contact[] = [
    {
      id: 1,
      name: 'Alice Johnson',
      phone: '+1 (555) 010-1001',
      initials: 'AJ',
      avatarColor: '#E3F2FD'
    },
    {
      id: 2,
      name: 'Benjamin Carter',
      phone: '+1 (555) 010-1002',
      initials: 'BC',
      avatarColor: '#E8F5E9'
    },
    {
      id: 3,
      name: 'Caroline Lee',
      phone: '+1 (555) 010-1003',
      initials: 'CL',
      avatarColor: '#FFF3E0'
    },
    {
      id: 4,
      name: 'Daniel Kim',
      phone: '+1 (555) 010-1004',
      initials: 'DK',
      avatarColor: '#F3E5F5'
    },
    {
      id: 5,
      name: 'Emma Davis',
      phone: '+1 (555) 010-1005',
      initials: 'ED',
      avatarColor: '#E0F7FA'
    },
    {
      id: 6,
      name: 'Frank Wilson',
      phone: '+1 (555) 010-1006',
      initials: 'FW',
      avatarColor: '#FCE4EC'
    },
    {
      id: 7,
      name: 'Grace Chen',
      phone: '+1 (555) 010-1007',
      initials: 'GC',
      avatarColor: '#F1F8E9'
    },
    {
      id: 8,
      name: 'Henry Brown',
      phone: '+1 (555) 010-1008',
      initials: 'HB',
      avatarColor: '#FFF8E1'
    }
  ]

  get filteredContacts(): Contact[] {
    const keyword: string = this.searchText.trim().toLowerCase()

    if (keyword.length === 0) {
      return this.contacts
    }

    return this.contacts.filter((item: Contact): boolean => {
      return (
        item.name.toLowerCase().includes(keyword) ||
        item.phone.toLowerCase().includes(keyword)
      )
    })
  }

  build() {
    Column() {
      Search({
        placeholder: 'Search contacts',
        text: this.searchText
      })
        .onChange((value: string) => {
          this.searchText = value
        })
        .width('100%')
        .height(44)
        .borderRadius(14)
        .backgroundColor(Color.White)
        .margin({ bottom: 14 })

      if (this.filteredContacts.length > 0) {
        List({ space: 12 }) {
          ForEach(this.filteredContacts, (item: Contact) => {
            ListItem() {
              Row() {
                Stack() {
                  Circle()
                    .width(48)
                    .height(48)
                    .fill(item.avatarColor)

                  Text(item.initials)
                    .fontColor(Color.White)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                }
                  .width(48)
                  .height(48)

                Column() {
                  Text(item.name)
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111827')

                  Text(item.phone)
                    .fontSize(14)
                    .fontColor('#6B7280')
                    .margin({ top: 4 })
                }
                  .layoutWeight(1)
                  .padding({ left: 14 })
              }
                .width('100%')
                .alignItems(VerticalAlign.Center)
            }
              .width('100%')
              .padding({ left: 16, right: 16, top: 10, bottom: 10 })
              .borderRadius(16)
              .backgroundColor(Color.White)
          }, (item: Contact) => item.id)
        }
          .width('100%')
          .layoutWeight(1)
      } else {
        Column() {
          Text('No contacts found')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#374151')

          Text('Try searching by name or phone number.')
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 8 })
        }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
      }
    }
      .width('100%')
      .height('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#F6F7FB')
  }
}

interface Contact {
  id: number
  name: string
  phone: string
  initials: string
  avatarColor: string
}