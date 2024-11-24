import { Task, TodoModels} from '../model/ToDoModels';
import Item_ToDoList from '../components/Item_ToDoList'
import CustomAddDialog from '../components/CustomAddDialog';

@Entry
@Component
export default struct ToDoList{

  private OriginTodoList: TodoModels = new TodoModels()
  @State TodoList: Task[] = this.OriginTodoList.getData()

  @State isEditDone: boolean = false

  @State editContent: string = ""

  @Link TaskStairs: Task // 接力上传ToDoList 中 Task

  @Consume ifListEditing: boolean

  onClose = ()=>{
    this.isEditDone = false
  }

  onCreate = ()=>{
    this.OriginTodoList.addData(this.editContent)
    this.TodoList = this.OriginTodoList.getData()
    this.isEditDone = false
  }

  build() {
    Stack({alignContent: Alignment.BottomEnd}) {
      // 主要内容
      Column({ space: 6 }) {
        // 顶部标题
        Column() {
          Column() {
            Blank()
            Image($r("app.media.Setting")).width(32)
          }.width("100%").height(32).alignItems(HorizontalAlign.End)
          Text("待办").fontSize(40).fontColor("#2c2c2c")
        }.backgroundColor(Color.White)
         .width('100%')
         .height('15%')
         .alignItems(HorizontalAlign.Start)
         .padding(16)
        // 待办事项
        Column(){
          List({ space: 6 }) {
            ForEach(this.TodoList, (item: Task) => {
              ListItem() {
                Item_ToDoList({ task_content: item, task_content_tmp: this.TaskStairs })
              }.height(60)
            })
          }
          .alignListItem(ListItemAlign.Center) // 元素布局
          .height('100%')
        }
        .height('85%')

      }.width('100%')
       .height('100%')
       .backgroundColor("#F1F3F5")


      // 弹窗
      if(this.isEditDone){
        CustomAddDialog({
          edit: this.editContent,
          onClose: this.onClose,
          onCreate: this.onCreate
        }).zIndex(4)
      }

      // 右下角的圆形加号按钮
      Button() {
        Image($r('app.media.push'))
          .width(50)
          .height(50)
      }
      .width(50)  // 与图片宽度一致
      .height(50)  // 与图片高度一致
      .position({ x: '75%', y: '90%' })
      .backgroundColor('transparent')  // 设置背景颜色为透明
      .zIndex(3)
      .onClick(() => {
        // 添加待办事项的逻辑
        this.isEditDone = true
        this.ifListEditing = false
        this.editContent = ""
      })
    }
  }
}
