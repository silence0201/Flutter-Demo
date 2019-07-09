package com.thunderhou.flutterhybrid.android;

import android.app.Activity;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

/**
 * MethodChannelPlugin
 * 用于传递方法调用,一次性通信,通常用于Dart调用Native方法,
 * 如:Flutter调用Native拍照
 */
public class MethodChannelPlugin implements MethodChannel.MethodCallHandler {
    private final Activity mActivity;

    static void registerWith(FlutterView flutterView) {
        MethodChannel channel = new MethodChannel(flutterView, "MethodChannelPlugin");
        MethodChannelPlugin instance = new MethodChannelPlugin((Activity) flutterView.getContext());
        channel.setMethodCallHandler(instance);
    }

    private MethodChannelPlugin(Activity activity) {
        this.mActivity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        //处理来自Dart方法的调用
        switch (call.method) {
            case "send":
                showMessage(call.arguments());
                result.success("MethodChannelPlugin收到: " + call.arguments);
                break;
            case "toast":
                // 调用本地代码的时候，只能传递一个参数。为了传递多个，可以把参数放在一个 map 里面。
                // call.argument() 方法支持 Map 和 JSONObject
                String content = call.argument("content");
                String duration = call.argument("duration");
                Toast.makeText(mActivity, content, "short".equals(duration) ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG).show();
                result.success("MethodChannelPlugin收到: 弹出toast");
                break;
            default:
                result.notImplemented();
        }
    }

    /**
     * 展示来自Dart的数据
     */
    private void showMessage(String msg) {
        if (mActivity instanceof IShowMessage) {
            ((IShowMessage) mActivity).onShowMessage(msg);
        }
        Toast.makeText(mActivity, msg, Toast.LENGTH_SHORT).show();
    }
}
