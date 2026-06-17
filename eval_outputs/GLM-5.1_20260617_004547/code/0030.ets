interface Contact {
  id: number;
  name: string;
  phone: string;
}

@Entry
@Component
struct Index {
  @State searchQuery: string = '';
  private contacts: Contact[] = [
    { id: 1, name: 'Alice Smith', phone: '555-0101' },
    { id: 2, name: 'Bob Johnson', phone: '555-0102' },
    { id: 3, name: 'Charlie Brown', phone: '555-0103' },
    { id: 4, name: 'Diana Prince', phone: '555-0104' },
    { id: 5, name: 'Evan Wright', phone: '555-0105' },
    { id: 6, name: 'Fiona Gallagher', phone: '555-0106' },
    { id: 7, name: 'George Costanza', phone: '555-0107' },
    { id: 8, name: 'Hannah Baker', phone: '555-0108' },
    { id: 9, name: 'Ian Malcolm', phone: '555-0109' },
    { id: 10, name: 'Julia Roberts', phone: '555-0110' }
  ];

  private getAvatarColor(name: string): string {
    const colors: string[] = ['#FF5722', '#4CAF50', '#2196F3', '#9C27B0', '#FF9800', '#00BCD4', '#E91E63', '#3F51B5'];
    let hash = 0;
    for (let i = 0; i < name.length; i++) {
      hash = name.charCodeAt(i) + ((hash << 5) - hash);
    }
    return colors[Math.abs(hash) % colors.length];
  }

  build() {
    Column() {
      Text('Contacts')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 15 })
        .width('90%')
        .textAlign(TextAlign.Start)

      Search({ placeholder: 'Search name or number...', controller: new SearchController() })
        .value(this.searchQuery)
        .width('90%')
        .height(50)
        .margin({ bottom: 20 })
        .backgroundColor('#FFFFFF')
        .borderRadius(25)
        .onChange((value: string) => {
          this.searchQuery = value;
        })

      if (this.contacts.filter(contact => 
          contact.name.toLowerCase().includes(this.searchQuery.toLowerCase()) || 
          contact.phone.includes(this.searchQuery)).length === 0) {
        Column() {
          Text('No contacts found')
            .fontSize(18)
            .fontColor('#888888')
            .margin({ top: 50 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
      } else {
        List({ space: 15 }) {
          ForEach(
            this.contacts.filter(contact => 
              contact.name.toLowerCase().includes(this.searchQuery.toLowerCase()) || 
              contact.phone.includes(this.searchQuery)
            ),
            (contact: Contact) => {
              ListItem() {
                Row() {
                  Stack() {
                    Circle()
                      .width(55)
                      .height(55)
                      .fill(this.getAvatarColor(contact.name))
                    Text(contact.name.charAt(0).toUpperCase())
                      .fontSize(26)
                      .fontColor(Color.White)
                      .fontWeight(FontWeight.Bold)
                  }
                  .margin({ right: 20 })

                  Column() {
                    Text(contact.name)
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#333333')
                    Text(contact.phone)
                      .fontSize(16)
                      .fontColor('#777777')
                      .margin({ top: 6 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)
                }
                .width('100%')
                .padding({ left: 20, right: 20, top: 15, bottom: 15 })
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 3, color: '#1a000000', offsetY: 2 })
              }
            },
            (contact: Contact) => contact.id.toString()
          )
        }
        .width('90%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}