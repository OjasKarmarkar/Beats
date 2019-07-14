package com.example.medianotification;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import java.io.File;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.core.app.NotificationCompat;

import android.widget.RemoteViews;

/**
 * Created by dmitry on 14.08.18.
 */

public class NotificationPanel {
    private Context parent;
    private NotificationManager nManager;
    private NotificationCompat.Builder nBuilder;
    private RemoteViews remoteView;
    private String title;
    private String author;
    private boolean play;
    private String art;

    public NotificationPanel(Context parent, String title, String author, boolean play, String art) {
        this.parent = parent;
        this.title = title;
        this.author = author;
        this.play = play;
        this.art = art;

        nBuilder = new NotificationCompat.Builder(parent, "media_notification")
                .setSmallIcon(R.drawable.ic_stat_music_note)
                .setPriority(Notification.PRIORITY_DEFAULT)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setOngoing(this.play)
                .setOnlyAlertOnce(true)
                .setVibrate(new long[]{0L})
                .setSound(null);

        remoteView = new RemoteViews(parent.getPackageName(), R.layout.notificationlayout);

        remoteView.setTextViewText(R.id.title, title);
        remoteView.setTextViewText(R.id.author, author);
        File f = new File(art);
        Bitmap myBitmap = BitmapFactory.decodeFile(f.getAbsolutePath());
        remoteView.setImageViewBitmap(R.id.art, myBitmap);

        if (this.play) {
            remoteView.setImageViewResource(R.id.toggle, R.drawable.baseline_pause_black_48);
        } else {
            remoteView.setImageViewResource(R.id.toggle, R.drawable.baseline_play_arrow_black_48);
        }

        setListeners(remoteView);
        nBuilder.setContent(remoteView);

        Notification notification = nBuilder.build();

        nManager = (NotificationManager) parent.getSystemService(Context.NOTIFICATION_SERVICE);
        nManager.notify(1, notification);
    }

    public void setListeners(RemoteViews view){
        // Пауза/Воспроизведение
        Intent intent = new Intent(parent, NotificationReturnSlot.class)
            .setAction("toggle")
            .putExtra("title", this.title)
            .putExtra("author", this.author)
            .putExtra("action", !this.play ? "play" : "pause")
            .putExtra("path",this.art)
            .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(parent, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        view.setOnClickPendingIntent(R.id.toggle, pendingIntent);

        // Вперед
        Intent nextIntent = new Intent(parent, NotificationReturnSlot.class)
                .setAction("next");
        PendingIntent pendingNextIntent = PendingIntent.getBroadcast(parent, 0, nextIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        view.setOnClickPendingIntent(R.id.next, pendingNextIntent);

        // Назад
        Intent prevIntent = new Intent(parent, NotificationReturnSlot.class)
                .setAction("prev");
        PendingIntent pendingPrevIntent = PendingIntent.getBroadcast(parent, 0, prevIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        view.setOnClickPendingIntent(R.id.prev, pendingPrevIntent);

        // Нажатие на уведомление
        Intent selectIntent = new Intent(parent, NotificationReturnSlot.class)
                .setAction("select");
        PendingIntent selectPendingIntent = PendingIntent.getBroadcast(parent, 0, selectIntent, PendingIntent.FLAG_CANCEL_CURRENT);
        view.setOnClickPendingIntent(R.id.layout, selectPendingIntent);
    }


    public void notificationCancel() {
        nManager.cancel(1);
    }
}

