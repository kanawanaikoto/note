import NoteDataModel from "../model/NoTeModels"

interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

// 时间格式化
function getFormatTime(time: number): TimeFormat {
  const date = new Date(time)
  const today = new Date()
  const diff = today.getTime() - date.getTime()
  const diffDay = Math.floor(diff / (24 * 60 * 60 * 1000))
  let range: string
  if (diffDay === 0) {
    range = "今天"
  } else if (diffDay === 1) {
    range = "昨天"
  } else if (diffDay > 1 && diffDay <= 7) {
    range = "本周"
  } else {
    range = date.toLocaleDateString()
  }
  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hour: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hour}:${minute}`

  return {
    range: range,
    formatDate: formatDate,
    formatTime: formatTime
  }
}

@Component
export default struct Item_NoTe {

  @ObjectLink note: NoteDataModel

  onNoteClick : (note: NoteDataModel) => void = ()=>{}

  build() {
    Row(){
      Stack() {
        Row() {
          // 左侧阴影
          Column() {
          }
          .width(26)
          .height(90)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#d9d9d9', 0.5], ['#d9d9d9', 0.1]]
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
                .fontSize(12)
                .fontColor('#ff303030')
              Text(getFormatTime(this.note.updateTime).formatDate)
                .fontSize(12)
                .fontColor('#ff303030')
              Text(getFormatTime(this.note.updateTime).formatTime)
                .fontSize(12)
                .fontColor('#ff303030')
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
                .fontColor('#808080')
                .maxLines(2)
                .margin({ right: 10 })
            }
            .height(64)
            .justifyContent(FlexAlign.Center)
            .margin({ left: 10 })

          }
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#ffffff', 0.5], ['#ffffff', 0.1]]
          })
          .height(90)
          .borderRadius({ topRight: 4, bottomRight: 4 })
          .margin({ right: 27 })
        }
       }
       .onClick(()=>{
         this.onNoteClick(this.note)
       })
    }
    .padding({ left: 20,right: 20})
  }
}

@Preview
@Component
struct Item_NoTePreview {
  @State note: NoteDataModel = new NoteDataModel(1, 1732203931481, "hello world")
  build() {
    Item_NoTe({
      note: this.note
    })
  }
}
