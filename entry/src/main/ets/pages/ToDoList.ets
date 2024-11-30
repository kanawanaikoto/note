import { Task } from '../model/ToDoModels';
import Item_ToDoList from '../components/Item_ToDoList'
import CustomAddDialog from '../components/CustomAddDialog';
import ToDoTable from "../database/ToDoTable"
import SearchBar from '../components/components_search';
import PreferencesUtil from '../database/PreferencesUtil';
import { promptAction } from '@kit.ArkUI';

// 定义ToDoList组件，用于展示和管理待办事项列表
@Entry
@Component
export default struct ToDoList{

  @State fontSize: number = 0

  // 初始化待办事项列表模型
  private todotable: ToDoTable = new ToDoTable()
  // 原始待办事项列表数据
  private OriginTodoList: Task[] = []
  @State TodoListStorage: Task[] = []

  pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack

  // 搜索框内容
  @State @Watch('onsearchText') searchText: string = ""
  @State @Watch('onDeleteNullItem') theListEditIsNull: number|null = null;

  // 搜索框内容改变
  onsearchText() {
    if (this.searchText.length === 0) {
      this.TodoListStorage = this.OriginTodoList
    } else {
      let result: Task[] = []

      for (const todoItem of this.OriginTodoList) {
        if (todoItem.task.includes(this.searchText)) {
          result.push(todoItem)
        }
      }

      this.TodoListStorage = result

    }
  }

  onDeleteNullItem():void {
    if (this.theListEditIsNull !== null) {
      this.deleteDataByIndex(this.theListEditIsNull)
      this.theListEditIsNull = null
    }
  }

  clean = ()=>{
    this.searchText = ""
  }

  // 获取待办事项列表数据
  //@State TodoListStorage: Task[] = []

  // 编辑待办事项的状态
  @State isEditDone: boolean = false

  // 编辑待办事项的内容
  @State editContent: string = ""

  // 当前正在编辑的待办事项索引，-1表示没有编辑
  @State ifListEditing: number|null = null

   addData(data:string):void {
    let task: Task = new Task(0, data, 0)
    this.todotable.insertData(task, (id: number)=>{
      task.id = id
      this.OriginTodoList.push(task)
      this.TodoListStorage = this.OriginTodoList
    })
    // let i = 0
    // for(i=0;i<this.todo.length;i++)
    //   Logger.info("dedataadd"+this.todo[i].id.toString())
  }
  // 修改
  changeDataByIndex(data: string, index: number){
    let i = 0
    for(;i<this.OriginTodoList.length;i++){
      if(this.OriginTodoList[i].id === index){
        break
      }
    }
    this.todotable.updateData(this.OriginTodoList[i], ()=>{
      this.OriginTodoList[i].task = data
      this.TodoListStorage = this.OriginTodoList
    })
  }

  // 删除
  deleteDataByIndex(index: number){
    let i = 0
    for(;i<this.OriginTodoList.length;i++){
      if(this.OriginTodoList[i].id === index){
        break
      }
    }
    this.todotable.deleteData(this.OriginTodoList[i], ()=>{
      this.OriginTodoList.splice(i, 1)
      this.TodoListStorage = this.OriginTodoList
    })
  }

  getDataByIndex(index: number):Task|null{
    let i=0;
    for(;i<this.TodoListStorage.length;i++){
      if(this.TodoListStorage[i].id === index){
        return this.TodoListStorage[i]
      }
    }
    return null;
  }

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
        this.deleteDataByIndex(item.id)
        //this.TodoListStorage = this.OriginTodoList
      })
    }.padding($r('sys.float.corner_radius_level2')).justifyContent(FlexAlign.SpaceEvenly)
  }

  // 组件加载时执行
  aboutToAppear(): void {
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.fontSize = value as number;
    })
    this.todotable.getRadState(()=>{
      this.todotable.query((data: Task[])=>{
        this.OriginTodoList = data
        this.TodoListStorage = this.OriginTodoList
      })
    })
  }

  // 关闭编辑对话框
  onClose = ()=>{
    this.isEditDone = false
  }

  // 创建（添加）新的待办事项
  onCreate = ()=>{
    if(this.editContent === ''){
      promptAction.showToast({
        message: '内容不能为空',
        duration: 1600,
        bottom: 75
      })
      return
    }
    this.addData(this.editContent)
    //this.TodoListStorage = this.OriginTodoList
    this.isEditDone = false
  }

  // 跳转设置页面
  getSetting(){
    this.pathStack.pushPathByName("Setting",{},(popInfo)=>{
      console.log("114514")
      // PreferencesUtil.getChangeSort().then((value) => {
      //   console.log("114514")
      //   this.order = (value as number) === 1 ? true:false;
      // })

      this.fontSize = popInfo.result['fontSize']
    })
  }

  // 构建ToDoList组件
  build() {
    Stack({alignContent: Alignment.BottomEnd}) {
      // 主要内容
      Column({ space: 10 }) {
      Column({ space: 8 }) {
        // 顶部标题
        Column() {
          Column() {
            Blank()
            Image($r("app.media.Setting"))
              .width(32)
              .onClick(() => {
                this.getSetting()
              })
              .fillColor($r('app.color.some_icons'))
          }.width("100%").height(32).alignItems(HorizontalAlign.End)

          Text("待办").fontSize(40)
            .padding({bottom: 10,top:3})
          SearchBar({ searchText: this.searchText, clean: this.clean , todoEditStatus: this.ifListEditing})// 搜索框
            .width('100%')
            .onFocus(()=>{
              this.ifListEditing = null
            })
        }
        .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        .width('100%')
        .height(165)
        .alignItems(HorizontalAlign.Start)
        .padding(18)
      }.height('22%')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
      .width('100%')
        // 待办事项列表
        Column({ space: 0 }){
          List({ space: 6 }) {
            ForEach(this.TodoListStorage, (item: Task) => {
              ListItem() {
                Item_ToDoList({ task: item, IndexOfListChanging: this.ifListEditing,fontSize:this.fontSize ,IndexOfListChangedBefore: this.theListEditIsNull })
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
          .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        }
        .height('85%')

      }.width('100%')
       .height('100%')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))


      // 弹窗
      if(this.isEditDone){
        CustomAddDialog({
          edit: this.editContent,
          onClose: this.onClose,
          onCreate: this.onCreate
        })
          .height('100%')
          .width('100%')
          .zIndex(4)
      }

      // 右下角的圆形加号按钮
      Button() {
        Image($r('app.media.push'))
          .width(50)
          .height(50)
          .fillColor($r('app.color.some_icons'))
      }
      .width(50)  // 与图片宽度一致
      .height(50)  // 与图片高度一致
      .position({ x: '75%', y: '90%' })
      .backgroundColor('transparent')  // 设置背景颜色为透明
      .zIndex(3)
      .onClick(() => {
        // 添加待办事项的逻辑
        this.isEditDone = true
        this.ifListEditing = null
        this.editContent = ""
      })
    }
    .height('100%')
    .onClick(()=>{
      // if(this.ifListEditing !== null){
      //   let result :Task|null = this.getDataByIndex(this.ifListEditing)
      //   if(result !== null && result.task.length === 0){
      //     this.deleteDataByIndex(this.ifListEditing)
      //     this.ifListEditing = null
      //   }
      // }
      this.ifListEditing = null
    })
  }
}

function Input() {
  throw new Error('Function not implemented.');
}
