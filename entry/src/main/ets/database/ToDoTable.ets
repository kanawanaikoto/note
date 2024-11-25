import CommonConstants from "../constants/CommonConstants";
import { Task } from "../model/ToDoModels";
import Rdb from "../database/Rdb"
import { relationalStore } from "@kit.ArkData";

/**
 * NoteDataModel类提供了对笔记数据的基本操作，包括插入、删除、更新和查询
 * 它通过Rdb类与底层数据库进行交互
 */
export default class ToDoTable{

  // 数据库 使用常量文件“CommonConstants”中配置的参数
  private noteTable = new Rdb(CommonConstants.TODO_TABLE.tableName, CommonConstants.TODO_TABLE.sqlCreate, CommonConstants.TODO_TABLE.columns);

  /**
   * 构造函数
   * @param callback 初始化时调用的回调函数，用于获取数据库状态
   */
  constructor(callback:Function = ()=>{}) {
    this.noteTable.getRdbStore(callback);
  }

  /**
   * 获取数据库状态
   * @param callback 调用的回调函数，用于获取数据库状态
   */
  getRadState(callback:Function = ()=>{}){
    this.noteTable.getRdbStore(callback)
  }

  /**
   * 插入笔记数据
   * @param data 要插入的笔记数据
   * @param callback 插入操作完成后的回调函数
   */
  insertData(data:Task, callback:Function = ()=>{}){
    const valueBucket: relationalStore.ValuesBucket = generateBucket(data);
    this.noteTable.insertData(valueBucket, callback);
  }

  /**
   * 删除笔记数据
   * @param data 要删除的笔记数据，根据id进行匹配
   * @param callback 删除操作完成后的回调函数
   */
  deleteData(data:Task, callback:Function = ()=>{}){
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TODO_TABLE.tableName);
    predicates.equalTo('id', data.id);
    this.noteTable.deleteData(predicates, callback);
  }

  /**
   * 更新笔记数据
   * @param data 要更新的笔记数据，根据id进行匹配
   * @param callback 更新操作完成后的回调函数
   */
  updateData(data:Task, callback:Function = ()=>{}){
    const valueBucket: relationalStore.ValuesBucket = generateBucket(data);
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TODO_TABLE.tableName);
    predicates.equalTo('id', data.id);
    this.noteTable.updateData(predicates, valueBucket, callback);
  }

  /**
   * 查询笔记数据
   * @param callback 查询操作完成后的回调函数，返回查询结果
   */
  query(callback:Function = ()=>{}){
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TODO_TABLE.tableName);
    this.noteTable.query(predicates, (resultSet: relationalStore.ResultSet)=>{
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result: Task[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: Task = new Task(0,"",0);
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.task = resultSet.getString(resultSet.getColumnIndex('task'));
          tmp.complete = resultSet.getDouble(resultSet.getColumnIndex('complete'));
          result[i]= tmp;
          resultSet.goToNextRow();
        }

        callback(result);
      }
    });
  }
}

/**
 * 生成用于数据库操作的ValuesBucket对象
 * @param 笔记数据对象
 * @returns 返回包含笔记数据的ValuesBucket对象
 */
function generateBucket(note: Task): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.task = note.task
  obj.complete = note.complete
  return obj;
}
