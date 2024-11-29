import { AbilityConstant, Configuration, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { GlobalContext } from '../utils/GlobalContext';
import PreferencesUtil from '../database/PreferencesUtil';
import SettingData from '../constants/SettingData';
import { KeyboardAvoidMode } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    GlobalContext.getContext().setObject('abilityWant',want)
    PreferencesUtil.createPreferences(this.context)
    PreferencesUtil.saveDefaultFontSize(SettingData.SET_SIZE_NORMAL)
    PreferencesUtil.saveDefaultColor(SettingData.APP_COLOR)
    PreferencesUtil.saveDefaultStyle(SettingData.APP_STYLE)
    PreferencesUtil.saveDefaultSort(SettingData.APP_SORT)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');// 初始化页面

    // windowStage.getMainWindow().then((window) => {
    //   window.setWindowLayoutFullScreen(true)
    // })


    windowStage.loadContent('pages/Index', (err) => {

      // let keyboardAvoidMode = windowStage.getMainWindowSync().getUIContext().getKeyboardAvoidMode();
      // // 设置虚拟键盘抬起时压缩页面大小为减去键盘的高度
      // windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);

      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }

      // 设置全窗颜色和应用元素颜色一致
      //windowStage.getMainWindowSync().setWindowBackgroundColor("#F1F3F5")

      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
