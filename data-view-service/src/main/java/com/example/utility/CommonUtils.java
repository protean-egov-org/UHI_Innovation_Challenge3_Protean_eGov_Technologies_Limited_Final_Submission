package com.example.utility;

import java.text.SimpleDateFormat;
import java.util.*;

public class CommonUtils {
    CommonUtils() {
        throw new IllegalStateException("Utility class");
    }

    public static String getTime() {

        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US);
        format1.setTimeZone(TimeZone.getTimeZone("UTC"));
        return format1.format(new Date());
    }

    public static String getCurrentTimePlusDays(int days) {
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US);
        format1.setTimeZone(TimeZone.getTimeZone("UTC"));

        Calendar calendar= Calendar.getInstance();
        calendar.add(Calendar.DATE, days);
        Date date=calendar.getTime();

        return format1.format(date);
    }
}
