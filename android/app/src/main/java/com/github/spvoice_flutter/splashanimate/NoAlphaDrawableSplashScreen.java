package com.github.spvoice_flutter.splashanimate;

import android.animation.Animator;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.DrawableSplashScreen;
import io.flutter.embedding.android.SplashScreen;

public class NoAlphaDrawableSplashScreen implements SplashScreen {
    private final Drawable drawable;
    private final ImageView.ScaleType scaleType;
    private final long crossfadeDurationInMillis;
    private DrawableSplashScreen.DrawableSplashScreenView splashView;

    public NoAlphaDrawableSplashScreen(@NonNull Drawable drawable) {
        this(drawable, ImageView.ScaleType.FIT_XY, 500);
    }

    public NoAlphaDrawableSplashScreen(
            @NonNull Drawable drawable,
            @NonNull ImageView.ScaleType scaleType,
            long crossfadeDurationInMillis) {
        this.drawable = drawable;
        this.scaleType = scaleType;
        this.crossfadeDurationInMillis = crossfadeDurationInMillis;
    }
    
    
    @Nullable
    @Override
    public View createSplashView(@NonNull Context context, @Nullable Bundle savedInstanceState) {
        splashView = new DrawableSplashScreen.DrawableSplashScreenView(context);
        splashView.setSplashDrawable(drawable, scaleType);
        return splashView;
    }

    @Override
    public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
        if (splashView == null) {
            onTransitionComplete.run();
            return;
        }

        splashView
                .animate()
                .alpha(1.0f)
                .setDuration(crossfadeDurationInMillis)
                .setListener(
                        new Animator.AnimatorListener() {
                            @Override
                            public void onAnimationStart(Animator animation) {}

                            @Override
                            public void onAnimationEnd(Animator animation) {
                                onTransitionComplete.run();
                            }

                            @Override
                            public void onAnimationCancel(Animator animation) {
                                onTransitionComplete.run();
                            }

                            @Override
                            public void onAnimationRepeat(Animator animation) {}
                        });
    }

    @Override
    public boolean doesSplashViewRememberItsTransition() {
        return false;
    }

    @Nullable
    @Override
    public Bundle saveSplashScreenState() {
        return null;
    }
}
