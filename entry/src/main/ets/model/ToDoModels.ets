
@Observed
export class TodoModels {
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

  public getData():Array<string> {
    return this.tasks;
  }
  public addData(data:string):void {
    this.tasks.push(data);
  }

}
