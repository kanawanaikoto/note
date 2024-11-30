import components_search from '../components/components_search'
import CustomAddDialog from '../components/CustomAddDialog'
import CustomEditDialog from '../components/CustomEditDialog'
import Item_NoTe from '../components/Item_NoTe'
import NoteDataModel from '../model/NoteModel'
import NoTeTable from '../database/NoTeTable'
import PreferencesUtil from '../database/PreferencesUtil'
import { setDarkColorMode, setLightColorMode, setAutoColorMode } from "../utils/ColorModeChangeFunctions";
import { collections } from '@kit.ArkTS';
import { faceDetector } from '@kit.CoreVisionKit'
import { common } from '@kit.AbilityKit'
import { promptAction, ToggleModifier } from '@kit.ArkUI'

@Entry
@Component
export default struct note_homepage {

  // 字体大小
  @State fontSize : number = 0
  // 应用风格
  @State appStyle : number = 1
  // 应用颜色
  @State appTheme : number = 0

  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  // 路径栈
   pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack

  // 缓存的原始数组
  originNoteList: NoteDataModel[] = []
  // 显示数据
  @State note: NoteDataModel[] = []
  // 搜索框内容
  @State @Watch('onsearchText') searchText: string = ""
  // 排序
  @State @Watch('onOrderChanged') order: boolean = true
  // 新建便签弹窗
  @State isAdd: boolean = false
  // 新建便签内容
  @State addNote: string = ""
  // 编辑内容
  @State editNote: string = ""
  // 编辑弹窗开关
  @State isEdit: boolean = false
  // 编辑索引
  @State editIndex: number = -1
  // 数据库
  private NoteTable: NoTeTable = new NoTeTable()
  //只是为了填一下searchbar的变量罢了
  @State aUselessVariableForSearchText: number|null = null
  // 清空搜索框
  clean = () => {
    this.searchText = ""
  }

  // 搜索框内容改变
  onsearchText() {
    if (this.searchText.length === 0) {
      this.note = this.originNoteList
      this.onOrderChanged()
    } else {
      let result: NoteDataModel[] = []

      for (const noteItem of this.originNoteList) {
        if (noteItem.content.includes(this.searchText)) {
          result.push(noteItem)
        }
      }

      this.note = result

    }
  }

  // 排序
  onOrderChanged() {

    if(this.order){
      console.log("序:升序")
      this.originNoteList=this.originNoteList.sort((a, b) => {
        return a.updateTime - b.updateTime
      })
    } else {
      console.log("序:降序")
      this.originNoteList=this.originNoteList.sort((a, b) => {
        return b.updateTime - a.updateTime
      })
    }
    this.note = this.originNoteList
  }

  // 关闭弹窗
  onClose = () => {
    this.isAdd = false
    this.addNote = ""
    this.editNote = ""
    this.editIndex = -1
    this.isEdit = false
  }
  // 创建新便签
  onCreate = () => {
     if(this.addNote===""){
       promptAction.showToast({
         message: '内容不能为空',
         duration: 1600,
         bottom: 75
       })
       return
     }
    const note: NoteDataModel = new NoteDataModel(this.note.length + 1, Date.now(), this.addNote)
    this.note = this.originNoteList
    this.NoteTable.insertData(note, (id: number) => {
      note.id = id
      this.originNoteList.push(note)
      this.note = this.originNoteList
      this.onOrderChanged()
      this.onClose()
    })
  }

  getId = (note: NoteDataModel)=>{
    console.log(JSON.stringify(note))
    for (let i = 0; i < this.originNoteList.length; i++) {
      if (this.originNoteList[i].id === note.id) {
        this.editNote = this.originNoteList[i].content
        this.editIndex = i
        break
      }
    }
}

  // 编辑弹窗
  onNoteEdit = (note: NoteDataModel) => {

    this.getId(note)
    if(this.appStyle==1){
      this.isEdit = true
    }
    else {
      this.getNote(note)
    }

  }
  // 删除
  onDelete = () => {
    if (this.editIndex !== -1) {
      this.NoteTable.deleteData(this.originNoteList[this.editIndex], () => {
        this.originNoteList.splice(this.editIndex, 1)
        this.note = this.originNoteList
        this.onOrderChanged()
        this.onClose()
      })
    }

  }
  // 确认修改
  onEdit = () => {
     if(this.editNote===""){
       this.onDelete()
       return
       }
    this.originNoteList[this.editIndex].updateTime = new Date().getTime()
    this.originNoteList[this.editIndex].content = this.editNote
    this.NoteTable.updateData(this.originNoteList[this.editIndex], () => {
      this.note = this.originNoteList
      this.onOrderChanged()
      this.onClose()
    })
  }

