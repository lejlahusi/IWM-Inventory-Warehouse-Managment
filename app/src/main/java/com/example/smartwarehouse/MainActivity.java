package com.example.smartwarehouse;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageButton;

import androidx.appcompat.app.AppCompatActivity;

//import org.eclipse.paho.android.service.MqttAndroidClient;
import info.mqtt.android.service.Ack;
import info.mqtt.android.service.MqttAndroidClient;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttClient;

public class MainActivity extends AppCompatActivity {




    ImageButton iwn;

    String topic,clientId;
    IMqttToken token;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        iwn=(ImageButton) findViewById(R.id.iwnbutton);

        clientId = MqttClient.generateClientId();
        topic="test/topic/smartwarehouse";
        MqttAndroidClient client =
                new MqttAndroidClient(MainActivity.this, "tcp://test.mosquitto.org:1883",
                        clientId, Ack.AUTO_ACK);
        iwn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            startActivity( new Intent(MainActivity.this,StartActivity.class));

            }
        });

        if (Build.VERSION.SDK_INT >= 21) {
            Window window = this.getWindow();
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
            ((Window) window).setStatusBarColor(this.getResources().getColor(R.color.orange));
            getWindow().setNavigationBarColor(getResources().getColor(R.color.orange));
        }
    }



}