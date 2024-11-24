import ToDoList from "../pages/ToDoList"

export interface  Task{
  index: number
  task: string
}
@Observed
export class TodoModels{
  private static tasks:Array<Task> = [{index: 1, task: 'Task1'}]
  private tasks_tmp:Array<Task>
  private static index: number = 2 //为每个待办事项编号

  constructor() {
    this.tasks_tmp = TodoModels.tasks
  }
  public getData():Array<Task> {
    return this.tasks_tmp
  }
  public addData(data:string):void {
    TodoModels.tasks.push({index: TodoModels.index, task: data})
    this.tasks_tmp = TodoModels.tasks
    TodoModels.index++;
  }
  public changeDataByIndex(data: string, index: number){
    let i: number = 0
    for(i;i<TodoModels.tasks.length;i++){
      if(TodoModels.tasks[i].index == index){
        TodoModels.tasks[i].task = data
        break
      }
    }
    this.tasks_tmp = TodoModels.tasks
  }
}
