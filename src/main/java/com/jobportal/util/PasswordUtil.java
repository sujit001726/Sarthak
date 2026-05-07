package com.jobportal.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for BCrypt password hashing and verification.
 */
public class PasswordUtil {

    private static final int WORK_FACTOR = 12;

    /**
     * Hashes a plain-text password using BCrypt.
     */
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(WORK_FACTOR));
    }

    /**
     * Verifies a plain-text password against a stored BCrypt hash.
     */
    public static boolean verifyPassword(String plainTextPassword, String hashedPassword) {
        if (plainTextPassword == null || hashedPassword == null) {
            return false;
        }
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }

    /** Run once to generate a hash: mvnw exec:java -Dexec.mainClass=com.jobportal.util.PasswordUtil */
    public static void main(String[] args) {
        String password = args.length > 0 ? args[0] : "admin123";
        System.out.println(hashPassword(password));
    }
}
