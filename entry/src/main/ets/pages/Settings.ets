import { mediaquery, promptAction } from "@kit.ArkUI"

@Builder
export function getSetting() {
  SettingsPage()
}

@Entry
@Component
struct SettingsPage {

  build() {
    NavDestination() {
      Column({ space: 10}) {

        Item({ title: "主题" , description:"默认", icon: $r("app.media.right_2")})
        Item({ title: "字体大小", description: "默认", icon: $r("app.media.expand") })
        Item({ title: "笔记风格", description: "默认", icon: $r("app.media.expand") })
        Item({ title: "笔记排序", description: "按日期升序", icon: $r("app.media.expand") })
        // SectionTitle({ text: "笔记样式" })
        // SettingItem({ title: "文字大小", description: "默认" })
        // SettingItem({ title: "选择排序方式", description: "按编辑日期" })
        // SettingItem({ title: "笔记列表布局", description: "列表模式", hasToggle: true })
        // SectionTitle({ text: "其他设置" })

        Divider().color("#E0E0E0").height(1).margin({ top: 10, bottom: 10 })
        Blank()//占位
        Column(){
          Row(){
            Text("版权所有©:一天速通ArkTS，然后卡在不会英语")
          }
          Row(){
            Text("版本号:Beta.0.0.1")
              .fontColor('#ff0979e9')
            Blank()
            Text("GitHub")
              .fontColor('#ff0979e9')
              .onClick(()=>{
                promptAction.showToast({message: "没开源捏", duration: 1000, bottom: 75})
                // ("没开源捏")
              })
            Blank()
            Text("关于我们")
              .fontColor('#ff0979e9')
          }
          .width("100%")
        }

      }
      .width("100%")
      .height("100%")
      .padding(20)   //外边距

    }
    .backgroundColor("#F1F3F5")
    .title("设置")
    .height("100%")
    .width("100%")


  }
}


//"app.media.right"
@Component
struct Item{

  @State title: string = ""
  @State description: string = ""
  @State icon: Resource = $r("app.media.right")
  
  build() {
    Row() {
      Text(this.title)
        .fontSize(16)
        .height(50)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
      Blank()
      Text(this.description)
        .fontColor('#c4aaafb1')  //字体颜色
        .fontSize(14)
        .height(50)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
      Button(){
        Image(this.icon)
        .width(24)
      }
      .margin({right: 10})
      //透明
      .backgroundColor(Color.Transparent)
      .bindMenu([{
        value: "分享",action: ()=>{
          promptAction.showToast({message: "分享", duration: 1000, bottom: 75})
        }
      }
      ])
    }
    .margin(10)
    .width('100%')
    .backgroundColor("#FFFFFF")
    .borderRadius(8)
    }
}

