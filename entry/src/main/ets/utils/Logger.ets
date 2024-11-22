import hilog from '@ohos.hilog'

/**
 * Logger类提供了一种日志记录的便捷方式，封装了不同级别的日志记录功能
 * 它通过统一的日志格式和前缀，帮助开发者更容易地管理和阅读日志信息
 */
class Logger {
  // 定义日志域，用于区分不同的日志来源
  private domain: number

  // 定义日志前缀，用于标识日志的标签
  private prefix: string

  // 定义日志输出格式
  private format: string = '%{public}s, %{public}s'

  /**
   * 构造函数，初始化Logger实例
   * @param prefix 日志的前缀，默认值为'myTag'
   * @param domain 日志的域，默认值为0xFF00
   */
  constructor(prefix: string = 'myTag', domain: number = 0xFF00) {
    this.prefix = prefix
    this.domain = domain
  }

  /**
   * 记录调试级别日志
   * @param args 日志中需要记录的参数，可以是多个
   */
  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录信息级别日志
   * @param args 日志中需要记录的参数，可以是多个
   */
  info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录警告级别日志
   * @param args 日志中需要记录的参数，可以是多个
   */
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录错误级别日志
   * @param args 日志中需要记录的参数，可以是多个
   */
  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

// 导出一个Logger实例，预设了日志前缀为'myApp'，日志域为0xFF00
export default new Logger('myApp',0xFF00)
