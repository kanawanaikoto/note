
import ToDoTable from "../database/ToDoTable"

@Observed
export class  Task{
  id: number =0
  task: string =''
  complete: number =0// 是否完成
  constructor(id: number, task: string, complete: number) {
    this.id = id
    this.task = task
    this.complete = complete
  }
}

@Observed
export class TodoModels{

  private todotable: ToDoTable = new ToDoTable()
  private todo: Task[] = []

  constructor() {
    this.todotable.query((data: Task[])=>{
      this.todo = data
    })
  }
  public getData():Array<Task> {
    return this.todo
	}
  public addData(data:string):void {
    let task: Task = new Task(0, data, 0)
    this.todotable.insertData(task, (id: number)=>{
      task.id = id
      this.todo.push(task)
    })
  }
  // 修改
  public changeDataByIndex(data: string, index: number){
    let i = 0
    for(;i<this.todo.length;i++){
      if(this.todo[i].id === index){
        break
      }
    }
    this.todotable.updateData(this.todo[i], ()=>{
      this.todo[i].task = data
    })
  }

  // 删除
  public deleteDataByIndex(index: number){
    let i = 0
    for(;i<this.todo.length;i++){
      if(this.todo[i].id === index){
        break
      }
    }
    this.todotable.deleteData(this.todo[i], ()=>{
      this.todo.splice(i, 1)
    })
  }
}
