import notificationManager from '@ohos.notificationManager';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct Index {
  @State message: string = 'Click the button to send a notification.';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 20 })
          .width('80%')

        Button('Send Notification')
          .width('60%')
          .height(50)
          .fontSize(18)
          .onClick(() => {
            this.requestAndSendNotification();
          })
      }
      .width('100%')
    }
    .height('100%')
  }

  private requestAndSendNotification() {
    notificationManager.isNotificationEnabled().then((isEnabled: boolean) => {
      if (isEnabled) {
        this.sendNotification();
      } else {
        notificationManager.requestEnableNotification().then(() => {
          this.sendNotification();
        }).catch((err: BusinessError) => {
          console.error(`RequestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
          this.message = 'Notification permission denied.';
        });
      }
    }).catch((err: BusinessError) => {
      console.error(`IsNotificationEnabled failed, code is ${err.code}, message is ${err.message}`);
    });
  }

  private sendNotification() {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 1,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: 'HarmonyOS Notification',
          text: 'This is a basic text notification from ArkTS!'
        }
      }
    };

    notificationManager.publish(notificationRequest).then(() => {
      this.message = 'Notification sent successfully!';
      console.info('Succeeded in publishing notification');
    }).catch((err: BusinessError) => {
      this.message = 'Failed to send notification.';
      console.error(`Failed to publish notification, code is ${err.code}, message is ${err.message}`);
    });
  }
}