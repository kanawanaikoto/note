/**
 * 定义一个Table接口，用于描述内存表的结构
 * 内存表是在应用程序运行期间临时存储数据的数据结构
 * 它包括表名、创建表的SQL语句以及表的列名集合
 */
export interface Table {
  // 表名，用于唯一标识一个内存表
  tableName: string
  // 创建表的SQL语句，用于定义表的结构
  sqlCreate: string
  // 列名集合，包含表中所有列的名称
  columns: string[]
}
