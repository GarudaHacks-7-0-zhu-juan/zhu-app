package com.zhujuan.zhu_app

import com.google.firebase.installations.FirebaseInstallations
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FIREBASE_INSTALLATIONS_CHANNEL,
        ).setMethodCallHandler { call, result ->
            val installations = FirebaseInstallations.getInstance()
            when (call.method) {
                "getId" -> installations.id.addOnCompleteListener { task ->
                    runOnUiThread {
                        if (task.isSuccessful) {
                            result.success(task.result)
                        } else {
                            result.error(
                                FIREBASE_INSTALLATIONS_ERROR,
                                task.exception?.message,
                                null,
                            )
                        }
                    }
                }

                "delete" -> installations.delete().addOnCompleteListener { task ->
                    runOnUiThread {
                        if (task.isSuccessful) {
                            result.success(null)
                        } else {
                            result.error(
                                FIREBASE_INSTALLATIONS_ERROR,
                                task.exception?.message,
                                null,
                            )
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val FIREBASE_INSTALLATIONS_CHANNEL =
            "com.zhujuan.zhu_app/firebase_installations"
        const val FIREBASE_INSTALLATIONS_ERROR = "firebase_installations"
    }
}
