package com.example.flutter_advanced_concepts

import android.content.Context
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.Settings
import android.content.Intent
import android.net.Uri

class MainActivity: FlutterActivity() {
    private val CHANNEL = "battery_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    "setMaxBrightness" -> {
                        if (Settings.System.canWrite(this)) {
                            setMaxBrightness()
                            result.success(true)
                        } else {
                            requestWriteSettingsPermission()
                            result.error("PERMISSION_DENIED", "Write settings not allowed", null)
                        }
                    }

                    "getBatteryLevel" -> {
                        val batteryLevel = getBatteryLevel()

                        if (batteryLevel != -1) {
                            result.success(batteryLevel)
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available", null)
                        }
                    }


                    else -> result.notImplemented()
                }
            }
    }

//    private fun setMaxBrightness() {
//        val layoutParams = window.attributes
//        layoutParams.screenBrightness = 1.0f
//        window.attributes = layoutParams
//    }

    private fun setMaxBrightness() {
        Settings.System.putInt(
            contentResolver,
            Settings.System.SCREEN_BRIGHTNESS,
            255
        )
    }



    private fun requestWriteSettingsPermission() {
        val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
        intent.data = Uri.parse("package:$packageName")
        startActivity(intent)
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}