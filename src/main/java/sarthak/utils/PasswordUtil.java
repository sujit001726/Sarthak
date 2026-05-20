package sarthak.utils;

/**
 * Utility class for BCrypt password hashing and verification.
 */
public class PasswordUtil {

    /**
     * Hashes a plain-text password (skeleton: returns plain text for now).
     */
    public static String hashPassword(String plainTextPassword) {
        return plainTextPassword;
    }

    /**
     * Verifies a plain-text password (skeleton: direct comparison for now).
     */
    public static boolean verifyPassword(String plainTextPassword, String hashedPassword) {
        if (plainTextPassword == null || hashedPassword == null) {
            return false;
        }
        return plainTextPassword.equals(hashedPassword);
    }
}
