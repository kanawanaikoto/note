@Entry
@Component
export default struct note_homepage{
  build() {
     Column() {
       // 顶部标题
       Column(){
         Column(){
           Blank()
           Image($r("app.media.Setting")).width(32)
         }.width("100%").height(32).alignItems(HorizontalAlign.End)
         Text("便签").fontSize(40).fontColor("#2c2c2c")
       }.backgroundColor(Color.White)
        .width('100%')
        .height(110)
        .alignItems(HorizontalAlign.Start)
        .padding(16)

       //搜索框
       TextInput({ placeholder: '搜索' })
          .width('92%')
          .height(40)
          .borderWidth(1)
          .borderColor(Color.Grey)
          .borderRadius(8)
          .padding(10)
          .margin({ left: 16, right: 16, bottom: 20 })
     }.width('100%')
      .height('100%')
      .backgroundColor("#F1F3F5")
  }
}