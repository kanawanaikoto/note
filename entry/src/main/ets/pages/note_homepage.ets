import components_search from "../components/components_search"
import CustomAddDialog from "../components/CustomAddDialog"
import CustomEditDialog from "../components/CustomEditDialog"
import Item_NoTe from "../components/Item_NoTe"
import NoteDataModel from "../model/NoTeModels"

   @Entry
   @Component
   export default struct note_homepage {

      // 原始数据
     originNoteList : NoteDataModel[] = []

     // 显示数据
     @State note: NoteDataModel[] = []

     // 搜索框内容
     @State @Watch('onsearchText') searchText: string = ""

     // 清空搜索框
     clean = () => {
       this.searchText = ""
     }

     // 搜索框内容改变
     onsearchText(){
       if(this.searchText.length===0){
         this.note = this.originNoteList
         this.onOrderChanged()
       } else {
         let result: NoteDataModel[] = []
         for(const i of this.originNoteList){
           if(i.content.includes(this.searchText)){
             result.push(i)
           }
         }
         this.note = result

       }
     }

     // 排序
     @State @Watch('onOrderChanged') order:boolean = false

      // 排序
      onOrderChanged() {
        if (this.order) {
          this.note = this.originNoteList.sort((a, b) => b.updateTime - a.updateTime)
        } else {
          this.note = this.originNoteList.sort((a, b) => a.updateTime - b.updateTime)
        }
      }

     // 新建便签弹窗
     @State isAdd: boolean = false

     // 新建便签内容
     @State addNote: string = ""

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
       const note: NoteDataModel = new NoteDataModel(this.note.length+1, Date.now(), this.addNote)
       this.originNoteList.push(note)
       this.note=this.originNoteList
       this.onOrderChanged()
       this.onClose()
     }

     // 编辑内容
     @State editNote: string = ""

     // 编辑弹窗开关
     @State isEdit: boolean = false

     // 编辑索引
     @State editIndex: number = -1

     // 编辑弹窗
     onNoteEdit = (note: NoteDataModel)=>{
       for(let i=0;i<this.originNoteList.length;i++)
       {
         if(this.originNoteList[i].id===note.id){
           this.editNote = this.originNoteList[i].content
           this.editIndex = i
           break
         }
       }
       this.isEdit = true
     }

     // 删除
     onDelete=()=> {
       this.originNoteList.splice(this.editIndex,1)
       this.note=this.originNoteList
       this.onOrderChanged()
       this.onClose()
     }

     // 确认修改
     onEdit=()=> {
       this.originNoteList[this.editIndex].updateTime = new Date().getTime()
       this.originNoteList[this.editIndex].content = this.editNote
       this.note=this.originNoteList
       this.onOrderChanged()
       this.onClose()
     }

     // 页面初始化
     aboutToAppear(): void {
       for(let i = 0; i < 10; i++){
         const date :Date = new Date()
         const item :NoteDataModel = new NoteDataModel(i, date.getTime()+i, `${i+1} 笔记`)
         this.originNoteList.push(item)
       }
       this.onOrderChanged()
     }

     build() {
       Stack() {
         Column({ space: 10 }) {
           // 顶部标题
           Column({ space: 8 }) {
             Column({ space: 6 }) {
               Column() {
                 Blank()
                 Image($r("app.media.Setting")).width(32)
               }.width("100%").height(32).alignItems(HorizontalAlign.End)

               Text("便签").fontSize(40).fontColor("#2c2c2c")

               // 搜索框
               components_search({ searchText: this.searchText,clean: this.clean})
                 .width('100%')
             }.backgroundColor(Color.White)
             .width('100%')
             .height(165)
             .alignItems(HorizontalAlign.Start)
             .padding(16)
           }.height('23%')
            .backgroundColor(Color.White)
            .width('100%')

           // 主体内容
           Column({space: 0}){
             List({ space: 6 }) {
               ForEach(this.note, (item: NoteDataModel) => {
                 ListItem() {
                   Item_NoTe({ note: item , onNoteClick: this.onNoteEdit})
                 }
               })
             }.alignListItem(ListItemAlign.Center) // 元素布局
              .height('100%')
           }.height('77%')
         }.backgroundColor('#F1F3F5')
         .width('100%')
         .height('100%')

         // 新建弹窗
         if (this.isAdd) {
           CustomAddDialog({
             edit: this.addNote,
             onClose: this.onClose,
             onCreate: this.onCreate
           }).zIndex(4)
         }

         // 编辑弹窗
         if (this.isEdit) {
           CustomEditDialog({
             edit: this.editNote,
             onClose: this.onClose,
             onDelete: this.onDelete,
             onCreate: this.onEdit
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
           // 添加逻辑
           this.isAdd = true
         })
       }
       .height('100%')
     }
   }
   