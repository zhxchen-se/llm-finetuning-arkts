import {
  Align,
  Button,
  Column,
  FlexAlign,
  ForEach,
  FontWeight,
  HorizontalAlign,
  List,
  ListItem,
  Row,
  Stack,
  Text
} from '@kit.ArkUI';

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
    {
      id: 1,
      icon: '🔔',
      title: 'System Update',
      message: 'A new system update is available for your device.',
      timestamp: '2 min ago'
    },
    {
      id: 2,
      icon: '💬',
      title: 'New Message',
      message: 'You have received a new message from HarmonyOS Assistant.',
      timestamp: '15 min ago'
    },
    {
      id: 3,
      icon: '📅',
      title: 'Meeting Reminder',
      message: 'Team meeting starts in 30 minutes.',
      timestamp: '1 hour ago'
    },
    {
      id: 4,
      icon: '🛡️',
      title: 'Security Alert',
      message: 'Your device security scan was completed successfully.',
      timestamp: 'Yesterday'
    }
  ];

  build() {
    Column() {
      if (this.notifications.length > 0) {
        List({ space: 12 }) {
          ForEach(this.notifications, (item: NotificationItem) => {
            ListItem() {
              this.NotificationCard(item);
            }
            .width('100%');
          }, (item: NotificationItem) => item.id);
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 16 });
      } else {
        Column() {
          Text('No notifications')
            .fontSize(16)
            .fontColor('#8A8A8A');
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center);
      }

      Button('Clear All')
        .width('90%')
        .height(48)
        .margin({ bottom: 24 })
        .enabled(this.notifications.length > 0)
        .onClick(() => {
          this.notifications = [];
        });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA');
  }

  @Builder
  NotificationCard(item: NotificationItem) {
    Row() {
      Stack() {
        Text(item.icon)
          .fontSize(24)
          .fontColor('#1677FF');
      }
      .width(48)
      .height(48)
      .backgroundColor('#E8F0FE')
      .borderRadius(24)
      .alignContent(Align.Center);

      Column() {
        Row() {
          Text(item.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1B1B1F')
            .layoutWeight(1);

          Text(item.timestamp)
            .fontSize(12)
            .fontColor('#8A8A8A');
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Center);

        Text(item.message)
          .width('100%')
          .fontSize(14)
          .fontColor('#4D4D4D')
          .margin({ top: 6 });
      }
      .layoutWeight(1)
      .margin({ left: 12 });
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 8,
      color: '#0000000F',
      offsetX: 0,
      offsetY: 2
    });
  }
}