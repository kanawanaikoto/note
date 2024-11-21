
@Observed
export default class NoteDataModel{

  id:number = 0

  updateTime:number = 0

  content:string = ""

  constructor(id:number,updateTime:number,content:string){
    this.id = id
    this.updateTime = updateTime
    this.content = content

  }
}