  // 页面初始化
  aboutToAppear(): void {
    this.isAdd = false
    this.isEdit = false
    this.originNoteList = []
    this.note = []
    this.editIndex = -1
    this.searchText = ""
    this.addNote = ""
    this.editNote = ""
    // 初始化排序
    PreferencesUtil.getChangeSort().then((value) => {
      this.order = (value as number) === 1 ? true:false;
    })
    // 初始化字体大小
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.fontSize = value as number;
    })
    // 初始化应用风格
    PreferencesUtil.getChangeStyle().then((value) => {
      this.appStyle = value as number;
    })
    PreferencesUtil.getChangeColor().then((value) => {
      this.appTheme = value as number;
      if(this.appTheme==0){
        setAutoColorMode(this.context)
      }
      else if(this.appTheme==1){
        setLightColorMode(this.context)
      }
      else{
        setDarkColorMode(this.context)
      }
    })

    this.NoteTable.getRadState(() => {
      this.NoteTable.query((date: NoteDataModel[]) => {
        this.originNoteList = date
        this.note = this.originNoteList
        this.onOrderChanged()
      })
    })
  }

  //打开笔记页面
  getNote(note: NoteDataModel){

    this.pathStack.pushPathByName('Note',note, (popInfo) => {
      console.log("114514")
//      console.log('Pop page name is: ' + popInfo.info.name + ', result: ' + JSON.stringify(popInfo.result))
      if(popInfo.result){

        if(popInfo.result['id']==-1){
          this.addNote = popInfo.result['content']
          this.onCreate()
        }
        else{
          this.editNote = popInfo.result['content']
          this.onEdit()
        }
      }
    })
  }

  // 跳转设置页面
  getSetting(){
    this.pathStack.pushPathByName("Setting",{},(popInfo)=>{
      console.log("114514")
      // PreferencesUtil.getChangeSort().then((value) => {
      //   console.log("114514")
      //   this.order = (value as number) === 1 ? true:false;
      // })
      this.order = popInfo.result['order'] === 1 ? true:false;
      this.appStyle = popInfo.result['appStyle']
      this.fontSize = popInfo.result['fontSize']
      this.appTheme = popInfo.result['theme']
    })
  }

  // 删除按钮
  @Builder
  getListEnd(item:NoteDataModel){
    Button() {
      Image($r('app.media.delete'))
        .width(40)
        .height(40)
    }
    .backgroundColor('#d9d9d9')
    .width(50)
    .height(50)
    .onClick(()=>{
      this.editIndex = this.originNoteList.indexOf(item)
      this.onDelete()
    })
  }

  // onPageShow(): void {
  //   console.log("onPageShow")
  //   const value: object | null = this.getUIContext().getRouter().getParams();
  //   if(value?.['note']&&value['boolean']===true){
  //     this.addNote = value['note'].content
  //     this.onCreate()
  //   }
  // }

  build() {
    NavDestination() {
      Stack() {
        Column({ space: 10 }) {
          // 顶部标题
          Column({ space: 8 }) {
            Column({ space: 6 }) {
              Column() {
                Blank()
                Image($r("app.media.Setting"))
                  .width(32)
                  .onClick(()=>{
                    // 跳转设置页面
                    this.getSetting()
                  })
                  .fillColor($r("app.color.some_icons"))
              }.width("100%").height(32).alignItems(HorizontalAlign.End)

              Text("便签").fontSize(40)
              // 搜索框
              components_search({ searchText: this.searchText, clean: this.clean, todoEditStatus: this.aUselessVariableForSearchText })
                .width('100%')
            }
            .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
            .width('100%')
            .height(165)
            .alignItems(HorizontalAlign.Start)
            .padding(16)
          }.height('23%')
          .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
          .width('100%')

          // 主体内容
          Column({ space: 0 }) {
            List({ space: 6 }) {
              ForEach(this.note, (item: NoteDataModel) => {
                ListItem() {
                  Item_NoTe({ note: item, onNoteClick: this.onNoteEdit,fontSize:this.fontSize })
                }
                .swipeAction({
                  end: {
                    builder:()=>{
                      this.getListEnd(item)
                    }
                  }
                })

              })
            }.alignListItem(ListItemAlign.Center) // 元素布局
            .height('100%')
          }.height('77%')
        }
        .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        .width('100%')
        .height('100%')

        // 新建弹窗
        if (this.isAdd) {
          CustomAddDialog({
            edit: this.addNote,
            onClose: this.onClose,
            onCreate: this.onCreate
          })
            .height('100%')
            .width('100%')
            .zIndex(4)
        }

        // 编辑弹窗
        if (this.isEdit) {
          CustomEditDialog({
            edit: this.editNote,
            onClose: this.onClose,
            onDelete: this.onDelete,
            onCreate: this.onEdit
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
        .width(50) // 与图片宽度一致
        .height(50) // 与图片高度一致
        .position({ x: '75%', y: '90%' })
        .backgroundColor('transparent') // 设置背景颜色为透明
        .zIndex(3)
        .onClick(() => {
          // 添加逻辑
          // this.isAdd = true
          console.log("add")
          if(this.appStyle==2){
            this.getNote(new NoteDataModel(-1, Date.now(), ""))
          }
          else this.isAdd = true
        })
      }
      .height('100%')
    }
  }
}

