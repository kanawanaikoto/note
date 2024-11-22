
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
          .backgroundColor('#F1F3F5')
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
      .backgroundColor('#F1F3F5')
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