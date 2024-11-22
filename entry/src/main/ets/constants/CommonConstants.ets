import relationalStore from '@ohos.data.relationalStore'
import { MemoTable } from '../model/TableInterface'

/**
 * 定义应用中常用的常量
 */
export default class CommonConstants {

  /**
   * 数据库配置常量
   * 包含数据库的名称和安全级别
   */
  static readonly STORE_CONFIG:relationalStore.StoreConfig = {
    name:'database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  /**
   * 表的配置
   * 包含表名，创建表的SQL语句和列名
   */
  static readonly MEMO_TABLE:MemoTable = {
    tableName:'memoTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS memoTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, content TEXT)',
    columns:['id','updateTime','content']
  }

  /**
   * RDB调试标签
   * 用于在调试输出时标识RDB相关的日志
   */
  static readonly RDB_TAG = '[Debug.Rdb]';

  /**
   * 表调试标签
   * 用于在调试输出时标识特定表相关的日志
   */
  static readonly TABLE_TAG = '[Debug.memoTable]';

  /**
   * 索引调试标签
   * 用于在调试输出时标识索引相关的日志
   */
  static readonly INDEX_TAG = '[Debug.Index]';

}
