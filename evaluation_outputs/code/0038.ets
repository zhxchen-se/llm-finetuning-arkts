import { router } from '@kit.ArkUI';

interface NotificationItem {
  icon: string; // using emoji as icon
  title: string;
  message: string;
  timestamp: string;
}

@Entry
@Component
struct Index {
  @State notifications: NotificationItem[] = [
    {
      icon: '🔔',
      title: 'New Message',
      message: 'You have a new message from Alice.',
      timestamp: '10:30 AM'
    },
    {
      icon: '📅',
      title: 'Meeting Reminder',
      message: 'Team standup at 11:00 AM.',
      timestamp: '9:45 AM'
    },
    {
      icon: '📦',
      title: 'Order Shipped',
      message: 'Your order #12345 has been shipped.',
      timestamp: 'Yesterday'
    },
    {
      icon: '⚠️',
      title: 'System Update',
      message: 'A new system update is available.',
      timestamp: '2 days ago'
    }
  ];

  build() {
    Column() {
      List({ space: 8 }) {
        ForEach(this.notifications, (item: NotificationItem, index: number) => {
          ListItem() {
            Row() {
              // Icon
              Text(item.icon)
                .fontSize(28)
                .margin({ right: 12 })

              // Title and message
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(item.message)
                  .fontSize(14)
                  .fontColor('#666666')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Timestamp
              Text(item.timestamp)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ left: 8 })
            }
            .width('100%')
            .padding(12)
            .alignItems(VerticalAlign.Center)
          }
          .borderRadius(8)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
        }, (item: NotificationItem, index: number) => index.toString())
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16 })
      .backgroundColor('#F5F5F5')

      // Clear All button
      Button('Clear All')
        .width('90%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#FF4444')
        .borderRadius(24)
        .margin({ bottom: 24, top: 12 })
        .onClick(() => {
          this.notifications = [];
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}