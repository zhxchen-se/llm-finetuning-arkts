interface NotificationItem {
  id: number;
  icon: string;
  title: string;
  message: string;
  timestamp: string;
}

@Entry
@Component
struct Index {
  @State notifications: NotificationItem[] = [
    { id: 1, icon: '📩', title: 'New Message', message: 'You have received a new message from John Doe.', timestamp: '2m ago' },
    { id: 2, icon: '🔔', title: 'System Update', message: 'A new system update is available for download.', timestamp: '15m ago' },
    { id: 3, icon: '👍', title: 'New Like', message: 'Jane Smith liked your recent post.', timestamp: '1h ago' },
    { id: 4, icon: '📅', title: 'Reminder', message: 'Meeting with the team starts in 30 minutes.', timestamp: '2h ago' },
    { id: 5, icon: '🛒', title: 'Order Shipped', message: 'Your order #12345 has been shipped and is on the way.', timestamp: '1d ago' },
    { id: 6, icon: '🎉', title: 'Promotion', message: 'Get 20% off on your next purchase. Limited time offer!', timestamp: '2d ago' }
  ];

  build() {
    Column() {
      // Header
      Row() {
        Text('Notifications')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Blank()
        if (this.notifications.length > 0) {
          Text(`${this.notifications.length} new`)
            .fontSize(16)
            .fontColor('#888888')
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })

      // Notification List
      List({ space: 10 }) {
        ForEach(this.notifications, (item: NotificationItem) => {
          ListItem() {
            Row() {
              Text(item.icon)
                .fontSize(28)
                .margin({ right: 16 })

              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Text(item.message)
                  .fontSize(14)
                  .fontColor('#666666')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text(item.timestamp)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ left: 8 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
          }
          .padding({ left: 16, right: 16 })
        }, (item: NotificationItem) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .margin({ top: 4 })

      // Empty State
      if (this.notifications.length === 0) {
        Column() {
          Text('📭')
            .fontSize(48)
            .margin({ bottom: 16 })
          Text('No Notifications')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
          Text('You're all caught up!')
            .fontSize(14)
            .fontColor('#888888')
            .margin({ top: 8 })
        }
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .width('100%')
      }

      // Clear All Button
      Button('Clear All')
        .width('90%')
        .height(48)
        .fontSize(18)
        .fontColor(Color.White)
        .backgroundColor('#FF007DFF')
        .borderRadius(24)
        .margin({ top: 16, bottom: 32 })
        .enabled(this.notifications.length > 0)
        .opacity(this.notifications.length > 0 ? 1.0 : 0.4)
        .onClick(() => {
          this.notifications = [];
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}