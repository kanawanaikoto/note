

export class TaskDataModel {
  private tasks:Array<string> = [
    "Task1",
    "Task2",
    "Task3",
    "Task4",
    "Task5",
    "Task6",
    "Task7",
    "Task8",
    "Task9",
    "Task10",
    "Task11",
  ]
  private isCompleted:Array<boolean> = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ]
  public getData():Array<string> {
    return this.tasks;
  }
  public getIsCompleted():Array<boolean> {
    return this.isCompleted;
  }
  public setIsCompleted(index:number,isCompleted:boolean) {
    this.isCompleted[index] = isCompleted;
  }
  public getTask(index:number):string {
    return this.tasks[index];
  }
}
