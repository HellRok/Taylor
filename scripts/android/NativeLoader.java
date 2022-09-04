package com.raylib.game;
public class NativeLoader extends android.app.NativeActivity {
  static {
    System.loadLibrary("main");
  }
}
