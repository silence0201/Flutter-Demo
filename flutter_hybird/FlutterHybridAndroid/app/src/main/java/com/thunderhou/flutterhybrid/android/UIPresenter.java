package com.thunderhou.flutterhybrid.android;

import android.app.Activity;
import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.RadioGroup;
import android.widget.TextView;

public class UIPresenter implements View.OnClickListener {
    private final Activity activity;
    private final String title;
    private final IShowMessage iShowMessage;

    private TextView textShow;
    private EditText input;
    private boolean useEventChannel;

    UIPresenter(Activity activity, String title, IShowMessage iShowMessage) {
        this.activity = activity;
        this.title = title;
        this.iShowMessage = iShowMessage;
        initUI();
    }

    private void initUI() {
        FrameLayout nativePartContainer = activity.findViewById(R.id.nativePartContainer);
        View view = LayoutInflater.from(activity).inflate(R.layout.item_container, null);
        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        nativePartContainer.addView(view, lp);

        textShow = view.findViewById(R.id.textShow);
        input = view.findViewById(R.id.input);
        TextView titleView = view.findViewById(R.id.title);
        titleView.setText(title);
        view.findViewById(R.id.btnSend).setOnClickListener(this);
        RadioGroup radioGroup = view.findViewById(R.id.radioGroup);
        radioGroup.setOnCheckedChangeListener((group, checkedId) -> {
            if (checkedId == R.id.mode_basic_message_channel) {
                useEventChannel = false;
            } else if (checkedId == R.id.mode_event_channel) {
                useEventChannel = true;
            }
        });
        input.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence content, int start, int before, int count) {
                iShowMessage.sendMessage(content.toString(), useEventChannel);
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    public void showDartMessage(String msg) {
        textShow.setText(msg);
    }

    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.btnSend) {
            InputMethodManager imm = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
            //隐藏软键盘
            imm.hideSoftInputFromWindow(input.getWindowToken(), 0);

            iShowMessage.sendMessage(input.getText().toString().trim(), useEventChannel);
        }
    }
}
