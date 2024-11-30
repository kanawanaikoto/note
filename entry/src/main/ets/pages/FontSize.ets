import Item_NoTe from '../components/Item_NoTe';
import Item_ToDoList from '../components/Item_ToDoList';
import SettingData from '../constants/SettingData';
import PreferencesUtil from '../database/PreferencesUtil'
import NoteDataModel from '../model/NoteModel';
import { Task } from '../model/ToDoModels';


@Builder
export function getFontSize() {
  FontSize()
}

@Entry
@Component
struct FontSize {
  pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack
  @State fontSize: number = 0
  @State note: NoteDataModel = new NoteDataModel(1, 1732203931481, "hello world")
  @State todoOK: Task = new Task(1, "hello world", 0)
  @State todo: Task = new Task(2, "hello world", 0)
  @State isEditing: number = 1
  @State preEdit: number|null = null

  aboutToAppear(): void {
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.fontSize = value as number;
      console.log("fontSize: " + this.fontSize);
    })

  }

  build() {
    NavDestination() {
      Column({ space: 30 }) {
        // 标题栏
        Row() {
          Button() {
            Image($r("app.media.back_2"))
          }
          .backgroundColor(Color.Transparent)
          .width(30)
          .height(30)
          .onClick(() => {
            this.pathStack.pop(this.fontSize)
          })

          Blank()
          Text("字体大小")
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .margin({ right: 25 })
          Blank()
        }
        .alignItems(VerticalAlign.Center)
        .width("100%")
        .padding({ left: 16 })

        Item_NoTe({ note: this.note,fontSize:this.fontSize })
        Item_ToDoList({ task: this.todoOK, IndexOfListChanging: this.isEditing,fontSize:this.fontSize, IndexOfListChangedBefore: this.preEdit })
        Item_ToDoList({ task: this.todo, IndexOfListChanging: this.isEditing,fontSize:this.fontSize, IndexOfListChangedBefore: this.preEdit })

        Blank()
        SliderLayout({
          changeFontSize: this.fontSize
        })
          .width('100%')
      }
      .height("100%")
      .width("100%")
    }
    .hideTitleBar(true) //隐藏标题栏
    .height("100%")
    .width("100%")
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}

// 定义滑动布局组件
@Component
struct SliderLayout {
  // 用于存储字体大小的变化值
  @Link changeFontSize: number;

  // 构建滑动布局
  build() {
    Column() {
      Column(){
        // 显示当前字体大小的文本描述
        Text(getfontSize(this.changeFontSize))
          .fontSize(14)
          .fontColor($r('sys.color.font_primary'))
        // 添加滑动条组件，用于调整字体大小
        Row() {
          // 添加小写的'a'字符
          Text('a')
            .fontColor($r('sys.color.font_primary'))
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.End)
            .width('12.5%')
            .padding({ right: 9 })
          Slider({
            value: this.changeFontSize === SettingData.SET_SIZE_HUGE
              ? SettingData.SET_SLIDER_MAX : this.changeFontSize,
            min: SettingData.SET_SLIDER_MIN,
            max: SettingData.SET_SLIDER_MAX,
            step: SettingData.SET_SLIDER_STEP,
            style: SliderStyle.InSet
          })
            .showSteps(true)
            .width("75%")
            .onChange(async (value: number) => {
              // 处理滑动条值变化的逻辑
              if (this.changeFontSize === 0) {
                this.changeFontSize = await PreferencesUtil.getChangeFontSize();
                return
              }
              this.changeFontSize = (value === SettingData.SET_SLIDER_MAX ?
              SettingData.SET_SIZE_HUGE : value);
              // 保存字体大小的变化值到偏好设置
              PreferencesUtil.saveChangeFontSize(this.changeFontSize);
              console.log("changeFontSize: " + this.changeFontSize);
            })

          // 添加大写的'A'字符
          Text('A')
            .fontColor($r('sys.color.font_primary'))
            .fontSize("24fp")
            .fontWeight(FontWeight.Bold)
            .width('12.5%')
            .padding({ left: 8 })
        }

      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(24)
      .width('93.3%')
      .padding({ top: 16, bottom: 21 })
      .margin({
        left: '3.3%',
        right: '3.3%',
        top: '1%',
        bottom: '6.2%'
      })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.End)
  }
}

function getfontSize(description: number){
  switch (description){
    case 14:
      return "小号"
    case 16:
      return "标准"
    case 18:
      return "大号"
    case 20:
      return "超大号"
    case 24:
      return "巨大号"
    default:
      return "默认"
  }
}
