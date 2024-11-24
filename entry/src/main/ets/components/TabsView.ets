import note_homepage from "../pages/note_homepage";
import ToDoList from "../pages/ToDoList";
import { Task, TodoModels} from '../model/ToDoModels';

@Component // 声明组件
export default struct TabBarView{
  @State currentIndex: number = 0;//底部导航栏当前选中项
  @State TopOfTaskStairs: Task = {index: 0, task: ""} // 连接到src/main/ets/components/Item_ToDoList.ets
  @Provide ifListEditing: boolean = false
  @Provide IndexOfListChanging: number = this.TopOfTaskStairs.index
  @State toDoList: TodoModels = new TodoModels()
  //@Builder 转变为视图函数
  @Builder tabBuilder(title: string,targetIndex:number,icon:Resource,icon_f:Resource) {
    Column(){
      Image(this.currentIndex === targetIndex?icon_f:icon).size({width: 30, height: 30})
      Text(title).fontColor(this.currentIndex===targetIndex?"#2c2c2c":"#cdcdcd").fontSize(12)
    }
  }
  build(){
    Column(){
      Tabs({barPosition: BarPosition.End}/*布局*/) {
        TabContent() {
          Column(){
            //内容
            note_homepage().height('100%')
          }.width('100%')
           .height('100%')
           .backgroundColor('#adf5f5f5')
        }.tabBar(this.tabBuilder("便签",0, $r("app.media.note_f"),$r("app.media.note")))
        TabContent() {
         Column(){
            //内容
           ToDoList({TaskStairs:this.TopOfTaskStairs}).height('100%')
          }.width('100%')
           .height('100%')
           .backgroundColor('#adf5f5f5')
        }.tabBar(this.tabBuilder("待办",1,$r("app.media.to_do_f"),$r("app.media.to_do")))//标题
      } .backgroundColor('#fff')
        .onChange((index: number)=>{//触发事件
        this.currentIndex = index//更新当前选中项
      })
    }.width('100%')
     .height('100%')
     .backgroundColor("#f3f3f3")
     .alignItems(HorizontalAlign.Center)
      .onClick(() => {
        this.toDoList.changeDataByIndex(this.TopOfTaskStairs.task, this.TopOfTaskStairs.index)
        this.ifListEditing = false //当每次点击主界面时，将位于pages/ToDoList的同名变量设为false，这样就能退出编辑状态
      })
  }
}

// @Preview
// @Component
// struct TabBarViewPreview {
//   build() {
//     TabBarView()
//   }
// }