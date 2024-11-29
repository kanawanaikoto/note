//import TabBarView from '../components/TabsView'
import note_homepage from './note_homepage'
import ToDoList from './ToDoList'
import { Task, TodoModels} from '../model/ToDoModels';
import PreferencesUtil from '../database/PreferencesUtil';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {

  @State fontSize: number = 16
  // 当前页面索引状态，用于标识当前选中的页面
  @State index: number = 0

  aboutToDisappear(): void {
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.fontSize = value as number;
      console.log("fontSize: " + this.fontSize);
    })

  }

  // 自定义构建器，用于创建导航工具栏
  @Builder NavigationToolbar() {
    Row() {

      // 便签页面的图标和文字
      Column() {
        Image($r('app.media.note'))
          .size({ width: 25, height: 25 })
          .fillColor(this.index == 0 ? $r('app.color.tar_bar_selected'):$r('app.color.tar_bar_unselected'))
        Text('便签')
          .fontSize(this.fontSize)
          .fontColor(this.index == 0 ? $r('app.color.tar_bar_selected'):$r('app.color.tar_bar_unselected'))
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 0;
      })

      // 待办页面的图标和文字
      Column() {
        Image($r('app.media.todo'))
          .size({ width: 25, height: 25 })
          .fillColor(this.index == 1 ? $r( 'app.color.tar_bar_selected') : $r('app.color.tar_bar_unselected'))
        Text('待办')
          .fontSize(this.fontSize)
          .fontColor(this.index == 1 ? $r('app.color.tar_bar_selected'):$r('app.color.tar_bar_unselected'))
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 1;
      })

    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .width('100%')
    .height(60)
    .alignItems(VerticalAlign.Center)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

  }

  // 初始化一个导航路径栈，用于管理导航路径
  pathStack: NavPathStack = new NavPathStack()

  // 全局设置一个NavPathStack
  aboutToAppear(): void {
     AppStorage.setOrCreate("PathStack", this.pathStack)
   }

  build() {
    // 使用Navigation组件来实现页面导航，传入路径栈以管理导航状态
    Navigation(this.pathStack) {
      Column() {
        if(this.index == 0){
          note_homepage()
        }else{
          ToDoList()
        }
      }
      .height('94%')

      Row() {

        // 便签页面的图标和文字
        Column() {
          Image($r('app.media.note'))
            .size({ width: 25, height: 25 })
            .fillColor(this.index == 0 ? $r('app.color.tar_bar_selected') : $r('app.color.tar_bar_unselected'))
          Text('便签')
            .fontSize(this.fontSize)
            .fontColor(this.index == 0 ? $r('app.color.tar_bar_selected') : $r('app.color.tar_bar_unselected'))
        }
        .alignItems(HorizontalAlign.Center)
        .height('100%')
        .layoutWeight(1)
        .onClick(() => {
          this.index = 0;
        })

        // 待办页面的图标和文字
        Column() {
          Image($r('app.media.todo'))
            .size({ width: 25, height: 25 })
            .fillColor(this.index == 1 ? $r('app.color.tar_bar_selected') : $r('app.color.tar_bar_unselected'))
          Text('待办')
            .fontSize(this.fontSize)
            .fontColor(this.index == 1 ? $r('app.color.tar_bar_selected') : $r('app.color.tar_bar_unselected'))
        }
        .alignItems(HorizontalAlign.Center)
        .height('100%')
        .layoutWeight(1)
        .onClick(() => {
          this.index = 1;
        })
      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Free)
    .hideBackButton(true) // 隐藏返回按钮
    .hideToolBar(true)
    //.toolbarConfiguration(this.NavigationToolbar())// 自定义导航工具栏
    .size({ width: '100%', height: '100%' })
    //.backgroundColor($r('sys.color.ohos_id_color_background'))
    //.expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
