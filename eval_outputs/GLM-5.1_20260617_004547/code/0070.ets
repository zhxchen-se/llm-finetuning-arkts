@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State indicatorOffset: number = 0
  @State tabScales: number[] = [0.85, 1.05, 1.05, 1.05]
  @State tabBarWidth: number = 0

  private tabs: string[] = ['Home', 'Discover', 'Messages', 'Profile']
  private accentColors: string[] = ['#FF6B35', '#4A90D9', '#50C878', '#9B59B6']
  private swiperController: SwiperController = new SwiperController()
  private indicatorWidth: number = 22

  switchTab(index: number) {
    if (this.currentIndex === index) return
    this.currentIndex = index
    this.recalculate()
    this.swiperController.changeIndex(index, true)
  }

  recalculate() {
    if (this.tabBarWidth <= 0) return
    const tabWidth = this.tabBarWidth / this.tabs.length
    this.indicatorOffset = this.currentIndex * tabWidth + tabWidth / 2 - this.indicatorWidth / 2
    this.tabScales = this.tabs.map((_: string, i: number) => i === this.currentIndex ? 0.85 : 1.05)
  }

  @Builder
  StatItem(value: string, label: string, color: string) {
    Column() {
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
      Text(label)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .borderRadius(12)
    .backgroundColor('#F8F8FA')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ListRow(text: string, dotColor: string, showArrow: boolean) {
    Row() {
      Row().width(6).height(6).borderRadius(3).backgroundColor(dotColor)
      Text(text).fontSize(14).fontColor('#555555').margin({ left: 12 }).layoutWeight(1)
      if (showArrow) {
        Text('›').fontSize(16).fontColor('#CCCCCC')
      }
    }
    .width('100%')
    .height(48)
    .padding({ left: 4, right: 4 })
  }

  @Builder
  SectionCard(title: string, content: () => void) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#222222')
        .margin({ bottom: 8 })
      content()
    }
    .width('92%')
    .padding(20)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })
  }

  build() {
    Column() {
      // Tab bar
      Stack({ alignContent: Alignment.BottomStart }) {
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Column() {
              Text(tab)
                .fontSize(16)
                .fontColor(this.currentIndex === index ? '#222222' : '#AAAAAA')
                .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .scale({ x: this.tabScales[index], y: this.tabScales[index] })
                .animation({ duration: 350, curve: Curve.FastOutSlowIn })
            }
            .layoutWeight(1)
            .height(50)
            .justifyContent(FlexAlign.Center)
            .onClick(() => this.switchTab(index))
          }, (tab: string, index: number) => `${index}`)
        }
        .width('100%')

        // Sliding indicator line
        Row()
          .width(this.indicatorWidth)
          .height(3)
          .borderRadius(1.5)
          .backgroundColor(this.accentColors[this.currentIndex])
          .translate({ x: this.indicatorOffset })
          .animation({ duration: 350, curve: Curve.FastOutSlowIn })
      }
      .width('100%')
      .height(54)
      .backgroundColor(Color.White)
      .shadow({ radius: 4, color: 0x0d000000, offsetY: 2 })
      .onAreaChange((_oldValue: Area, newValue: Area) => {
        this.tabBarWidth = newValue.width as number
        this.recalculate()
      })

      // Swiper content
      Swiper(this.swiperController) {
        // Home
        Scroll() {
          Column({ space: 16 }) {
            Column() {
              Text('Good Morning')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
              Text('Welcome back! Here\'s your overview.')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 6 })
            }
            .width('92%')
            .padding(24)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              Text('Quick Stats')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
                .margin({ bottom: 12 })
              Row({ space: 12 }) {
                this.StatItem('12', 'Tasks', '#FF6B35')
                this.StatItem('5', 'Events', '#4A90D9')
                this.StatItem('3', 'Alerts', '#50C878')
              }
            }
            .width('92%')
            .padding(20)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
                .margin({ bottom: 4 })
              this.ListRow('Completed project review', '#FF6B35', false)
              this.ListRow('Updated profile settings', '#FF6B35', false)
              this.ListRow('Sent 3 messages', '#FF6B35', false)
            }
            .width('92%')
            .padding(20)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })
          }
          .width('100%')
          .padding({ top: 20, bottom: 30 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')
        .scrollBar(BarState.Off)

        // Discover
        Scroll() {
          Column({ space: 16 }) {
            Column() {
              Text('Discover')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
              Text('Find something new today.')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 6 })
            }
            .width('92%')
            .padding(24)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              Text('Trending Topics')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
                .margin({ bottom: 4 })
              this.ListRow('Technology', '#4A90D9', true)
              this.ListRow('Design Inspiration', '#4A90D9', true)
              this.ListRow('Productivity Tips', '#4A90D9', true)
              this.ListRow('Health & Wellness', '#4A90D9', true)
            }
            .width('92%')
            .padding(20)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              Text('Recommended')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
                .margin({ bottom: 4 })
              this.ListRow('Nearby Places', '#4A90D9', true)
              this.ListRow('Popular Categories', '#4A90D9', true)
            }
            .width('92%')
            .padding(20)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })
          }
          .width('100%')
          .padding({ top: 20, bottom: 30 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')
        .scrollBar(BarState.Off)

        // Messages
        Scroll() {
          Column({ space: 16 }) {
            Column() {
              Text('Messages')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#222222')
              Text('Stay connected with friends.')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 6 })
            }
            .width('92%')
            .padding(24)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              ForEach(['Alice: Hey there!', 'Team: Sprint update', 'Bob: Meeting at 3pm', 'System: Security alert'], (item: string, idx: number) => {
                Row() {
                  Row()
                    .width(40)
                    .height(40)
                    .borderRadius(20)
                    .backgroundColor('#50C878')
                    .opacity(0.2)
                  Column() {
                    Text(item.split(':')[0])
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#222222')
                    Text(item.substring(item.indexOf(':') + 1))
                      .fontSize(12)
                      .fontColor('#888888')
                      .margin({ top: 2 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 12 })
                  .layoutWeight(1)
                  Text('Just now')
                    .fontSize(11)
                    .fontColor('#BBBBBB')
                }
                .width('100%')
                .height(60)
                .padding({ left: 8, right: 8 })
              }, (item: string, idx: number) => `${idx}`)
            }
            .width('92%')
            .padding(16)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })
          }
          .width('100%')
          .padding({ top: 20, bottom: 30 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')
        .scrollBar(BarState.Off)

        // Profile
        Scroll() {
          Column({ space: 16 }) {
            Column() {
              Row() {
                Row()
                  .width(60)
                  .height(60)
                  .borderRadius(30)
                  .backgroundColor('#9B59B6')
                  .opacity(0.25)
                Column() {
                  Text('John Doe')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#222222')
                  Text('john@example.com')
                    .fontSize(13)
                    .fontColor('#888888')
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 })
                .layoutWeight(1)
              }
            }
            .width('92%')
            .padding(24)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              ForEach(['Edit Profile', 'Privacy Settings', 'App Preferences', 'Notifications', 'About & Help'], (item: string, idx: number) => {
                Row() {
                  Text(item)
                    .fontSize(15)
                    .fontColor('#444444')
                    .layoutWeight(1)
                  Text('›')
                    .fontSize(18)
                    .fontColor('#CCCCCC')
                }
                .width('100%')
                .height(52)
                .padding({ left: 16, right: 16 })
              }, (item: string, idx: number) => `${idx}`)
            }
            .width('92%')
            .padding({ top: 8, bottom: 8 })
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })

            Column() {
              Text('Member Since')
                .fontSize(13)
                .fontColor('#AAAAAA')
              Text('January 2024')
                .fontSize(15)
                .fontColor('#555555')
                .margin({ top: 4 })
            }
            .width('92%')
            .padding(20)
            .borderRadius(16)
            .backgroundColor(Color.White)
            .shadow({ radius: 8, color: 0x0a000000, offsetY: 2 })
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .padding({ top: 20, bottom: 30 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')
        .scrollBar(BarState.Off)
      }
      .index(0)
      .indicator(false)
      .loop(false)
      .onChange((index: number) => {
        this.switchTab(index)
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}