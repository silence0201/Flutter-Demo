package com.thunderhou.flutterhybrid.android;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText paramInputEt = findViewById(R.id.etParamInput);

        findViewById(R.id.btnInvokeFlutter).setOnClickListener(v -> {
            String inputParams = paramInputEt.getText().toString().trim();
            FlutterActivity.startActivity(MainActivity.this, inputParams);
        });
    }
}
