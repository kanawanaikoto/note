/**
 * GlobalContext 类用于提供一个全局唯一的上下文环境，可以在该环境中存储和获取各种对象实例。
 * 它通过单例模式实现，确保在整个应用中只有一个实例存在，从而提供全局访问点。
 */
export class GlobalContext {
  // 私有构造函数，防止外部直接通过构造函数创建实例
  private constructor() { }

  // 单例模式，静态实例用于存储 GlobalContext 的唯一实例
  private static instance: GlobalContext;

  // 内部Map用于存储键值对形式的对象，键为字符串，值为任意对象
  private _objects = new Map<string, Object>();

  /**
   * 获取 GlobalContext 的唯一实例。
   * 如果实例不存在，则创建并返回一个新的实例；如果已存在，则返回现有实例。
   * @returns {GlobalContext} GlobalContext 的唯一实例。
   */
  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  /**
   * 根据键获取存储的对象。
   * @param {string} value 对象的键。
   * @returns {Object | undefined} 返回对应的对象，如果键不存在则返回 undefined。
   */
  getObject(value: string): Object | undefined {
    return this._objects.get(value);
  }

  /**
   * 在上下文中设置对象，通过键值对形式存储对象。
   * 如果键已存在，会覆盖原有值。
   * @param {string} key 对象的键。
   * @param {Object} objectClass 要存储的对象实例。
   */
  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}
