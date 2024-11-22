import relationalStore from '@ohos.data.relationalStore';
import CommonConstants from '../constants/CommonConstants';
import Logger from '../utils/Logger';

/**
 * Rdb 类用于操作关系型数据库。
 * 提供了初始化数据库连接、插入、删除、更新和查询数据的方法。
 */
export default class Rdb {

  /**
   * 当前数据库连接对象。
   */
  private rdbStore: relationalStore.RdbStore | null = null;

  /**
   * 数据库表名。
   */
  private tableName: string;

  /**
   * 创建表的 SQL 语句。
   */
  private sqlCreateTable: string;

  /**
   * 表的列名数组。
   */
  private columns: Array<string>;

  /**
   * 构造函数，初始化 Rdb 实例。
   * @param tableName - 表名
   * @param sqlCreateTable - 创建表的 SQL 语句
   * @param columns - 表的列名数组
   */
  constructor(tableName: string, sqlCreateTable: string, columns: Array<string>) {
    this.tableName = tableName;
    this.sqlCreateTable = sqlCreateTable;
    this.columns = columns;
  }

  /**
   * 获取数据库连接。
   * @param callback - 回调函数，当操作完成时调用
   */
  getRdbStore(callback: Function = () => {}) {

    // 判断回调函数是否为函数类型
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(CommonConstants.RDB_TAG, 'getRdbStore() has no callback!');
      return;
    }

    // 判断是否已经存在连接对象
    if (this.rdbStore !== null) {
      Logger.info(CommonConstants.RDB_TAG, 'The rdbStore exists.');
      callback();
      return;
    }

    //

    // 获取上下文对象
    let context: Context = getContext(this) as Context;

    /*
      获取RdbStore接口的方法，接收三个参数
      context  ：应用上下文
      config   ：数据库配置
      callback ：回调函数，异步返回rdb对象
    */
    relationalStore.getRdbStore(context, CommonConstants.STORE_CONFIG, (err, rdb) => {
      if (err) {
        Logger.error(CommonConstants.RDB_TAG, `getRdbStore() failed, err: ${err}`);
        return;
      }

      this.rdbStore = rdb;
      this.rdbStore.executeSql(this.sqlCreateTable);

      Logger.info(CommonConstants.RDB_TAG, 'getRdbStore() finished.');
      callback();
    });
  }

  /**
   * 插入数据到指定表。
   * @param data - 要插入的数据
   * @param callback - 回调函数，当操作完成时调用
   */
  insertData(data: relationalStore.ValuesBucket, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(CommonConstants.RDB_TAG, 'insertData() has no callback!');
      return;
    }

    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;

    if (this.rdbStore) {
      this.rdbStore.insert(this.tableName, valueBucket, (err, ret) => {
        if (err) {
          Logger.error(CommonConstants.RDB_TAG, `insertData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }

        Logger.info(CommonConstants.RDB_TAG, `insertData() finished: ${ret}`);
        callback(ret);
      });
    }
  }

  /**
   * 删除指定表中的数据。
   * @param predicates - 删除条件
   * @param callback - 回调函数，当操作完成时调用
   */
  deleteData(predicates: relationalStore.RdbPredicates, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(CommonConstants.RDB_TAG, 'deleteData() has no callback!');
      return;
    }

    let resFlag: boolean = false;

    if (this.rdbStore) {
      this.rdbStore.delete(predicates, (err, ret) => {
        if (err) {
          Logger.error(CommonConstants.RDB_TAG, `deleteData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }

        Logger.info(CommonConstants.RDB_TAG, `deleteData() finished: ${ret}`);
        callback(!resFlag);
      });
    }
  }

  /**
   * 更新指定表中的数据。
   * @param predicates - 更新条件
   * @param data - 要更新的数据
   * @param callback - 回调函数，当操作完成时调用
   */
  updateData(predicates: relationalStore.RdbPredicates, data: relationalStore.ValuesBucket, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(CommonConstants.RDB_TAG, 'updateDate() has no callback!');
      return;
    }

    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;

    if (this.rdbStore) {
      this.rdbStore.update(valueBucket, predicates, (err, ret) => {
        if (err) {
          Logger.error(CommonConstants.RDB_TAG, `updateData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }

        Logger.info(CommonConstants.RDB_TAG, `updateData() finished: ${ret}`);
        callback(!resFlag);
      });
    }
  }

  /**
   * 查询指定表中的数据。
   * @param predicates - 查询条件
   * @param callback - 回调函数，当操作完成时调用
   */
  query(predicates: relationalStore.RdbPredicates, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(CommonConstants.RDB_TAG, 'query() has no callback!');
      return;
    }

    if (this.rdbStore) {
      this.rdbStore.query(predicates, this.columns, (err, resultSet) => {
        if (err) {
          Logger.error(CommonConstants.RDB_TAG, `query() failed, err:  ${err}`);
          return;
        }

        Logger.info(CommonConstants.RDB_TAG, 'query() finished.');
        callback(resultSet);
        resultSet.close();
      });
    }
  }
}
