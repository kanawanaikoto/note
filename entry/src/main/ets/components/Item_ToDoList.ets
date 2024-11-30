import { Task } from '../model/ToDoModels';


@Component
export default struct Item_ToDoList{// 待办事项

  @ObjectLink task: Task

  @Link IndexOfListChanging: number|null
  @Link IndexOfListChangedBefore: number|null

  @Link fontSize: number

  @State ifOnFocus: boolean = false

  @Builder
  CreateIcon(icon:Resource){ // 图标
    Image(icon)
      .width(28)
      .height(28)
      .objectFit(ImageFit.Contain)
      .margin(20)
  }

  build() {
      Row() {
        //按钮部分
        Column() {
          Button() {
            if (this.task.complete!==0) {
              Image($r("app.media.ic_ok"))
                .width(30)
                .height(30)
            } else {
              Image($r("app.media.ic_ok_f"))
                .width(30)
                .height(30)
            }
          }
          .backgroundColor('transparent')
          .position({ x: '10%' })
          .width(30)
          .height('100%')

          .onClick(() => {
            this.task.complete = this.task.complete === 0 ? 1 : 0
          })
        }
        .width('20%')
        .height('100%')

        //文字部分
        if (this.task.id === this.IndexOfListChanging) {
          Column() {
            TextInput({
              placeholder: this.task.task,
              text: this.task.task
            })
              .defaultFocus(true)
              .focusable(this.ifOnFocus)
              .fontSize(this.fontSize)
              .defaultFocus(true)
              .id('task_input')
              .onChange((strIn: string) => {
                this.task.task = strIn
                // if (strIn.length === 0)
                //   this.IndexOfListChangedBefore = this.task.id
              })
              .onBlur(()=>{
                if (this.task.task.length === 0)
                  this.IndexOfListChangedBefore = this.task.id
              })
              .onAppear(()=>{
                focusControl.requestFocus('task_input')
              })

          }
          .width('70%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

        } else {
          Column() {
            //this.TaskDataModel.changeDataByIndex(this.task_content.task,this.task_content.index)
            Text(this.task.task)
              .decoration({ type: this.task.complete===1 ? TextDecorationType.LineThrough : TextDecorationType.None })// 删除线
              .opacity(this.task.complete===1 ? 0.5 : 1)// 透明度
              .fontSize(this.fontSize)// 字体大小
              .fontWeight(500) // 加粗
          }
          .width('70%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .colorBlend(Color.Black)
        }
      }
      .borderRadius(24) // 圆角
      .backgroundColor($r('sys.color.comp_background_list_card')) // 背景色
      .width("90%") // 宽度
      .height(60) // 高度
      .onClick(() => { //文本编辑
        this.IndexOfListChanging = this.task.id
        this.ifOnFocus = true
      })
    }
}
