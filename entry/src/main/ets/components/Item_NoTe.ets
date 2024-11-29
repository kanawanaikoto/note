import NoteDataModel from "../model/NoteModel"
import getFormatTime from '../function/FormatTime'
import PreferencesUtil from "../database/PreferencesUtil"

@Preview
@Component
export default struct Item_NoTe {
  @ObjectLink note: NoteDataModel
  @Link fontSize: number
  onNoteClick: (note: NoteDataModel) => void = () => {
  }

  // aboutToAppear(): void {
  //   PreferencesUtil.getChangeFontSize().then((value) => {
  //     this.fontSize = value as number;
  //     console.log("fontSize: " + this.fontSize);
  //   })
  // }

  build() {
    Row() {
      Stack() {
        Row() {
          // 左侧阴影
          Column()
            .width(26)
            .height(90)
            .linearGradient({
              direction: GradientDirection.Bottom,
              colors: [[$r('app.color.some_icons'), 0.5], [$r('app.color.some_icons'), 0.1]]
            })
            .borderRadius({ topLeft: 4, bottomLeft: 4 })
          Divider()
            .vertical(true)
            .width(1)
            .height(90)
            .backgroundColor('#d9d9d9')

          // 内容
          Column() {
            // 时间
            Row({ space: 10 }) {
              Text(getFormatTime(this.note.updateTime).range)
                .fontSize(this.fontSize * 0.8)
                //.fontColor('#ff303030')
              Text(getFormatTime(this.note.updateTime).formatDate)
                .fontSize(this.fontSize * 0.8)
                //.fontColor('#ff303030')
              Text(getFormatTime(this.note.updateTime).formatTime)
                .fontSize(this.fontSize * 0.8)
                //.fontColor('#ff303030')
            }
            .margin({ left: 10 })
            .height(20)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            // 分割线
            Divider()
              .height(1)
              .width('100%')
              .color('#ff303030')

            // 正文
            Column() {
              Text(this.note.content)
                //.fontColor('#808080')
                .fontSize(this.fontSize)
                .maxLines(2)
                .margin({ right: 10 })
            }
            .height(64)
            .justifyContent(FlexAlign.Center)
            .margin({ left: 10 })

          }
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [[$r('sys.color.comp_background_list_card')
              , 0.5], [$r('sys.color.comp_background_list_card')
              , 0.1]]
          })
          .height(90)
          .borderRadius({ topRight: 4, bottomRight: 4 })
          .margin({ right: 27 })
        }
      }
      .onClick(() => {
        console.log('Item_NoTe onClick')
        this.onNoteClick(this.note)
      })
    }
    .padding({ left: 20, right: 20 })
  }
}


