package com.ejogajog.serviceseeker

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {
  @Override
  fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)
  }
}
