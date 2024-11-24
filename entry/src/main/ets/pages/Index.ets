//import TabBarView from '../components/TabsView'
import note_homepage from './note_homepage'
import ToDoList from './ToDoList'
import { Task, TodoModels} from '../model/ToDoModels';

@Entry
@Component
struct Index {


  // 当前页面索引状态，用于标识当前选中的页面
  @State index: number = 0

  // 自定义构建器，用于创建导航工具栏
  @Builder NavigationToolbar() {
    Row() {
      // 便签页面的图标和文字
      Column() {
        Image(this.index == 1 ?$r("app.media.note_f"):$r("app.media.note"))
          .size({ width: 25, height: 25 })
        Text('便签')
          .fontSize(16)
          .fontColor(this.index == 0 ? "#2c2c2c":"#cdcdcd")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 0;
      })

      // 待办页面的图标和文字
      Column() {
        Image(this.index == 0 ? $r("app.media.to_do_f"):$r("app.media.to_do"))
          .size({ width: 25, height: 25 })
        Text('待办')
          .fontSize(16)
          .fontColor(this.index == 1 ? "#2c2c2c":"#cdcdcd")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 1;
      })

    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)

  }

  // 初始化一个导航路径栈，用于管理导航路径
  pathStack: NavPathStack = new NavPathStack()

  // 全局设置一个NavPathStack
  aboutToAppear(): void {
     AppStorage.setOrCreate("PathStack", this.pathStack)
   }

  @State TopOfTaskStairs: Task = {index: 0, task: ""} // 连接到src/main/ets/components/Item_ToDoList.ets
  @Provide ifListEditing: boolean = false // 标记是否处在编辑状态
  @Provide IndexOfListChanging: number = this.TopOfTaskStairs.index //标记编辑待办事项编号
  @State toDoList: TodoModels = new TodoModels() //待办事项数据

  build() {
    // 使用Navigation组件来实现页面导航，传入路径栈以管理导航状态
    Navigation(this.pathStack) {
      Column() {
        if(this.index == 0){
          note_homepage().height('100%')
        }else{
          ToDoList({TaskStairs: this.TopOfTaskStairs}).height('100%')
        }
      }.width('100%').height('100%')
      .onClick(() => {
        this.toDoList.changeDataByIndex(this.TopOfTaskStairs.task, this.TopOfTaskStairs.index)
        this.ifListEditing = false //当每次点击主界面时，将位于pages/ToDoList的同名变量设为false，这样就能退出编辑状态
      })
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Free) // 自定义标题
    .hideBackButton(true) // 隐藏返回按钮
    .toolbarConfiguration(this.NavigationToolbar())
    .size({ width: '100%', height: '100%' })
  }
}
