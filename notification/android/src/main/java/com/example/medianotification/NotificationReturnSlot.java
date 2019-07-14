package com.example.medianotification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;

public class NotificationReturnSlot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        switch (intent.getAction()) {
            case "prev":
                MediaNotificationPlugin.callEvent("prev");
                break;
            case "next":
                MediaNotificationPlugin.callEvent("next");
                break;
            case "toggle":
                String title = intent.getStringExtra("title");
                String author = intent.getStringExtra("author");
                String action = intent.getStringExtra("action");
                String art = intent.getStringExtra("path");
                MediaNotificationPlugin.show(title, author, action.equals("play"),art);
                MediaNotificationPlugin.callEvent(action);
                break;
            case "select":
                Intent closeDialog = new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
                context.sendBroadcast(closeDialog);
                String packageName = context.getPackageName();
                PackageManager pm = context.getPackageManager();
                Intent launchIntent = pm.getLaunchIntentForPackage(packageName);
                context.startActivity(launchIntent);

                MediaNotificationPlugin.callEvent("select");
        }
    }
}

