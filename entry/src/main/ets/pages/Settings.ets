
@Builder
export function getSetting() {
  SettingsPage()
}

@Entry
@Component
struct SettingsPage {

  pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack

  // 页面加载
  aboutToAppear(): void {
    // 初始化数据
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.fontSize = value as number;
    })
    PreferencesUtil.getChangeSort().then((value) => {
      this.order = value as number;
    })
    PreferencesUtil.getChangeStyle().then((value) => {
      this.appStyle = value as number;
    })
  }

  // 笔记排序
  @State order : number = 0
  // 主题
  @State theme : number = 0
  // 字体大小
  @State fontSize : number = 0
  // 应用风格
  @State appStyle : number = 0

  build() {
    NavDestination() {
      Column({ space: 8}) {

        Item({ title: "主题" , description:this.appStyle, icon: $r("app.media.right_2")})
          .onClick(() => {
            promptAction.showToast({
              message: '功能开发中',
              duration: 1600,
              bottom: 75
            })
          })
        Item({ title: "字体大小", description:this.fontSize, icon: $r("app.media.expand") })
          .onClick(() => {
            promptAction.showToast({
              message: '功能开发中',
              duration: 1600,
              bottom: 75
            })
          })
        Item({ title: "应用风格", description: this.appStyle, icon: $r("app.media.expand") })
          .bindMenu([
            {
              value:"弹窗模式",
              action:()=>{
                this.appStyle = 1
                PreferencesUtil.saveChangeStyle(this.appStyle)
              }
            },
            {
              value:"页面模式",
              action:()=>{
                this.appStyle = 2
                PreferencesUtil.saveChangeStyle(this.appStyle)
              }
            }
          ])
        Item({ title: "笔记排序", description: this.order, icon: $r("app.media.expand") })
          .bindMenu([
            {
              value:"按编辑时间升序",
              action:()=>{
                this.order = 0
              }
            },
            {
              value:"按编辑时间降序",
              action:()=>{
                this.order = 1
              }
            }
          ])

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
                promptAction.showToast({
                  message:'没开源捏',
                  duration:1600,
                  bottom:75
                })

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
      .padding({right: 20})   //外边距

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
  @Link description: number
  @State icon: Resource = $r("app.media.right")

  build() {
    Row() {
      Text(this.title)
        .fontSize(16)
        .height(50)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
      Blank()
      Text(get(this.description,this.title))
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
    }
    .margin(10)
    .width('100%')
    .backgroundColor("#FFFFFF")
    .borderRadius(8)
    }
}


function get(description: number, title: string): string {
  switch (title){
    case "应用风格":
      return description == 1 ? "弹窗模式" : "页面模式"
    case "笔记排序":
      return description == 0 ? "按编辑时间升序" : "按编辑时间降序"
    default:
      return "默认"
  }
}
