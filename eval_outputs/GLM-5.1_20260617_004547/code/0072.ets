import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private tabsController: TabsController = new TabsController()
  private tabTitles: string[] = ['Home', 'Discover', 'Messages', 'Profile']

  build() {
    Column() {
      // Custom Tab Bar
      Row() {
        ForEach(this.tabTitles, (title: string, index: number) => {
          Column() {
            Text(title)
              .fontSize(this.currentIndex === index ? 18 : 15)
              .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
              .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
              .animation({ duration: 250, curve: Curve.EaseInOut })

            // Active indicator line
            Row()
              .width(this.currentIndex === index ? 24 : 0)
              .height(3)
              .borderRadius(2)
              .backgroundColor('#007DFF')
              .margin({ top: 6 })
              .animation({ duration: 250, curve: Curve.EaseInOut })
          }
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .height(56)
          .onClick(() => {
            this.currentIndex = index
            this.tabsController.changeIndex(index)
          })
        }, (title: string) => title)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })

      // Tabs Content with swipe
      Tabs({ barPosition: BarPosition.Start, index: 0, controller: this.tabsController }) {
        TabContent() {
          this.HomeContent()
        }

        TabContent() {
          this.DiscoverContent()
        }

        TabContent() {
          this.MessagesContent()
        }

        TabContent() {
          this.ProfileContent()
        }
      }
      .scrollable(true)
      .barMode(BarMode.Fixed)
      .barWidth(0)
      .barHeight(0)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .animationDuration(300)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  HomeContent() {
    Scroll() {
      Column({ space: 16 }) {
        // Greeting Card
        Column() {
          Row() {
            Column() {
              Text('Good Morning!')
                .fontSize(14)
                .fontColor('#FFFFFFCC')
              Text('Welcome Back')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Text('☀️')
              .fontSize(40)
          }
          .width('100%')
          .padding(20)
        }
        .width('100%')
        .linearGradient({ angle: 135, colors: [['#4FACFE', 0], ['#00F2FE', 1]] })
        .borderRadius(16)
        .padding(16)

        // Quick Actions
        Text('Quick Actions')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 8 })

        Row() {
          this.ActionItem('📋', 'Tasks', '#E3F2FD')
          this.ActionItem('📅', 'Calendar', '#FFF3E0')
          this.ActionItem('📊', 'Stats', '#E8F5E9')
          this.ActionItem('⚙️', 'Settings', '#FCE4EC')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Recent Activity
        Text('Recent Activity')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 8 })

        ForEach(['Completed project review', 'Updated profile settings', 'Sent 3 messages', 'Added new contact'], (item: string, index: number) => {
          Row() {
            Row() {
              Text(`${index + 1}`)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007DFF')
            }
            .width(36)
            .height(36)
            .borderRadius(18)
            .backgroundColor('#E3F2FD')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Column() {
              Text(item)
                .fontSize(15)
                .fontColor('#333333')
              Text('2 hours ago')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })
            .layoutWeight(1)

            Text('›')
              .fontSize(20)
              .fontColor('#CCCCCC')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }, (item: string) => item)
      }
      .padding(16)
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  DiscoverContent() {
    Scroll() {
      Column({ space: 16 }) {
        // Search Bar
        Row() {
          Text('🔍')
            .fontSize(18)
            .margin({ left: 12 })
          TextInput({ placeholder: 'Search topics...' })
            .layoutWeight(1)
            .height(44)
            .backgroundColor(Color.Transparent)
            .border({ width: 0 })
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })

        // Categories
        Text('Categories')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')

        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          ForEach(['Technology', 'Design', 'Business', 'Health', 'Travel', 'Food', 'Music', 'Sports'], (tag: string) => {
            Text(tag)
              .fontSize(14)
              .fontColor('#007DFF')
              .backgroundColor('#E3F2FD')
              .borderRadius(20)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .margin({ right: 8, bottom: 8 })
          }, (tag: string) => tag)
        }

        // Featured Cards
        Text('Featured')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 8 })

        ForEach([
          { title: 'AI in 2025', desc: 'Exploring the future of artificial intelligence', color1: '#667EEA', color2: '#764BA2' },
          { title: 'Design Trends', desc: 'Modern UI patterns and best practices', color1: '#F093FB', color2: '#F5576C' },
          { title: 'Cloud Native', desc: 'Building scalable cloud applications', color1: '#4FACFE', color2: '#00F2FE' }
        ], (item: { title: string, desc: string, color1: string, color2: string }) => {
          Column() {
            Text(item.title)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            Text(item.desc)
              .fontSize(14)
              .fontColor('#FFFFFFCC')
              .margin({ top: 6 })
          }
          .width('100%')
          .padding(20)
          .linearGradient({ angle: 135, colors: [[item.color1, 0], [item.color2, 1]] })
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)
        }, (item: { title: string }) => item.title)
      }
      .padding(16)
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  MessagesContent() {
    Column() {
      // Header
      Row() {
        Text('Messages')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
        Blank()
        Text('✏️')
          .fontSize(22)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })

      // Message List
      List({ space: 0 }) {
        ForEach([
          { name: 'Alice Chen', msg: 'Hey! How are you doing?', time: '2m', unread: 3, avatar: '🟢' },
          { name: 'Bob Wang', msg: 'The meeting is at 3pm', time: '15m', unread: 1, avatar: '🔵' },
          { name: 'Carol Li', msg: 'Great work on the project!', time: '1h', unread: 0, avatar: '🟡' },
          { name: 'David Liu', msg: 'Can you review my PR?', time: '2h', unread: 0, avatar: '🟣' },
          { name: 'Emma Zhang', msg: 'Lunch tomorrow?', time: '3h', unread: 0, avatar: '🔴' },
          { name: 'Frank Wu', msg: 'Thanks for the help!', time: '5h', unread: 0, avatar: '🟠' },
          { name: 'Grace Yang', msg: 'See you at the event', time: '1d', unread: 0, avatar: '🟤' }
        ], (item: { name: string, msg: string, time: string, unread: number, avatar: string }) => {
          ListItem() {
            Row() {
              Row() {
                Text(item.avatar)
                  .fontSize(24)
              }
              .width(50)
              .height(50)
              .borderRadius(25)
              .backgroundColor('#F0F0F0')
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)

              Column() {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                Text(item.msg)
                  .fontSize(14)
                  .fontColor('#999999')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 12 })

              Column() {
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#BBBBBB')
                if (item.unread > 0) {
                  Row() {
                    Text(`${item.unread}`)
                      .fontSize(11)
                      .fontColor('#FFFFFF')
                      .fontWeight(FontWeight.Bold)
                  }
                  .width(20)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor('#FF3B30')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(VerticalAlign.Center)
                  .margin({ top: 6 })
                }
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          }
        }, (item: { name: string }) => item.name)
      }
      .layoutWeight(1)
      .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 78, endMargin: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  ProfileContent() {
    Scroll() {
      Column({ space: 16 }) {
        // Profile Header
        Column() {
          Row() {
            Text('👤')
              .fontSize(48)
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#E3F2FD')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Text('John Doe')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ top: 12 })

          Text('john.doe@example.com')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 4 })

          Row() {
            Column() {
              Text('128')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              Text('Posts')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 2 })
            }
            .layoutWeight(1)

            Column() {
              Text('2.4K')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              Text('Followers')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 2 })
            }
            .layoutWeight(1)

            Column() {
              Text('567')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              Text('Following')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 2 })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 20 })
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .alignItems(HorizontalAlign.Center)

        // Settings Items
        Text('Settings')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ top: 8 })

        Column() {
          this.SettingItem('🔔', 'Notifications', true)
          this.SettingItem('🔒', 'Privacy', false)
          this.SettingItem('🎨', 'Appearance', false)
          this.SettingItem('🌐', 'Language', false)
          this.SettingItem('💾', 'Storage', false)
          this.SettingItem('❓', 'Help & Support', false)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .divider({ strokeWidth: 0.5, color: '#F0F0F0' })
      }
      .padding(16)
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  ActionItem(icon: string, label: string, bgColor: string) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(24)
      }
      .width(52)
      .height(52)
      .borderRadius(16)
      .backgroundColor(bgColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(label)
        .fontSize(12)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  SettingItem(icon: string, label: string, hasToggle: boolean) {
    Row() {
      Text(icon)
        .fontSize(22)
        .margin({ right: 12 })

      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .layoutWeight(1)

      if (hasToggle) {
        Toggle({ type: ToggleType.Switch, isOn: true })
          .selectedColor('#007DFF')
          .width(48)
          .height(28)
      } else {
        Text('›')
          .fontSize(20)
          .fontColor('#CCCCCC')
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
  }
}