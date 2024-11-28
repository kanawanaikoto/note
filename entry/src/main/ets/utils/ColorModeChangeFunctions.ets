import { common, ConfigurationConstant } from "@kit.AbilityKit";

/**
 * 设置应用的颜色模式
 * @param context UI能力上下文，用于访问应用的上下文
 * @param colorMode 颜色模式，指定应用要设置的颜色模式
 */
const setColorMode = (context: common.UIAbilityContext, colorMode: ConfigurationConstant.ColorMode) => {
  context.getApplicationContext().setColorMode(colorMode);
}

/**
 * 设置应用的颜色模式为自动
 * @param context UI能力上下文，用于访问应用的上下文
 */
export const setAutoColorMode = (context: common.UIAbilityContext) => {
  setColorMode(context, ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
}

/**
 * 设置应用的颜色模式为暗色
 * @param context UI能力上下文，用于访问应用的上下文
 */
export const setDarkColorMode = (context: common.UIAbilityContext) => {
  setColorMode(context, ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
}

/**
 * 设置应用的颜色模式为亮色
 * @param context UI能力上下文，用于访问应用的上下文
 */
export const setLightColorMode = (context: common.UIAbilityContext) => {
  setColorMode(context, ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
}
