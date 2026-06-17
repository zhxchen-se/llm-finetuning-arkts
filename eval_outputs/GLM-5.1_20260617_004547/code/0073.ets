interface TabInfo {
  title: string
  color: string
  icon: string
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController()

  private tabs: TabInfo[] = [
    { title: 'Home', color: '#4F46E5', icon: '▲' },
    { title: 'Explore', color: '#0891B2', icon: '◆' },
    { title: 'Favorites', color: '#E11D48', icon: '♥' },
    { title: 'Profile', color: '#7C3AED', icon: '●' }
  ]

  build() {
    Column() {
      Swiper(this.swiperController) {
        this.HomePage()
        this.ExplorePage()
        this.FavoritesPage()
        this.ProfilePage()
      }
      .index(0)
      .indicator(false)
      .loop(false)
      .duration(350)
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .layoutWeight(1)

      this.CapsuleTabBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  CapsuleTabBar() {
    Row() {
      ForEach(this.tabs, (tab: TabInfo, index?: number) => {
        Column() {
          Text(tab.icon)
            .fontSize(18)
            .fontColor(this.currentIndex === index ? '#FFFFFF' : '#6B7280')
          Text(tab.title)
            .fontSize(10)
            .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentIndex === index ? '#FFFFFF' : '#6B7280')
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .height(50)
        .borderRadius(25)
        .backgroundColor(this.currentIndex === index ? tab.color : Color.Transparent)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.currentIndex = index as number
          this.swiperController.changeIndex(index as number)
        })
        .animation({ duration: 300, curve: Curve.EaseInOut })
      }, (tab: TabInfo, index?: number) => (index ?? 0).toString())
    }
    .width('90%')
    .height(64)
    .borderRadius(32)
    .backgroundColor('#E5E7EB')
    .margin({ bottom: 28 })
    .padding({ left: 4, right: 4 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .shadow({ radius: 10, color: '#1E293B12', offsetY: 4 })
  }

  @Builder
  StatCard(emoji: string, title: string, value: string) {
    Column() {
      Text(emoji)
        .fontSize(28)
        .margin({ bottom: 8 })
      Text(title)
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
      Text(value)
        .fontSize(11)
        .fontColor('#64748B')
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityItem(title: string, time: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
        Text(time)
          .fontSize(11)
          .fontColor('#94A3B8')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Text('✓')
        .fontSize(16)
        .fontColor('#4F46E5')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
  }

  @Builder
  CategoryCard(emoji: string, title: string, count: string, bgColor: string) {
    Column() {
      Text(emoji)
        .fontSize(32)
        .margin({ bottom: 8 })
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
      Text(count)
        .fontSize(11)
        .fontColor('#64748B')
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  FavoriteItem(emoji: string, title: string, subtitle: string) {
    Row() {
      Text(emoji)
        .fontSize(32)
        .margin({ right: 16 })
      Column() {
        Text(title)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
        Text(subtitle)
          .fontSize(12)
          .fontColor('#94A3B8')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Text('♥')
        .fontSize(18)
        .fontColor('#E11D48')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .margin({ bottom: 12 })
  }

  @Builder
  SettingRow(title: string, isDestructive: boolean) {
    Row() {
      Text(title)
        .fontSize(15)
        .fontColor(isDestructive ? '#E11D48' : '#1E293B')
        .layoutWeight(1)
      Text('›')
        .fontSize(18)
        .fontColor('#CBD5E1')
    }
    .width('100%')
    .padding({ top: 14, bottom: 14 })
    .borderWidth({ bottom: isDestructive ? 0 : 0.5 })
    .borderColor('#F1F5F9')
  }

  @Builder
  HomePage() {
    Scroll() {
      Column() {
        Column() {
          Text('Good Morning!')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          Text("Here's your daily summary")
            .fontSize(14)
            .fontColor('#94A3B8')
            .margin({ top: 4 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 60, bottom: 24 })

        Grid() {
          GridItem() {
            this.StatCard('🏃', 'Steps', '8,432')
          }
          GridItem() {
            this.StatCard('🔥', 'Calories', '1,280 kcal')
          }
          GridItem() {
            this.StatCard('😴', 'Sleep', '7h 23m')
          }
          GridItem() {
            this.StatCard('❤️', 'Heart Rate', '72 bpm')
          }
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')

        Text('Recent Activity')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ top: 28, bottom: 12 })
          .width('100%')

        this.ActivityItem('Morning jog completed', '1h ago')
        this.ActivityItem('Lunch logged', '3h ago')
        this.ActivityItem('Afternoon meditation', '5h ago')
      }
      .width('85%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  ExplorePage() {
    Scroll() {
      Column() {
        Column() {
          Text('Explore')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          Text('Discover new categories')
            .fontSize(14)
            .fontColor('#94A3B8')
            .margin({ top: 4 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 60, bottom: 24 })

        Grid() {
          GridItem() {
            this.CategoryCard('🌿', 'Nature', '24 items', '#ECFDF5')
          }
          GridItem() {
            this.CategoryCard('🏛', 'Architecture', '18 items', '#FEF3C7')
          }
          GridItem() {
            this.CategoryCard('🍕', 'Food', '32 items', '#FEE2E2')
          }
          GridItem() {
            this.CategoryCard('✈', 'Travel', '15 items', '#E0E7FF')
          }
          GridItem() {
            this.CategoryCard('🎵', 'Music', '28 items', '#F3E8FF')
          }
          GridItem() {
            this.CategoryCard('🎨', 'Art', '12 items', '#FFF7ED')
          }
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')

        Column() {
          Text('Trending Now')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .margin({ top: 28, bottom: 12 })
            .width('100%')

          Row() {
            Column() {
              Text('🔥')
                .fontSize(24)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#FEF3C7')
            .justifyContent(FlexAlign.Center)
            .margin({ right: 12 })

            Column() {
              Text('Summer Collection')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
              Text('2.3K views today')
                .fontSize(11)
                .fontColor('#94A3B8')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
        .width('100%')
      }
      .width('85%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  FavoritesPage() {
    Scroll() {
      Column() {
        Column() {
          Text('Favorites')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          Text('Your saved collection')
            .fontSize(14)
            .fontColor('#94A3B8')
            .margin({ top: 4 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 60, bottom: 24 })

        Row() {
          Text('♥')
            .fontSize(16)
            .fontColor('#E11D48')
          Text('5 items saved')
            .fontSize(13)
            .fontColor('#64748B')
            .margin({ left: 8 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor('#FFF1F2')
        .borderRadius(12)
        .margin({ bottom: 16 })

        this.FavoriteItem('🏔', 'Mountain Sunrise', 'Added 2 days ago')
        this.FavoriteItem('🌊', 'Ocean Waves', 'Added 5 days ago')
        this.FavoriteItem('🌃', 'City Lights', 'Added 1 week ago')
        this.FavoriteItem('🌲', 'Forest Path', 'Added 2 weeks ago')
        this.FavoriteItem('🌅', 'Desert Sunset', 'Added 3 weeks ago')
      }
      .width('85%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  ProfilePage() {
    Scroll() {
      Column() {
        Column() {
          Stack() {
            Circle().width(80).height(80).fill('#EDE9FE')
            Text('AJ')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7C3AED')
          }
          .margin({ top: 60, bottom: 12 })

          Text('Alex Johnson')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          Text('alex@example.com')
            .fontSize(14)
            .fontColor('#94A3B8')
            .margin({ top: 4 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Row() {
          Column() {
            Text('128')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7C3AED')
            Text('Posts')
              .fontSize(11)
              .fontColor('#94A3B8')
              .margin({ top: 4 })
          }
          .layoutWeight(1)

          Column() {
            Text('2.4K')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7C3AED')
            Text('Followers')
              .fontSize(11)
              .fontColor('#94A3B8')
              .margin({ top: 4 })
          }
          .layoutWeight(1)

          Column() {
            Text('567')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7C3AED')
            Text('Following')
              .fontSize(11)
              .fontColor('#94A3B8')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .margin({ top: 20 })
        .backgroundColor('#FFFFFF')
        .borderRadius(16)

        Column() {
          this.SettingRow('Edit Profile', false)
          this.SettingRow('Notifications', false)
          this.SettingRow('Privacy', false)
          this.SettingRow('Help & Support', false)
          this.SettingRow('Sign Out', true)
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .margin({ top: 16 })
      }
      .width('85%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }
}