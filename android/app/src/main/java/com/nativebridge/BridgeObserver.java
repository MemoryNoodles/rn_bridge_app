package com.nativebridge;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.sql.Time;
import java.util.Timer;
import java.util.TimerTask;

public class BridgeObserver extends ReactContextBaseJavaModule {

    static ReactApplicationContext rtContext;

    public BridgeObserver(@NonNull ReactApplicationContext reactContext) {
        super(reactContext);
        rtContext = reactContext;
    }

    @NonNull
    @Override
    public String getName() {
        return "jsClassName"; //映射 默认为本类类名
    }




    @ReactMethod
    public void send() {
        Log.e(" js send message >>>>>","");
    }

    @ReactMethod
    public void sendAndCallback(Callback callback) {
        callback.invoke("Android sendAndCallback");
    }

    @ReactMethod
    public void sendAndWait() {

        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                WritableMap param = Arguments.createMap();
                param.putString("Android wait key", " sendAndWait");
                sendEvent(rtContext,"BridgeObserver", param);
            }
        }, 6000);
    }
    


    private void sendEvent(ReactContext reactContext,
                           String name,
                           @Nullable WritableMap params) {
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(name, params);
    }
}
