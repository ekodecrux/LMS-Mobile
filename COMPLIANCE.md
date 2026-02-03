# App Store Compliance Guide

This document provides a comprehensive checklist to ensure your Flutter apps meet the compliance requirements for both the Google Play Store and Apple App Store.

## Table of Contents

1.  [Google Play Store Compliance](#google-play-store-compliance)
2.  [Apple App Store Compliance](#apple-app-store-compliance)
3.  [General Best Practices](#general-best-practices)

---

## Google Play Store Compliance

### 1. App Content & Metadata

-   [ ] **App Title (50 chars):** Unique and not misleading.
-   [ ] **Short Description (80 chars):** Concise summary of the app's purpose.
-   [ ] **Full Description (4000 chars):** Detailed, accurate, and keyword-rich description.
-   [ ] **Screenshots:**
    -   Minimum 2, maximum 8 per device type (phone, tablet).
    -   JPEG or 24-bit PNG (no alpha).
    -   No status bar notifications or personal info.
-   [ ] **High-res Icon (512x512):** 32-bit PNG with alpha.
-   [ ] **Feature Graphic (1024x500):** JPEG or 24-bit PNG.
-   [ ] **Video (Optional):** YouTube URL, 30-120 seconds.
-   [ ] **Categorization:** Correct app type and category.
-   [ ] **Content Rating:** Complete the content rating questionnaire accurately.
-   [ ] **Contact Details:** Provide a valid email address.
-   [ ] **Privacy Policy:**
    -   Provide a publicly accessible URL to your privacy policy.
    -   The policy must disclose how user data is collected, used, and shared.

### 2. Technical Requirements

-   [ ] **Target API Level:** Target at least Android 13 (API level 33) or higher.
-   [ ] **Android App Bundle (AAB):** Upload your app as an AAB.
-   [ ] **64-bit Requirement:** Ensure your app has 64-bit native libraries.
-   [ ] **Permissions:**
    -   Request only necessary permissions.
    -   Provide clear justification for sensitive permissions (e.g., location, camera).
-   [ ] **Keystore:** Securely store your app signing key. **Losing it means you cannot update your app.**

### 3. Policies & Guidelines

-   [ ] **User-Generated Content (UGC):** If your app has UGC, you must have a system to filter/moderate objectionable content and a way for users to report it.
-   [ ] **Ads:** Comply with the Ads Policy. No disruptive or deceptive ads.
-   [ ] **Payments:** Use Google Play's billing system for in-app purchases of digital goods.
-   [ ] **Families Policy:** If your app targets children, you must comply with the Families Policy Requirements.
-   [ ] **Data Safety Section:**
    -   Accurately complete the Data Safety form in the Play Console.
    -   Declare all types of data you collect and share.

---

## Apple App Store Compliance

### 1. App Content & Metadata

-   [ ] **App Name (30 chars):** Unique and relevant.
-   [ ] **Subtitle (30 chars):** Catchy and descriptive.
-   [ ] **Promotional Text (170 chars):** Can be updated anytime without a new build.
-   [ ] **Description (4000 chars):** Detailed and persuasive.
-   [ ] **Keywords (100 chars total):** Comma-separated.
-   [ ] **App Icon:** All required sizes provided in `Assets.xcassets`.
-   [ ] **Screenshots & App Previews:**
    -   Provide for all required device sizes.
    -   Must accurately reflect the app's UI and functionality.
-   [ ] **Categories:** Select a primary and optional secondary category.
-   [ ] **Age Rating:** Complete the questionnaire accurately.
-   [ ] **Privacy Policy URL:** Required.
-   [ ] **Support URL:** Required.

### 2. Technical Requirements

-   [ ] **Built with Xcode 14+ and iOS 16+ SDK:** Ensure your app is built with modern tools.
-   [ ] **Launch Screen:** Use a storyboard for the launch screen.
-   [ ] **App Tracking Transparency (ATT):**
    -   If you track users, you must request permission using the ATT framework.
    -   Provide a clear `NSUserTrackingUsageDescription` in `Info.plist`.
-   [ ] **Permissions (Info.plist):**
    -   Provide usage descriptions (e.g., `NSCameraUsageDescription`) for all sensitive permissions.
-   [ ] **Sign in with Apple:** If your app uses third-party login services (e.g., Google, Facebook), you must also offer Sign in with Apple.

### 3. Policies & Guidelines (App Review)

-   [ ] **Guideline 2.1 - App Completeness:** Your app must be a finished product, free of crashes and bugs.
-   [ ] **Guideline 2.3 - Accurate Metadata:** Your app's metadata must be honest and not misleading.
-   [ ] **Guideline 3.1.1 - In-App Purchase:** Use Apple's IAP system for digital goods and services.
-   [ ] **Guideline 4.0 - Design:** Your app should follow Apple's Human Interface Guidelines.
-   [ ] **Guideline 5.1 - Privacy:**
    -   **5.1.1 Data Collection and Storage:** Be transparent about data collection.
    -   **App Privacy Details:** Accurately fill out the App Privacy section on App Store Connect.

---

## General Best Practices

-   [ ] **Test Thoroughly:** Test your app on a wide range of devices and OS versions.
-   [ ] **Respect Intellectual Property:** Do not use copyrighted materials without permission.
-   [ ] **Provide a Great User Experience:** Ensure your app is intuitive, responsive, and useful.
-   [ ] **Regularly Update:** Keep your app updated to support new OS features and fix bugs.
