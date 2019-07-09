package com.thunderhou.flutterhybrid.android;

import android.content.Context;
import android.content.Intent;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;

import io.flutter.facade.Flutter;
import io.flutter.facade.FlutterFragment;
import io.flutter.view.FlutterView;

public class FlutterActivity extends AppCompatActivity implements IShowMessage {
    private static final String INIT_PARAMS = "initParams";
    private UIPresenter mUIPresenter;
    private BasicMessageChannelPlugin mBasicMessageChannelPlugin;
    private EventChannelPlugin mEventChannelPlugin;

    public static void startActivity(Context context, String initParams) {
        Intent intent = new Intent(context, FlutterActivity.class);
        intent.putExtra(INIT_PARAMS, initParams);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter);

        String initParams = getIntent().getStringExtra(INIT_PARAMS);
        FlutterView flutterView = Flutter.createView(this, getLifecycle(), initParams);
        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        FrameLayout dartPartContainer = findViewById(R.id.dartPartContainer);
        dartPartContainer.addView(flutterView, lp);

        //注册Flutter Plugin
        mEventChannelPlugin = EventChannelPlugin.registerWith(flutterView);
        MethodChannelPlugin.registerWith(flutterView);
        mBasicMessageChannelPlugin = BasicMessageChannelPlugin.registerWith(flutterView);
        mUIPresenter = new UIPresenter(this, "通信与混合开发", this);
    }

    @Override
    public void onShowMessage(String msg) {
        mUIPresenter.showDartMessage(msg);
    }

    @Override
    public void sendMessage(String msg, boolean useEventChannel) {
        //EventChannel: Dart收到消息后无法回复此次消息
        if (useEventChannel) {
           mEventChannelPlugin.send(msg);
        } else {
            mBasicMessageChannelPlugin.send(msg, this::onShowMessage);
        }
    }
}
