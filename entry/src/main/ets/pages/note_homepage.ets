   import CustomEditDialog from "../components/CustomEditDialog"
   import Item_NoTe from "../components/Item_NoTe"
   import NoteDataModel from "../model/NoTeModels"

   @Entry
   @Component
   export default struct note_homepage {

     @State note: NoteDataModel[] = [
       new NoteDataModel(1, 1706326302150, "hello world"),
       new NoteDataModel(2, 1706326302150, "hello world"),
       new NoteDataModel(3, 1706326302150, "hello world"),
     ]

     @State isEditDone: boolean = false
     @State editContent: string = ""

     onClose = () => {
       this.isEditDone = false
     }

     onCreate = () => {
       this.isEditDone = false
     }

     build() {
       Stack({ alignContent: Alignment.BottomEnd }) {
         Column({ space: 10 }) {
           // 顶部标题
           Column({ space: 8 }) {
             Column({ space: 8 }) {
               Column() {
                 Blank()
                 Image($r("app.media.Setting")).width(32)
               }.width("100%").height(32).alignItems(HorizontalAlign.End)

               Text("便签").fontSize(40).fontColor("#2c2c2c")

               // 搜索框
               TextInput({
                 placeholder: '搜索'
               })
               .width('92%')
               .height(40)
               .borderWidth(1)
               .borderColor(Color.White)
               .borderRadius(8)
               .padding(10)
               .margin({ left: 16, right: 16, bottom: 20 })
             }.backgroundColor(Color.White)
             .width('100%')
             .height(165)
             .alignItems(HorizontalAlign.Start)
             .padding(16)

             // 主体内容
             List({ space: 6 }) {
               ForEach(this.note, (item: NoteDataModel) => {
                 ListItem() {
                   Item_NoTe({ note: item })
                 }
               })
             }.alignListItem(ListItemAlign.Center) // 元素布局
           }
         }.backgroundColor('#F1F3F5')
         .width('100%')
         .height('100%')

         // 弹窗
         if (this.isEditDone) {
           CustomEditDialog({
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
         })
       }
     }
   }
   