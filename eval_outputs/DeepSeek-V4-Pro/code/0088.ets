import { notificationManager } from '@ohos.notification';
import { wantAgent, WantAgentInfo, WantAgent } from '@ohos.wantAgent';
import { common } from '@ohos.app.ability.common';

@Entry
@Component
struct Index {
  @State message: string = 'Notification Example';

  build() {
    Column() {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Button('Send Notification')
        .fontSize(20)
        .onClick(() => {
          this.publishNotification();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  async publishNotification() {
    try {
      // Obtain the UIAbilityContext
      let context = getContext(this) as common.UIAbilityContext;

      // Configure WantAgentInfo to open the current ability when notification is tapped
      let wantAgentInfo: WantAgentInfo = {
        wants: [
          {
            bundleName: context.abilityInfo.bundleName,
            abilityName: context.abilityInfo.name,
          }
        ],
        operationType: wantAgent.OperationType.START_ABILITY,
        requestCode: 0,
        wantAgentFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
      };

      // Obtain WantAgent instance
      let agent: WantAgent = await wantAgent.getWantAgent(wantAgentInfo);

      // Build notification request
      let notificationRequest: notificationManager.NotificationRequest = {
        content: {
          contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: 'Test Notification',
            text: 'This is a sample notification from ArkTS.',
          }
        },
        id: 1, // notification ID
        slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION,
        wantAgent: agent,
        deliveryTime: new Date().getTime(),
        showDeliveryTime: true,
      };

      // Publish the notification
      await notificationManager.publish(notificationRequest);
      this.message = 'Notification sent successfully';
    } catch (err) {
      console.error(`Failed to publish notification. Code: ${err.code}, message: ${err.message}`);
      this.message = `Error: ${err.message}`;
    }
  }
}