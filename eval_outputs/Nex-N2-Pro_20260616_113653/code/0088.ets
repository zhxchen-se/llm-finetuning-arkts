// If your SDK requires it, declare "ohos.permission.NOTIFICATION" in module.json5 user_grant permissions.
import notification from '@ohos.notification';
import businessError from '@ohos.base';

@Entry
@Component
struct Index {
  @State notificationId: number = 1;
  @State lastPublishedId: number = 0;
  @State subscribed: boolean = false;
  @State message: string = 'Ready. Tap "Publish notification" to send a notification.';

  onInit(): void {
    this.subscribeToNotificationChanges();
  }

  aboutToDisappear(): void {
    if (this.subscribed) {
      this.unsubscribeFromNotificationChanges();
    }
  }

  private subscribeToNotificationChanges(): void {
    if (this.subscribed) {
      return;
    }

    notification.subscribe((info: notification.NotificationSubscribeInfo) => {
      this.message = `Notification subscription changed\nBundle: ${info.bundleName}\nSlot type: ${info.slotType}`;
    });

    this.subscribed = true;
    this.message = 'Notification subscription enabled.';
  }

  private unsubscribeFromNotificationChanges(): void {
    if (!this.subscribed) {
      return;
    }

    notification.unsubscribe(() => {
      this.subscribed = false;
      this.message = 'Notification subscription disabled.';
    });
  }

  private publishNotification(): void {
    notification.addSlot(notification.SlotType.SOCIAL_COMMUNICATION, (err: businessError.BusinessError) => {
      if (err) {
        console.info(`Notification slot add failed: ${err.code}`);
      }

      this.doPublishNotification();
    });
  }

  private doPublishNotification(): void {
    const id: number = this.notificationId;

    const data = {
      id: id,
      content: {
        title: 'ArkTS Notification Example',
        text: 'This notification was published from an ArkTS page.',
        additionalText: 'Notification ID: ' + id,
        contentType: notification.ContentType.NOTIFICATION_CONTENT_TEXT
      },
      slotId: 1,
      isShowOnStatusBar: true,
      isShowOnBadge: true,
      isShowWhenDeviceLocked: true,
      isShowOnLockScreen: true,
      isKeepWhenDeviceLocked: true
    };

    this.message = 'Publishing notification...';

    notification.publish(data, (err: businessError.BusinessError) => {
      if (err) {
        this.message = `Publish failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.lastPublishedId = id;
      this.notificationId = id + 1;
      this.message = `Published notification successfully\nID: ${id}`;
    });
  }

  private cancelLastNotification(): void {
    if (this.lastPublishedId <= 0) {
      this.message = 'No notification has been published yet.';
      return;
    }

    const id: number = this.lastPublishedId;

    notification.cancel(id, (err: businessError.BusinessError) => {
      if (err) {
        this.message = `Cancel failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.lastPublishedId = 0;
      this.message = `Cancelled notification\nID: ${id}`;
    });
  }

  private cancelAllNotifications(): void {
    notification.cancelAll((err: businessError.BusinessError) => {
      if (err) {
        this.message = `Cancel all failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.lastPublishedId = 0;
      this.message = 'All notifications from this app were cancelled.';
    });
  }

  private addSlot(): void {
    notification.addSlot(notification.SlotType.SOCIAL_COMMUNICATION, (err: businessError.BusinessError) => {
      if (err) {
        this.message = `Add slot failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.message = 'Notification slot added successfully.';
    });
  }

  private removeSlot(): void {
    notification.removeSlot(notification.SlotType.SOCIAL_COMMUNICATION, (err: businessError.BusinessError) => {
      if (err) {
        this.message = `Remove slot failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.message = 'Notification slot removed successfully.';
    });
  }

  private getSlotInfo(): void {
    notification.getSlotNum((err: businessError.BusinessError, slotNum: number) => {
      if (err) {
        this.message = `Get slot count failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      this.message = `Enabled slot count: ${slotNum}`;
    });
  }

  private getSlotTypes(): void {
    notification.getSlotTypes((err: businessError.BusinessError, slotTypes: Array<number>) => {
      if (err) {
        this.message = `Get slot types failed\nCode: ${err.code}\nMessage: ${err.message}`;
        return;
      }

      const text: string = slotTypes.length > 0 ? slotTypes.join(', ') : 'none';
      this.message = `Enabled slot types: ${text}`;
    });
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Notification Example')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Text('ArkTS @ohos.notification demo')
          .fontSize(14)
          .fontColor('#666666')

        Column() {
          Text('Status')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Text(this.message)
            .width('100%')
            .maxLines(0)
            .fontSize(14)
            .lineHeight(22)
            .fontColor('#333333')

          Text(`Subscription: ${this.subscribed ? 'enabled' : 'disabled'}`)
            .fontSize(13)
            .fontColor(this.subscribed ? '#0A8F08' : '#999999')

          Text(`Next notification ID: ${this.notificationId}`)
            .fontSize(13)
            .fontColor('#666666')

          Text(`Last published ID: ${this.lastPublishedId}`)
            .fontSize(13)
            .fontColor('#666666')
        }
        .width('100%')
        .minHeight(130)
        .padding(14)
        .backgroundColor('#F5F7FA')
        .borderRadius(12)

        Button('Publish notification')
          .width('100%')
          .height(48)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .fontSize(15)
          .stateEffect(true)
          .onClick(() => this.publishNotification())

        Button('Cancel last notification')
          .width('100%')
          .height(48)
          .backgroundColor('#E8F0FE')
          .fontColor('#005CBE')
          .fontSize(15)
          .disabled(this.lastPublishedId <= 0)
          .stateEffect(true)
          .onClick(() => this.cancelLastNotification())

        Button('Cancel all notifications')
          .width('100%')
          .height(48)
          .backgroundColor('#E8F0FE')
          .fontColor('#005CBE')
          .fontSize(15)
          .stateEffect(true)
          .onClick(() => this.cancelAllNotifications())

        Divider()
          .width('100%')
          .strokeWidth(1)
          .color('#DDDDDD')

        Text('Subscription management')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Row({ space: 8 }) {
          Button('Subscribe')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .disabled(this.subscribed)
            .stateEffect(true)
            .onClick(() => this.subscribeToNotificationChanges())

          Button('Unsubscribe')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .disabled(!this.subscribed)
            .stateEffect(true)
            .onClick(() => this.unsubscribeFromNotificationChanges())
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text('Slot management')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Row({ space: 8 }) {
          Button('Add slot')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .stateEffect(true)
            .onClick(() => this.addSlot())

          Button('Remove slot')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .stateEffect(true)
            .onClick(() => this.removeSlot())
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row({ space: 8 }) {
          Button('Get slot info')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .stateEffect(true)
            .onClick(() => this.getSlotInfo())

          Button('Get slot types')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .fontColor('#007DFF')
            .stateEffect(true)
            .onClick(() => this.getSlotTypes())
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text('If publishing fails, grant notification permission for this app in system settings.')
          .width('100%')
          .fontSize(12)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}