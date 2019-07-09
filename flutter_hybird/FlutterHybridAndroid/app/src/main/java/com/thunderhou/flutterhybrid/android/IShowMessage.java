package com.thunderhou.flutterhybrid.android;

public interface IShowMessage {
    void onShowMessage(String msg);
    void sendMessage(String msg, boolean useEventChannel);
}
