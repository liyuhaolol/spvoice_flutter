package com.github.spvoice_flutter;

import android.content.pm.PackageManager;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.github.spvoice_flutter.splashanimate.NoAlphaDrawableSplashScreen;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.android.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import spa.lyh.cn.lib_utils.translucent.TranslucentUtils;


public class MainActivity extends FlutterActivity {

    /*FlutterView fv;
    FlutterEngine flutterEngine;*/


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
        TranslucentUtils.setTranslucentBoth(getWindow());
        getWindow().setDecorFitsSystemWindows(false);
        /*fv = findViewById(R.id.fv);
        flutterEngine = new FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        //flutterEngine.getNavigationChannel().setInitialRoute("/");
        fv.attachToFlutterEngine(flutterEngine);*/
    }

    @Nullable
    @Override
    public SplashScreen provideSplashScreen() {
        Drawable manifestSplashDrawable = getSplashScreenFromManifest();
        if (manifestSplashDrawable != null) {
            return new NoAlphaDrawableSplashScreen(manifestSplashDrawable);
        } else {
            return null;
        }
    }

    /*@Override
    protected void onResume() {
        super.onResume();
        flutterEngine.getLifecycleChannel().appIsResumed();
    }

    @Override
    protected void onPause() {
        super.onPause();
        flutterEngine.getLifecycleChannel().appIsInactive();
    }

    @Override
    protected void onStop() {
        super.onStop();
        flutterEngine.getLifecycleChannel().appIsPaused();
    }*/

    static final String SPLASH_SCREEN_META_DATA_KEY =
            "io.flutter.embedding.android.SplashScreenDrawable";//flutter的启动页drawable

    /**
     * 获取启动图Drawable
     * @return 启动图Drawable
     */
    private Drawable getSplashScreenFromManifest() {
        try {
            Bundle metaData = getMetaData();
            int splashScreenId = metaData != null ? metaData.getInt(SPLASH_SCREEN_META_DATA_KEY) : 0;
            return splashScreenId != 0
                    ? Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP
                    ? getResources().getDrawable(splashScreenId, getTheme())
                    : getResources().getDrawable(splashScreenId)
                    : null;
        } catch (PackageManager.NameNotFoundException e) {
            // This is never expected to happen.
            return null;
        }
    }
}
