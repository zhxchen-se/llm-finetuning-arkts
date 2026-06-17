import notification from '@ohos.notification';
import { common } from '@ohos.app.ability.common';

@Entry
@Component
struct Index {
  @State message: string = 'Click to send notification';
  @State notificationStatus: string = 'Status: Unknown';

  aboutToAppear() {
    this.checkNotificationStatus();
  }

  async checkNotificationStatus() {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let isAllowed = await notification.isNotificationEnabled(context);
      this.notificationStatus = isAllowed ? 'Status: Enabled' : 'Status: Disabled';
    } catch (err) {
      console.error('Failed to check notification status. Code: ' + JSON.stringify(err) + ', message: ' + err.message);
      this.notificationStatus = 'Status: Check Failed';
    }
  }

  async sendNotification() {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      
      // Check if notification is enabled, if not, request permission
      let isAllowed = await notification.isNotificationEnabled(context);
      if (!isAllowed) {
        await notification.requestEnableNotification(context);
        this.notificationStatus = 'Status: Enabled';
      }

      // Define notification content
      let notificationContent: notification.NotificationContent = {
        title: 'HarmonyOS Notification',
        text: 'This is a test notification message.',
        subText: 'Sub text example'
      };

      // Define notification request
      let notificationRequest: notification.NotificationRequest = {
        id: 1001,
        content: notificationContent,
        channelId: '01'
      };

      // Publish notification
      await notification.publish(context, notificationRequest);
      this.message = 'Notification Sent!';
    } catch (err) {
      console.error('Failed to publish notification. Code: ' + JSON.stringify(err) + ', message: ' + err.message);
      this.message = 'Failed to send notification';
    }
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Text(this.notificationStatus)
        .fontSize(16)
        .fontColor('#666666')
        .margin({ bottom: 40 })

      Button('Send Notification')
        .onClick(() => {
          this.sendNotification();
        })
        .width('80%')
        .height(50)
        .backgroundColor('#007DFF')
        .borderRadius(25)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}