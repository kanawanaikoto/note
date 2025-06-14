import { promptAction } from "@kit.ArkUI";
import PreferencesUtil from "../database/PreferencesUtil";
import { setDarkColorMode, setLightColorMode, setAutoColorMode } from "../utils/ColorModeChangeFunctions";
import { common } from "@kit.AbilityKit";
import SettingData from "../constants/SettingData";

@Builder
export function getSetting() {
  SettingsPage()
}

@Entry
@Component
struct SettingsPage {

  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack
  // 笔记排序
  @State order: number = 0
  // 主题
  @State @Watch("PreferencesTheme") theme: number = 0
  // 字体大小
  @State fontSize: number = 0
  // 应用风格
  @State appStyle: number = 0

  PreferencesTheme(){
    if(this.theme == 0){
      setAutoColorMode(this.context)
    } else if(this.theme == 1){
      setLightColorMode(this.context)
    } else {
      setDarkColorMode(this.context)
    }
  }

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
    PreferencesUtil.getChangeColor().then((value) => {
      this.theme = value as number;
    })
  }

  build() {
    NavDestination() {
      Column({ space: 8 }) {
        Row() {
          Button() {
            Image($r("app.media.back"))
              .fillColor($r('app.color.some_icons'))
          }
          .backgroundColor(Color.Transparent)
          .width(30)
          .height(30)
          .onClick(() => {
            this.pathStack.pop({
              order:this.order,
              appStyle:this.appStyle,
              fontSize:this.fontSize
            })
          })

          Blank()
          Text("设置")
            .fontSize(25)
            .fontColor($r('sys.color.black'))
            .fontWeight(FontWeight.Bold)
            .margin({ right: 25 })
          Blank()
        }
        .alignItems(VerticalAlign.Center)
        .width("100%")
        .padding({ left: 16 })

        Item({ title: "主题", description: this.theme, icon: $r("app.media.right"),fontSize:this.fontSize })
          // .onClick(() => {
          //   promptAction.showToast({
          //     message: '功能开发中',
          //     duration: 1600,
          //     bottom: 75
          //   })
          // })
          .bindMenu([
            {
              value: "浅色模式",
              action: () => {
                this.theme = 1
                PreferencesUtil.saveChangeColor(this.theme)
              }
            },
            {
              value: "暗黑模式",
              action: () => {
                this.theme = 2
                PreferencesUtil.saveChangeColor(this.theme)
              }
            },
            {
              value: "跟随系统",
              action: () => {
                this.theme = 0
                PreferencesUtil.saveChangeColor(this.theme)
              }
            }
          ])
        Item({ title: "应用风格", description: this.appStyle, icon: $r("app.media.expand"),fontSize:this.fontSize })
          .bindMenu([
            {
              value: "弹窗模式",
              action: () => {
                this.appStyle = 1
                PreferencesUtil.saveChangeStyle(this.appStyle)
              }
            },
            {
              value: "页面模式",
              action: () => {
                this.appStyle = 2
                PreferencesUtil.saveChangeStyle(this.appStyle)
              }
            }
          ])
        Item({ title: "笔记排序", description: this.order, icon: $r("app.media.expand"),fontSize:this.fontSize })
          .bindMenu([
            {
              value: "按编辑时间升序",
              action: () => {
                this.order = 0
                PreferencesUtil.saveChangeSort(this.order)
              }
            },
            {
              value: "按编辑时间降序",
              action: () => {
                this.order = 1
                PreferencesUtil.saveChangeSort(this.order)
              }
            }
          ])
        Item({ title: "字体大小", description: this.fontSize, icon: $r("app.media.right"),fontSize:this.fontSize })
          .onClick(() => {
            // promptAction.showToast({
            //   message: '功能开发中',
            //   duration: 1600,
            //   bottom: 75
            // })
            this.pathStack.pushPathByName("FontSize", {},(fontSize)=>{
              this.fontSize = fontSize.result as number;
            })
          })

        Divider().color("#E0E0E0").height(1).margin({ top: 10, bottom: 10 })
        Blank() //占位
        Column() {
          Row() {
            Text("版权所有©:一天速通ArkTS，然后卡在不会英语")
          }

          Row() {
            Text("版本号:Beta.0.0.1")
              .fontColor('#ff0979e9')
            Blank()
            Text("GitHub")
              .fontColor('#ff0979e9')
              .onClick(() => {
                promptAction.showToast({
                  message: '没开源捏',
                  duration: 1600,
                  bottom: 75
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
      .padding({ right: 20 }) //外边距

    }
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    //.title("设置")
    .hideTitleBar(true) //隐藏标题栏
    .height("100%")
    .width("100%")

  }
}


//"app.media.right"
@Component
struct Item {
  @State title: string = ""
  @Link description: number
  @State icon: Resource = $r("app.media.right")
  @Link fontSize: number

  build() {
    Row() {
      Text(this.title)
        .fontSize(this.fontSize)
        .height(50)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
      Blank()
      Text(get(this.description, this.title))
        .fontColor('#c4aaafb1')//字体颜色
        .fontSize(this.fontSize*0.8)
        .height(50)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
      Button() {
        Image(this.icon)
          .width(24)
          .fillColor($r('app.color.some_icons'))
      }
      .margin({ right: 10 })
      //透明
      .backgroundColor(Color.Transparent)
    }
    .margin(10)
    .width('100%')
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius(8)
  }
}


function get(description: number, title: string): string {
  switch (title) {
    case "主题":
      return description == 1 ? "浅色模式" : description == 2 ? "暗黑模式" : "跟随系统"
    case "应用风格":
      return description == 1 ? "弹窗模式" : "页面模式"
    case "笔记排序":
      return description == 0 ? "按编辑时间升序" : "按编辑时间降序"
    case "字体大小":
      return getfontSize(description)
    default:
      return "默认"
  }
}

function getfontSize(description: number){
  switch (description){
    case SettingData.SET_SIZE_SMALL:
      return "小号"
    case SettingData.SET_SIZE_NORMAL:
      return "标准"
    case SettingData.SET_SIZE_LARGE:
      return "大号"
    case SettingData.SET_SIZE_EXTRA_LARGE:
      return "超大号"
    case SettingData.SET_SIZE_HUGE:
      return "巨大号"
    default:
      return "默认"
  }
}