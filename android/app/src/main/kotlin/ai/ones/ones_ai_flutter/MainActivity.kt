package ai.ones.ones_ai_flutter

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    setStatus(this);
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
  fun setStatus(activity: Activity) {
    if (!isNavigationBarShow(activity)) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)//窗口透明的状态栏
        activity.requestWindowFeature(Window.FEATURE_NO_TITLE)//隐藏标题栏
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)//窗口透明的导航栏
      }
    } else {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        activity.getWindow().setStatusBarColor(Color.TRANSPARENT)
      }
    }
  }

  //是否是虚拟按键的设备
  private fun isNavigationBarShow(activity: Activity): Boolean {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      val display = activity.getWindowManager().getDefaultDisplay()
      val size = Point()
      val realSize = Point()
      display.getSize(size)
      display.getRealSize(realSize)
      val result = realSize.y !== size.y
      return realSize.y !== size.y
    } else {
      val menu = ViewConfiguration.get(activity).hasPermanentMenuKey()
      val back = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_BACK)
      return if (menu || back) {
        false
      } else {
        true
      }
    }
  }
}
