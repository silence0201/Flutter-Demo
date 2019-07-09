package com.thunderhou.flutterhybrid.android;

import android.app.Activity;
import android.widget.Toast;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.view.FlutterView;

/**
 * BasicMessageChannel
 * 用于传递字符串和半结构化的信息,持续通信,收到消息后可以回复此次消息,
 * 如:Native将遍历到的文件信息陆续传递到Dart,
 * 再比如:Flutter将从服务端陆续获取到的信息交给Native加工,Native处理完返回等;
 */
public class BasicMessageChannelPlugin implements BasicMessageChannel.MessageHandler<String>, BasicMessageChannel.Reply<String> {
    private final Activity mActivity;
    private final BasicMessageChannel<String> mMessageChannel;

    static BasicMessageChannelPlugin registerWith(FlutterView flutterView) {
        return new BasicMessageChannelPlugin(flutterView);
    }

    private BasicMessageChannelPlugin(FlutterView flutterView) {
        this.mActivity = (Activity) flutterView.getContext();
        this.mMessageChannel = new BasicMessageChannel<>(flutterView, "BasicMessageChannelPlugin", StringCodec.INSTANCE);
        //设置消息处理器,处理来自Dart的消息
        mMessageChannel.setMessageHandler(this);
    }

    /**
     * 向Dart发送消息,并接受Dart的反馈
     * @param message 要给Dart发送的消息内容
     * @param callback 来自Dart的反馈
     */
    public void send(String message, BasicMessageChannel.Reply<String> callback) {
        mMessageChannel.send(message, callback);
    }

    /**
     * 用于接收Dart发送过来的消息
     * @param msg Dart发送过来的消息内容
     * @param reply 回复此次消息的回调函数
     */
    @Override
    public void onMessage(String msg, BasicMessageChannel.Reply<String> reply) {
        //可通过reply进行回复
        reply.reply("BasicMessageChannel收到: " + msg);
        if (mActivity instanceof IShowMessage) {
            ((IShowMessage) mActivity).onShowMessage(msg);
        }
        Toast.makeText(mActivity, msg, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void reply(String s) {

    }
}
