import note_homepage from "../pages/note_homepage";
import ToDoList from "../pages/ToDoList";

@Component // 声明组件
export default struct TabBarView{
  @State currentIndex: number = 0;//底部导航栏当前选中项
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
           ToDoList().height('100%')
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
  }
}