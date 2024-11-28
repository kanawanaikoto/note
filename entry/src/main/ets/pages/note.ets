
import getFormatTime from '../function/FormatTime';
import NoteDataModel from '../model/NoteModel';

@Builder
export function getNote() {
  CodeGenieNotepad()
}

@Entry
@Component
struct CodeGenieNotepad {
  // 确认保存标志
  boolean = false
  pathStack: NavPathStack = AppStorage.get("PathStack") as NavPathStack
  @State private note: NoteDataModel = new NoteDataModel(1, Date.now(), '')
  private value: object | null = null

  aboutToAppear(): void {
    console.log("Note_aboutToAppear");

    // 获取传递过来的参数
    this.value = this.pathStack.getParamByIndex(0) as NoteDataModel;
    if (this.value && this.value instanceof NoteDataModel) {
      this.note = this.value;
    }
  }


  onClose: () => void = () => {
    // 处理关闭逻辑
    if(this.boolean){
      this.pathStack.pop(this.note);
    }
    else this.pathStack.pop();
  }

  onCreate: () => void = () => {
    this.boolean = true
    this.onClose()
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.back_2')).width(24)
            .onClick(() => {
              this.onClose();
            })
          Blank()
          Image($r('app.media.save')).width(24)
            .onClick(() => {
              this.onCreate();
            })
        }
        .margin(20)
        .width('90%')

        Row({ space: 10 }) {
          Text(getFormatTime(this.note.updateTime).range)
          Text(getFormatTime(this.note.updateTime).formatDate)
          Text(getFormatTime(this.note.updateTime).formatTime)
          Text(`字数${this.note.content.length}`)
        }
        .alignItems(VerticalAlign.Bottom)

        TextArea({
          placeholder: '请输入内容',
          text: this.note.content
        }).height('100%')
          .width('100%')
          .defaultFocus(true)
          .onChange((value) => { // 更新数据
            this.note.content = value
          })
      }
      .height('100%')
      .width('100%')
    }
    .hideTitleBar(true)
    .height('100%')
    .width('100%')
  }
}
