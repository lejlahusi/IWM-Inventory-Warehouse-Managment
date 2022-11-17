package com.example.smartwarehouse;

import static android.content.ContentValues.TAG;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;


import info.mqtt.android.service.Ack;
import info.mqtt.android.service.MqttAndroidClient;
import org.eclipse.paho.client.mqttv3.IMqttActionListener;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import java.io.UnsupportedEncodingException;


public class QuantityActivity extends AppCompatActivity {
    TextView t11,t12,t13,t21,t22,t23,t31,t32,t33;
    String mess;
    int quantity1=0;
    int quantity2=0;
    int number;
    Button btn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quantity);

        //First row
        t11=(TextView) findViewById(R.id.t11);
        t12=(TextView) findViewById(R.id.t12);
        t13=(TextView) findViewById(R.id.t13);

        //Second row
        t21=(TextView) findViewById(R.id.t21);
        t22=(TextView) findViewById(R.id.t22);
        t23=(TextView) findViewById(R.id.t23);

        //Third row
        t31=(TextView) findViewById(R.id.t31);
        t32=(TextView) findViewById(R.id.t32);
        t33=(TextView) findViewById(R.id.t33);

        btn=(Button) findViewById(R.id.btn);

        //startService(new Intent(getApplication(), com.example.smartwarehouse.MqttMessage.class));



        String topic,clientId;
        final IMqttToken[] token = new IMqttToken[1];
        clientId = MqttClient.generateClientId();
        topic="topic/warehouse/inventory";
        MqttAndroidClient client =
                new MqttAndroidClient(QuantityActivity.this, "tcp://test.mosquitto.org:1883",
                        clientId, Ack.AUTO_ACK);

        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                token[0] = client.connect();
                token[0].setActionCallback(new IMqttActionListener() {
                    @Override
                    public void onSuccess(IMqttToken asyncActionToken) {
                        // We are connected
                        Log.d(TAG, "onSuccess");
                        Toast.makeText(QuantityActivity.this, "connected", Toast.LENGTH_SHORT).show();

                        sub(topic,client);
                        // number=Integer.parseInt(mess);
                        t11.setText(mess);
               /* switch (number){
                    case 1:
                        quantity1++;
                        String quantity=String.valueOf(quantity1);
                        t11.setText(quantity);
                        break;

                    default:
                        break;

                }*/

                        // int qos = 1;



                    }

                    @Override
                    public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
                        Toast.makeText(QuantityActivity.this, "not connected", Toast.LENGTH_SHORT).show();

                    }

                });
            }
        });






    }



    public void sub(String topic,MqttAndroidClient client){
        int qos=1;
        client.subscribe(topic,qos);
        client.setCallback(new MqttCallback() {
            @Override
            public void connectionLost(Throwable cause) {
            }

            @Override
            public void messageArrived(String topic, MqttMessage message) throws Exception {
                mess= message.getPayload().toString();

            }

            @Override
            public void deliveryComplete(IMqttDeliveryToken token) {


            }
        });


    }
}