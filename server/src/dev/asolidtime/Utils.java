package dev.asolidtime;

public class Utils {
    public static int ensureRange(int value, int min, int max) {
        return Math.min(Math.max(value, min), max);
    }
}
