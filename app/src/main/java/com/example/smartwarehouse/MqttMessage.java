package com.example.smartwarehouse;

import static android.content.ContentValues.TAG;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;

import org.eclipse.paho.client.mqttv3.IMqttActionListener;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;

import info.mqtt.android.service.Ack;
import info.mqtt.android.service.MqttAndroidClient;



public class MqttMessage extends Service{
    private static final String TAG="MqttMessage";
    String mess;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        String topic,clientId;
        final IMqttToken[] token = new IMqttToken[1];
        clientId = MqttClient.generateClientId();
        topic="topic/warehouse/inventory";
        MqttAndroidClient client =
                new MqttAndroidClient(MqttMessage.this, "tcp://test.mosquitto.org:1883",
                        clientId, Ack.AUTO_ACK);

        token[0] = client.connect();
        token[0].setActionCallback(new IMqttActionListener() {
            @Override
            public void onSuccess(IMqttToken asyncActionToken) {
                // We are connected
                Log.d(TAG, "onSuccess");
              //  Toast.makeText(QuantityActivity.this, "connected", Toast.LENGTH_SHORT).show();
                sub(topic,client);
                //Toast.makeText(MqttMessage.this, mess, Toast.LENGTH_SHORT).show();
                if (mess!=null){
                Log.d(TAG,mess);}
                // int qos = 1;



            }

            @Override
            public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
               // Toast.makeText(QuantityActivity.this, "not connected", Toast.LENGTH_SHORT).show();

            }

        });

        return START_STICKY;
    }

    private void sub(String topic, MqttAndroidClient client){
        int qos=1;
        client.subscribe(topic,qos);
        client.setCallback(new MqttCallback() {
            @Override
            public void connectionLost(Throwable cause) {

            }

            @Override
            public void messageArrived(String topic, org.eclipse.paho.client.mqttv3.MqttMessage message) throws Exception {
                mess= message.getPayload().toString();

            }

            @Override
            public void deliveryComplete(IMqttDeliveryToken token) {

            }
        });


    }
}
