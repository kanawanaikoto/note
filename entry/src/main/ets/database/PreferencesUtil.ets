import dataPreferences from '@ohos.data.preferences';
import { GlobalContext } from '../utils/GlobalContext';
import Logger from '../utils/Logger';

// 定义日志标签，用于标识日志来源
const TAG = '[PreferencesUtil]';
// 定义 Preferences 的名称常量
const PREFERENCES_NAME = 'myPreferences';
// 定义应用字体大小的键名常量
const KEY_APP_FONT_SIZE = 'appFontSize';
// 定义应用风格的键名常量
const KEY_APP_STYLE = 'appStyle';
// 定义应用颜色的键名常量
const KEY_APP_COLOR = 'appColor';
// 定义应用排序的键名常量
const KEY_APP_SORT = 'appSort';


/**
 * Preferences 工具类，用于操作应用的 Preferences 数据
 */
export class PreferencesUtil {
  /**
   * 创建 Preferences 实例
   * @param context 上下文对象，用于获取 Preferences 实例
   */
  createPreferences(context: Context) {
    // 定义一个函数来获取 Preferences 实例
    let getPreferences: Function = (() => {
      // 获取 Preferences 实例
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context,
        PREFERENCES_NAME);
      // 返回 Preferences 实例
      return preferences;
    });
    // 将获取 Preferences 实例的函数存储到全局上下文中
    GlobalContext.getContext().setObject('getPreferences', getPreferences);
  }

  /**
   * 保存默认字体大小到 Preferences 中
   * @param fontSize 默认字体大小
   */
  saveDefaultFontSize(fontSize: number) {
    this.savePreferences(KEY_APP_FONT_SIZE, fontSize);
  }

  /**
   * 保存更改后的字体大小到 Preferences 中
   * @param fontSize 更改后的字体大小
   */
  saveChangeFontSize(fontSize: number) {
    this.saveValue(KEY_APP_FONT_SIZE, fontSize);
  }

  /**
   * 获取更改后的字体大小
   * @returns 更改后的字体大小
   */
  async getChangeFontSize(): Promise<number> {
    return this.getValue(KEY_APP_FONT_SIZE, 0);
  }

  /**
   * 删除 Preferences 中的字体大小设置
   */
  async deleteChangeFontSize() {
    this.deleteValue(KEY_APP_FONT_SIZE);
  }

  /**
   * 保存默认风格到 Preferences 中
   * @param style 默认风格
   */
  saveDefaultStyle(style: number) {
    this.savePreferences(KEY_APP_STYLE, style);
  }

  /**
   * 保存更改后的风格到 Preferences 中
   * @param style 更改后的风格
   */
  saveChangeStyle(style: number) {
    this.saveValue(KEY_APP_STYLE, style);
  }

  /**
   * 获取更改后的风格
   * @returns 更改后的风格
   */
  async getChangeStyle(): Promise<number> {
    return this.getValue(KEY_APP_STYLE, 0);
  }

  /**
   * 删除 Preferences 中的风格设置
   */
  async deleteChangeStyle() {
    this.deleteValue(KEY_APP_STYLE);
  }

  /**
   * 保存默认颜色到 Preferences 中
   * @param color 默认颜色
   */
  saveDefaultColor(color: string) {
    this.savePreferences(KEY_APP_COLOR, color);
  }

  /**
   * 保存更改后的颜色到 Preferences 中
   * @param color 更改后的颜色
   */
  saveChangeColor(color: string) {
    this.saveValue(KEY_APP_COLOR, color);
  }

  /**
   * 获取更改后的颜色
   * @returns 更改后的颜色
   */
  async getChangeColor(): Promise<string> {
    return this.getValue(KEY_APP_COLOR, '');
  }

  /**
   * 删除 Preferences 中的颜色设置
   */
  async deleteChangeColor() {
    this.deleteValue(KEY_APP_COLOR);
  }

  /**
   * 保存默认排序到 Preferences 中
   * @param sort 默认排序
   */
  saveDefaultSort(sort: number) {
    this.savePreferences(KEY_APP_SORT, sort);
  }

  /**
   * 保存更改后的排序到 Preferences 中
   * @param sort 更改后的排序
   */
  saveChangeSort(sort: number) {
    this.saveValue(KEY_APP_SORT, sort);
  }

  /**
   * 获取更改后的排序
   * @returns 更改后的排序
   */
  async getChangeSort(): Promise<number> {
    return this.getValue(KEY_APP_SORT, 0);
  }

  /**
   * 删除 Preferences 中的排序设置
   */
  async deleteChangeSort() {
    this.deleteValue(KEY_APP_SORT);
  }

  /**
   * 通用方法，用于保存值到 Preferences 中
   * @param key 键名
   * @param value 值
   */
  saveValue(key: string, value: string | number | boolean) {
    let getPreferences: Function = GlobalContext.getContext().getObject('getPreferences') as Function;
    Logger.info(TAG, 'put the preferences, key: ' + key + ', value: ' + value);
    getPreferences().then(async (preferences: dataPreferences.Preferences) => {
      await preferences.put(key, value);
      preferences.flush();
    }).catch((err: Error) => {
      Logger.error(TAG, 'put the preferences failed, err: ' + err);
    });
  }

  savePreferences(key: string, value: string | number | boolean){
    // 从全局上下文中获取获取 Preferences 实例的函数
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getPreferences') as Function;

    // 获取 Preferences 实例并操作
    getFontPreferences().then((preferences: dataPreferences.Preferences) => {
      // 检查设置是否存在
      preferences.has(key).then(async (isExist: boolean) => {

        // 如果设置不存在，则保存默认
        if (!isExist) {
          await preferences.put(key, value);
          preferences.flush();
        }
      }).catch((err: Error) => {
        // 记录错误日志
        Logger.error(TAG, 'Has the value failed with err: ' + err);
      });
    }).catch((err: Error) => {
      // 记录错误日志
      Logger.error(TAG, 'Get the preferences failed, err: ' + err);
    });
  }

  /**
   * 通用方法，用于从 Preferences 中获取值
   * @param key 键名
   * @param defaultValue 默认值
   * @returns 获取的值
   */
  async getValue<T>(key: string, defaultValue: T): Promise<T> {
    let getPreferences: Function = GlobalContext.getContext().getObject('getPreferences') as Function;
    return (await getPreferences()).get(key, defaultValue);
  }

  /**
   * 通用方法，用于从 Preferences 中删除值
   * @param key 键名
   */
  async deleteValue(key: string) {
    let getPreferences: Function = GlobalContext.getContext().getObject('getPreferences') as Function;
    const preferences: dataPreferences.Preferences = await getPreferences();
    let deleteValue = preferences.delete(key);
    deleteValue.then(() => {
      Logger.info(TAG, 'Succeeded in deleting the key ' + key + '.');
    }).catch((err: Error) => {
      Logger.error(TAG, 'Failed to delete the key ' + key + '. Cause: ' + err);
    });
  }
}

// 创建并导出 Preferences 工具类的实例
export default new PreferencesUtil();
