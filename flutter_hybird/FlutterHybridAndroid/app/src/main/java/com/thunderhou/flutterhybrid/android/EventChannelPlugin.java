package com.thunderhou.flutterhybrid.android;

import io.flutter.plugin.common.EventChannel;
import io.flutter.view.FlutterView;

/**
 * EventChannelPlugin
 * 用于数据流的通信,持续通信,通常用于Native向Dart的通信,
 * 如:手机电量变化,网络连接变化,陀螺仪,传感器等.
 */
public class EventChannelPlugin implements EventChannel.StreamHandler {
    private EventChannel.EventSink mEventSink;

    static EventChannelPlugin registerWith(FlutterView flutterView) {
        EventChannelPlugin plugin = new EventChannelPlugin();
        new EventChannel(flutterView, "EventChannelPlugin").setStreamHandler(plugin);
        return plugin;
    }

    /**
     * 向Dart发送消息
     */
    public void send(Object params) {
        if (mEventSink != null) {
            mEventSink.success(params);
        }
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.mEventSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        this.mEventSink = null;
    }
}
