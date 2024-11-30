
@Component
export default struct SearchBar {
  @Link searchText: string
  @Link todoEditStatus: number|null
  clean: () => void= ()=>{}
  build() {
      Row(){
        Image($r('app.media.search')).width(16).margin({ left: 10}) .fillColor($r("app.color.some_icons"))
        TextInput({
          placeholder: '请输入搜索内容',
          text: this.searchText,
        })
          .onChange((value: string)=>{
            this.searchText = value
          })
          .onClick(()=>{
            this.todoEditStatus = null
          })
          .backgroundColor($r( 'app.color.search_bar'))
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
      .backgroundColor($r('app.color.search_bar'))
      .borderRadius(24)// 圆角
      .width('100%')
  }
}

@Preview
@Component
struct SearchBarPreview {
  @State searchText: string = "114514"
  build() {
    SearchBar({ searchText: this.searchText, todoEditStatus: null})
  }
}