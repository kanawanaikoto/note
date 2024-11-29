
@Component
export default struct SearchBar {
  @Link searchText: string
  clean: () => void= ()=>{}
  build() {
      Row(){
        Image($r('app.media.search')).width(16).margin({ left: 10})
        TextInput({
          placeholder: '请输入搜索内容',
          text: this.searchText,
        })
          .onChange((value: string)=>{
            this.searchText = value
          })
          //.backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        if(this.searchText){
          Image($r('app.media.close'))
            .margin({right: 10})
            .width(16)
            .onClick(()=>{
              this.clean()
          })
        }
      }
      .padding({ right: 52})
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
      .borderRadius(24)// 圆角
      .width('100%')
  }
}

@Preview
@Component
struct SearchBarPreview {
  @State searchText: string = "114514"
  build() {
    SearchBar({ searchText: this.searchText})
  }
}