package com.rajagoput.app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.pm.PackageManager
import android.os.Bundle

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.rajagoput.app/gojek"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->
        if (call.method == "version") {
            val version = getAppVersion()
            result.success(version)
        } else {
            result.notImplemented()
        }
    }
  }

    private fun getAppVersion(): String {
        try {
            val a = applicationContext.packageManager.getPackageInfo("com.gojek.app", 0)

            return a.versionName
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
            throw e
        }
    }
}
