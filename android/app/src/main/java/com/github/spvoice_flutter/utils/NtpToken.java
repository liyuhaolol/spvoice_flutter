package com.github.spvoice_flutter.utils;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.hwzx.token.CmpTokenUtil;

import java.nio.ByteBuffer;
import java.util.ArrayList;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import spa.lyh.cn.lib_utils.ntp.SntpClient;

public class NtpToken implements BinaryMessenger, MethodChannel.MethodCallHandler {
    private String channelName = "ntpToken";
    private String methodName = "getNtpToken";
    private Context context;
    private MethodChannel channel;

    public NtpToken(BinaryMessenger flutterEngine,Context context){
        this.context = context;
        channel = new MethodChannel(flutterEngine,channelName);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void send(@NonNull String channel, @Nullable ByteBuffer message) {

    }

    @Override
    public void send(@NonNull String channel, @Nullable ByteBuffer message, @Nullable BinaryReply callback) {

    }

    @Override
    public void setMessageHandler(@NonNull String channel, @Nullable BinaryMessageHandler handler) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals(methodName)){
            ArrayList<String> arguments = (ArrayList<String>) call.arguments;
            result.success(CmpTokenUtil.getCmpToken(
                    arguments.get(0),
                    arguments.get(1),
                    SntpClient.getInstance().getTime(context)));
        }else {
            result.notImplemented();
        }
    }
}
