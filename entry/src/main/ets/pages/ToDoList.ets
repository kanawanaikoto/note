
import {TaskDataModel} from '../entryability/Models';
import Item_ToDoList from '../components/Item_ToDoList'

@Entry
@Component
export default struct ToDoList{

  private totalData: Array<string> = [] // 总数据

  aboutToAppear(): void {
    this.totalData = new TaskDataModel().getData() // 获取数据
  }

  build() {
     Column({space: 6}) {
       // 顶部标题
       Column(){
         Column(){
           Blank()
           Image($r("app.media.Setting")).width(32)
         }.width("100%").height(32).alignItems(HorizontalAlign.End)
         Text("待办").fontSize(40).fontColor("#2c2c2c")
       }.backgroundColor(Color.White)
        .width('100%')
        .height(110)
        .alignItems(HorizontalAlign.Start)
        .padding(16)
       // 待办事项
       //ForEach(this.totalData, (item:string)=>{
       //  Item_ToDoList({task_content:item})
       //})
       List({space: 6}){
         ForEach(this.totalData, (item:string)=>{
           ListItem(){
             Item_ToDoList({task_content:item})
           }
         })
       }.alignListItem(ListItemAlign.Center)//元素布局
     }.width('100%')
      .height('100%')
      .backgroundColor("#F1F3F5")
  }
}
