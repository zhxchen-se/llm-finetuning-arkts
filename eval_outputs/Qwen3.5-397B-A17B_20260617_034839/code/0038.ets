@Entry
@Component
struct Index {
  @State notifications: NotificationItem[] = [
    { id: 1, title: 'System Update', message: 'A new version is available for download.', timestamp: '10:30 AM' },
    { id: 2, title: 'New Message', message: 'You have received a message from John Doe.', timestamp: '09:15 AM' },
    { id: 3, title: 'Calendar Reminder', message: 'Meeting with team in 30 minutes.', timestamp: '08:45 AM' },
    { id: 4, title: 'Security Alert', message: 'Unusual login attempt detected.', timestamp: 'Yesterday' },
  ]

  build() {
    Column() {
      List() {
        ForEach(this.notifications, (item: NotificationItem) => {
          ListItem() {
            Row() {
              Text('🔔')
                .fontSize(24)
                .width(50)
                .height(50)
                .textAlign(TextAlign.Center)
                .backgroundColor('#F0F0F0')
                .borderRadius(25)
                .margin({ right: 12 })

              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .width('100%')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text(item.message)
                  .fontSize(14)
                  .fontColor('#666666')
                  .width('100%')
                  .margin({ top: 4 })
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text(item.timestamp)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ left: 8 })
            }
            .width('100%')
            .padding(12)
            .alignItems(VerticalAlign.Top)
          }
          .width('100%')
        }, (item: NotificationItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: '#EEEEEE', startMargin: 62, endMargin: 10 })

      Button('Clear All')
        .width('90%')
        .height(50)
        .margin({ top: 10, bottom: 20 })
        .backgroundColor('#007DFF')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .onClick(() => {
          this.notifications = []
        })
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
  }
}

interface NotificationItem {
  id: number
  title: string
  message: string
  timestamp: string
}