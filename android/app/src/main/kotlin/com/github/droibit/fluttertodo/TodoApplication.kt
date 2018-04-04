package com.github.droibit.fluttertodo

import io.flutter.app.FlutterApplication

class TodoApplication : FlutterApplication() {

  override fun onCreate() {
    super.onCreate()

    Stetho.initializeWithDefaults(this)
  }
}