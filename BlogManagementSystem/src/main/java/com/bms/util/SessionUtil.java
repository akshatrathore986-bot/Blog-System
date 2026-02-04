package com.bms.util;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Simple session helper for common session operations.
 * - flash messages (one-time messages)
 * - storing / retrieving user object helpers (optional)
 *
 * Put this class under package: com.bms.util
 */
public final class SessionUtil {

    private SessionUtil() { /* utility class */ }

    // FLASH MESSAGE KE LIYE SESSION KEY
    private static final String FLASH_KEY = "BMS_FLASH_MESSAGES";

    /**
     * Store a flash message in session. Flash messages are stored under a map and removed when fetched.
     *
     * @param session HttpSession
     * @param type one of "success", "error", "info", etc.
     * @param message message text
     */
    @SuppressWarnings("unchecked")
    public static void setFlashMessage(HttpSession session, String type, String message) {
        if (session == null) return;
        Map<String, String> flash = (Map<String, String>) session.getAttribute(FLASH_KEY);
        if (flash == null) {
            flash = new HashMap<>();
            session.setAttribute(FLASH_KEY, flash);
        }
        flash.put(type, message);
    }

    /**
     * Get and remove a flash message of given type.
     * Returns null if not present.
     *
     * @param session HttpSession
     * @param type flash type
     * @return message or null
     */
    @SuppressWarnings("unchecked")
    public static String consumeFlashMessage(HttpSession session, String type) {
        if (session == null) return null;
        Map<String, String> flash = (Map<String, String>) session.getAttribute(FLASH_KEY);
        if (flash == null) return null;
        String msg = flash.remove(type);
        // if map empty, remove attribute
        if (flash.isEmpty()) {
            session.removeAttribute(FLASH_KEY);
        } else {
            session.setAttribute(FLASH_KEY, flash);
        }
        return msg;
    }

    /**
     * Peek (read without removing) a flash message.
     *
     * @param session HttpSession
     * @param type flash message type
     * @return message or null
     */
    @SuppressWarnings("unchecked")
    public static String peekFlashMessage(HttpSession session, String type) {
        if (session == null) return null;
        Map<String, String> flash = (Map<String, String>) session.getAttribute(FLASH_KEY);
        return (flash == null) ? null : flash.get(type);
    }

    /**
     * Convenience: store an arbitrary attribute in session.
     */
    public static void setAttribute(HttpSession session, String key, Object value) {
        if (session == null) return;
        session.setAttribute(key, value);
    }

    /**
     * Convenience: get an attribute from session.
     */
    @SuppressWarnings("unchecked")
    public static <T> T getAttribute(HttpSession session, String key, Class<T> type) {
        if (session == null) return null;
        Object o = session.getAttribute(key);
        return (o == null) ? null : (T) o;
    }

    /**
     * Remove an attribute.
     */
    public static void removeAttribute(HttpSession session, String key) {
        if (session == null) return;
        session.removeAttribute(key);
    }

    // Optional small helpers for logged-in user (if you prefer)
    public static final String LOGGED_IN_USER = "loggedInUser";
    public static void setLoggedInUser(HttpSession session, Object user) {
        setAttribute(session, LOGGED_IN_USER, user);
    }
    public static <T> T getLoggedInUser(HttpSession session, Class<T> type) {
        return getAttribute(session, LOGGED_IN_USER, type);
    }
}
