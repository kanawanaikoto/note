import { Task, TodoModels} from '../model/ToDoModels';
import Item_ToDoList from '../components/Item_ToDoList'
import CustomAddDialog from '../components/CustomAddDialog';

// 定义ToDoList组件，用于展示和管理待办事项列表
@Entry
@Component
export default struct ToDoList{

  // 初始化待办事项列表模型
  private OriginTodoList: TodoModels = new TodoModels()

  // 获取待办事项列表数据
  @State TodoList: Task[] = []

  // 编辑待办事项的状态
  @State isEditDone: boolean = false

  // 编辑待办事项的内容
  @State editContent: string = ""

  // 当前正在编辑的待办事项索引，-1表示没有编辑
  @State ifListEditing: number = -1

  // 构建列表项末尾的操作按钮
  @Builder
  getListEnd(item:Task){
    Row() {
      Button() {
        Image($r('app.media.delete'))
          .width(40)
          .height(40)
      }
      .backgroundColor('#d9d9d9')
      .width(50)
      .height(50)
      .onClick(() => {
        // 删除待办事项
        this.OriginTodoList.deleteDataByIndex(item.id)
        this.TodoList = this.OriginTodoList.getData()
      })
    }.padding("4vp").justifyContent(FlexAlign.SpaceEvenly)
  }

  // 关闭编辑对话框
  onClose = ()=>{
    this.isEditDone = false
  }

  // 创建（添加）新的待办事项
  onCreate = ()=>{
    this.OriginTodoList.addData(this.editContent)
    this.TodoList = this.OriginTodoList.getData()
    this.isEditDone = false
  }

  // 构建ToDoList组件
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
        // 待办事项列表
        Column({ space: 0 }){
          List({ space: 6 }) {
            ForEach(this.TodoList, (item: Task) => {
              ListItem() {
                Item_ToDoList({ task: item, IndexOfListChanging: this.ifListEditing })
              }.height(60)
              .swipeAction({end:{
                builder:()=> {
                  this.getListEnd(item)
                },
              }
              })
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
        this.ifListEditing = -1
        this.editContent = ""
      })
    }
    .onClick(()=>{
      this.ifListEditing = -1
    })
  }
}
