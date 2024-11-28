
export default class SettingData {

  /**
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
   */

  static readonly PREFERENCES_NAME = 'myPreferences';

  static readonly KEY_APP_FONT_SIZE = 'appFontSize';


  // 标准字体大小常量
  static readonly SET_SIZE_NORMAL: number = 16;
  // 大号字体大小常量
  static readonly SET_SIZE_LARGE: number = 18;
  // 小号字体大小常量
  static readonly SET_SIZE_SMALL: number = 14;
  // 默认字体大小常量
  static readonly SET_SIZE_DEFAULT: number = 16;

  // 应用排序的键名常量
  static readonly APP_SORT: number = 1;

  static readonly APP_STYLE: number = 1;

  static readonly APP_COLOR: number = 0;

  // 超大号字体大小常量
  static readonly SET_SIZE_EXTRA_LARGE: number = 20;

  // 巨大号字体大小常量
  static readonly SET_SIZE_HUGE: number = 24;

  // 滑动条最小值常量
  static readonly SET_SLIDER_MIN: number = 14;

  // 滑动条最大值常量
  static readonly SET_SLIDER_MAX: number = 22;

  // 滑动条步长常量
  static readonly SET_SLIDER_STEP: number = 2;


}