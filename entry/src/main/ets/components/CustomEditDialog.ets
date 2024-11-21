

@Component
export default struct CustomEditDialog{

  @Link edit:string

  onClose: ()=>void =()=> {}
  onCreate: ()=>void =()=> {}

  build() {
    Stack({alignContent: Alignment.Bottom}) {
      Rect()
      .height('100%')
      .width('100%')
      .fill('rgba(0,0,0,0.5)')
      .onClick(()=>{
        // 点击背景，关闭弹窗
        this.onClose()
      })
      Column(){
        Column(){
          TextArea({
            placeholder: '请输入内容',
            text: this.edit
          }).height('100%').onChange((value)=>{
            this.edit = value
          })
        }
        .height('75%')
        .padding(20)

        // 底部按钮
        Row(){
          // 取消
          Column(){
            Image($r('app.media.back')).width(24)
          }
          .onClick(()=>{
            this.onClose()
          })
          .backgroundColor('#F1F3F5')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)

          // 确定
          Column(){
            Image($r('app.media.save')).width(24)
          }
          .onClick(()=>{
            this.onCreate()
          })
          .backgroundColor('#F1F3F5')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')


      }
      .width('90%')
      .height('40%')
      .borderRadius(16) // 弹窗圆角
      .backgroundColor(Color.White)
      .margin(8)

    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)
  }
}

@Preview
@Component
struct CustomEditDialogPreview {
  @State edit:string = 'hello'
  build() {
    CustomEditDialog({edit:this.edit})
  }
}
