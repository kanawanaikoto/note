import { window } from "@kit.ArkUI"


@Component
export default struct CustomAddDialog{
  @Link edit:string

  @State screenHeight: number = 0;
  @State isKeyBoardHidden: boolean = false;


  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then(currentWindow => {
      let property = currentWindow.getWindowProperties();
      let avoidArea = currentWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      // 初始化显示区域高度
      this.screenHeight = px2vp(property.windowRect.height - avoidArea.topRect.height - avoidArea.bottomRect.height);
      // 监视软键盘的弹出和收起
      currentWindow.on('avoidAreaChange', async data => {
        if (data.type !== window.AvoidAreaType.TYPE_KEYBOARD) {
          return;
        }
        if (data.area.bottomRect.height <= 0) {
          this.isKeyBoardHidden = true;
        } else {
          this.isKeyBoardHidden = false;
        }
        this.screenHeight = px2vp(property.windowRect.height - avoidArea.topRect.height - data.area.bottomRect.height);
      })
    })
  }

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
          })
            .defaultFocus(true)
            .height('100%')
            .onChange((value)=>{
            this.edit = value
          })
        }
        .height('75%')
        .padding(8)

        // 底部按钮
        Row(){
          // 取消
          Column(){
            Image($r('app.media.back')).width(30).fillColor($r("app.color.some_icons"))
          }
          .onClick(()=>{
            this.onClose()
          })
          .backgroundColor($r("app.color.txt_color_2"))
          .width(50)
          .height(50)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)

          // 确定
          Column(){
            Image($r('app.media.save')).width(30).fillColor($r("app.color.some_icons"))
          }
          .onClick(()=>{
            this.onCreate()
          })
          .backgroundColor($r("app.color.txt_color_2"))
          .width(50)
          .height(50)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
        }
        .margin({bottom: 20})
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')


      }
      .width('90%')
      .height('43%')
      .borderRadius(16) // 弹窗圆角
      .backgroundColor($r("app.color.search_bar"))
      .margin(8)
      .position({ x: '3.5%', y: '46%' })

    }
    .width('100%')
    .height(this.screenHeight) // 动态设置可视区域高度
    .alignContent(Alignment.Bottom)
  }
}

@Preview
@Component
struct CustomEditDialogPreview {
  @State edit:string = 'hello'
  build() {
    CustomAddDialog({edit:this.edit})
  }
}
