package com.example.smartwarehouse;

import static android.content.ContentValues.TAG;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

//import org.eclipse.paho.android.service.MqttAndroidClient;
import info.mqtt.android.service.Ack;
import info.mqtt.android.service.MqttAndroidClient;
import org.eclipse.paho.client.mqttv3.IMqttActionListener;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import java.io.UnsupportedEncodingException;

public class TrackActivity extends AppCompatActivity {
    Button b11,b12,b13,b21,b22,b23,b31,b32,b33;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_track);
        b11=(Button) findViewById(R.id.b11);
        b12=(Button) findViewById(R.id.b12);
        b13=(Button) findViewById(R.id.b13);
        b21=(Button) findViewById(R.id.b21);
        b22=(Button) findViewById(R.id.b22);
        b23=(Button) findViewById(R.id.b23);
        b31=(Button) findViewById(R.id.b31);
        b32=(Button) findViewById(R.id.b32);
        b33=(Button) findViewById(R.id.b33);

        //"tcp://test.mosquitto.org:1883"
        String topic,clientId;
        final IMqttToken[] token = new IMqttToken[1];
        clientId = MqttClient.generateClientId();
        topic="topic/warehouse";
        MqttAndroidClient client =
                new MqttAndroidClient(TrackActivity.this,"tcp://broker.hivemq.com:1883" ,
                        clientId, Ack.AUTO_ACK);

        b11.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String payload = "103";
                connect(payload,topic,token,client);

            }
        });


        b12.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String payload = "104";
                connect(payload,topic,token,client);

            }
        });

        b13.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String payload = "105";
                connect(payload,topic,token,client);

            }
        });

        b21.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String payload = "107";
                connect(payload,topic,token,client);

            }
        });

        b22.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String payload = "108";
                connect(payload,topic,token,client);

            }
        });

        b23.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String payload = "109";
                connect(payload,topic,token,client);

            }
        });

        b31.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String payload = "111";
                connect(payload,topic,token,client);

            }
        });

        b32.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String payload = "112";
                connect(payload,topic,token,client);

            }
        });

        b33.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                /*token[0] = client.connect();
                token[0].setActionCallback(new IMqttActionListener() {
                    @Override
                    public void onSuccess(IMqttToken asyncActionToken) {
                        // We are connected
                        Log.d(TAG, "onSuccess");


                        Toast.makeText(TrackActivity.this, "connected", Toast.LENGTH_SHORT).show();


                        String payload = "113";
                        byte[] encodedPayload = new byte[0];
                        try {
                            encodedPayload = payload.getBytes("UTF-8");
                            MqttMessage message = new MqttMessage(encodedPayload);
                            client.publish(topic, message);
                        } catch (UnsupportedEncodingException e) {
                            e.printStackTrace();
                        }

                    }

                    @Override
                    public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
                        Toast.makeText(TrackActivity.this, "not connected", Toast.LENGTH_SHORT).show();

                    }

                });*/
                String payload = "113";
                connect(payload,topic,token,client);

            }
        });

    }
    private void connect(String payload,String topic, IMqttToken[] token, MqttAndroidClient client){

        token[0] = client.connect();
        token[0].setActionCallback(new IMqttActionListener() {
            @Override
            public void onSuccess(IMqttToken asyncActionToken) {
                // We are connected
                Log.d(TAG, "onSuccess");


                Toast.makeText(TrackActivity.this, "connected", Toast.LENGTH_SHORT).show();


               // String payload = "113";
                byte[] encodedPayload = new byte[0];
                try {
                    encodedPayload = payload.getBytes("UTF-8");
                    MqttMessage message = new MqttMessage(encodedPayload);
                    client.publish(topic, message);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }

            }

            @Override
            public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
                Toast.makeText(TrackActivity.this, "not connected", Toast.LENGTH_SHORT).show();

            }

        });

    }
}