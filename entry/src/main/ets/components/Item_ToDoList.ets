
@Component
export default struct Item_ToDoList{// 待办事项

  private task_content:string = "待办事项" // 待办事项内容

  @State isComplete:boolean = false

  @Builder
  CreateIcon(icon:Resource){ // 图标
    Image(icon)
      .width(28)
      .height(28)
      .objectFit(ImageFit.Contain)
      .margin(20)
  }

  build() {
    Row(){
      //icon
      if(this.isComplete) {
        this.CreateIcon($r("app.media.ic_ok"))
      } else {
        this.CreateIcon($r("app.media.ic_ok_f"))
      }
      Text(this.task_content)
        .decoration({type:this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None}) // 删除线
        .opacity(this.isComplete ? 0.5 : 1) // 透明度
        .fontSize(20)// 字体大小
        .fontWeight(500)// 加粗
        .onClick(()=>{
          //点击事件
          console.log("点击事件")
        })
    }
    .borderRadius(24)// 圆角
    .backgroundColor(Color.White)// 背景色
    .width("90%")// 宽度
    .height(60)// 高度
    .onClick(()=>{
      this.isComplete = !this.isComplete
    })
  }
}