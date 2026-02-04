package com.bms.util;

import java.text.Normalizer;
import java.util.Locale;
import java.util.regex.Pattern;

public class SlugUtil {

    // Old patterns (generateSlug ke liye)
    private static final Pattern NONLATIN = Pattern.compile("[^\\w-]");
    private static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    // Simple URL-friendly slug (tumhara pehla method)
    public static String toSlug(String input) {
        if (input == null) {
            return "";
        }

        String slug = input.trim().toLowerCase();

        // non-alphanumeric ko hatao
        slug = slug.replaceAll("[^a-z0-9\\s-]", "");

        // multiple spaces/dash ko single dash
        slug = slug.replaceAll("[\\s-]+", "-");

        // starting/ending dash hatao
        slug = slug.replaceAll("^-+|-+$", "");

        return slug;
    }

    // Normalizer wale method (agar ye use karna ho)
    public static String generateSlug(String input) {
        if (input == null) {
            return "";
        }

        String nowhitespace = WHITESPACE.matcher(input.trim()).replaceAll("-");
        String normalized = Normalizer.normalize(nowhitespace, Normalizer.Form.NFD);
        String slug = NONLATIN.matcher(normalized).replaceAll("");
        return slug.toLowerCase(Locale.ENGLISH);
    }

    // Unique slug banane ke liye
    public static String generateUniqueSlug(String baseSlug, int counter) {
        return baseSlug + "-" + counter;
    }
}
