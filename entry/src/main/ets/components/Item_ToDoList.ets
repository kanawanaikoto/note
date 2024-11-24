import { Task, TodoModels} from '../model/ToDoModels';
import ToDoList from '../pages/ToDoList';

@Component
export default struct Item_ToDoList{// 待办事项

  private task_content: Task = {index: 0, task: ""}

  @Link task_content_tmp: Task // 连接到src/main/ets/components/TabsView.ets

  @State isComplete:boolean = false

  @Consume ifListEditing: boolean //接受来自父界面（index）的数据
  @Consume IndexOfListChanging: number //接受来自父界面（index）的数据

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
            if (this.isComplete) {
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
            this.isComplete = !this.isComplete
          })
        }
        .width('20%')
        .height('100%')

        //文字部分
        if (this.ifListEditing && this.task_content.index === this.IndexOfListChanging) {
          Column() {
            TextInput({
              placeholder: this.task_content.task,
              text: this.task_content.task
            })
              .onChange((strIn: string) => {
                this.task_content.task = strIn
                this.task_content_tmp = this.task_content
              })
          }
          .width('70%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

        } else {
          Column() {
            //this.TaskDataModel.changeDataByIndex(this.task_content.task,this.task_content.index)
            Text(this.task_content.task)
              .decoration({ type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None })// 删除线
              .opacity(this.isComplete ? 0.5 : 1)// 透明度
              .fontSize(20)// 字体大小
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
      .backgroundColor(Color.White) // 背景色
      .width("90%") // 宽度
      .height(60) // 高度
      .onClick(() => { //文本编辑
        this.ifListEditing = true
        this.IndexOfListChanging = this.task_content.index
      })
    }
}
@Preview
@Component
struct Test{
  build() {
    Column() {
      test1()
    }
  }
}

@Component
struct test1{
  @Provide ifListEditing: boolean = false
  @State tt1: Task = { index: 0, task: "" }
  build() {
    Column() {
      Item_ToDoList({ task_content_tmp:  this.tt1})
    }
  }
}