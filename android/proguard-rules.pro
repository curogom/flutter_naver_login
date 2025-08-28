# Flutter Naver Login Plugin ProGuard Rules
# These rules are automatically applied when using this library with R8/ProGuard

# === R8 FULL MODE SETTINGS ===
# Full mode enabled - all optimizations active
# Comment out lines below and uncomment compatibility mode lines if issues persist
# -android
# -dontoptimize

# Fix for XmlPullParser issue
-dontwarn org.xmlpull.v1.**
-keep class org.xmlpull.** { *; }
-keep interface org.xmlpull.** { *; }

# Keep Flutter plugin entry point
-keep class com.example.flutter_naver_login.FlutterNaverLoginPlugin {
    public <init>();
    public *;
}

# Keep ALL Naver SDK classes - R8 aggressive optimization breaks the SDK
-keep class com.navercorp.** { *; }
-keep interface com.navercorp.** { *; }
-keep enum com.navercorp.** { *; }

# Keep NHN legacy classes if present
-keep class com.nhn.** { *; }
-keep interface com.nhn.** { *; }
-keep enum com.nhn.** { *; }

# Keep all classes that might be accessed via reflection
-keepclasseswithmembers class * {
    @com.navercorp.nid.* <methods>;
}
-keepclasseswithmembers class * {
    @com.navercorp.nid.* <fields>;
}

# Keep data classes used for serialization
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Suppress warnings for Naver SDK
-dontwarn com.navercorp.nid.**
-dontwarn com.nhn.android.naverlogin.**

# Keep Kotlin metadata for reflection
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Preserve generic type information for R8 Full Mode
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations
-keepattributes RuntimeInvisibleParameterAnnotations

# Android XML parser
-keep class android.content.res.XmlResourceParser { *; }
-dontwarn android.content.res.XmlResourceParser

# Ignore missing Google Play Core library classes (optional dependency)
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Ignore missing error-prone annotations
-dontwarn com.google.errorprone.annotations.**

# Ignore missing Conscrypt classes (optional SSL provider)
-dontwarn org.conscrypt.**

# Ignore missing OpenJSSE classes (optional SSL provider)
-dontwarn org.openjsse.**

# Ignore missing Google API Client classes
-dontwarn com.google.api.client.**
-dontwarn org.joda.time.**

# Google Crypto Tink (optional dependency)
-dontwarn com.google.crypto.tink.**

# OkHttp platform detection
-dontwarn okhttp3.internal.platform.**

# ========== CRITICAL: R8 Full Mode Compatibility Rules ==========

# Gson - JSON serialization library used by Naver SDK
-keepattributes Signature
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Fix for java.lang.Class cannot be cast to java.lang.reflect.ParameterizedType
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keepclassmembers class * extends com.google.gson.reflect.TypeToken {
    <fields>;
    <methods>;
}

# Retrofit - HTTP client used by Naver SDK
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}
-keep interface retrofit2.** { *; }
-keep class retrofit2.** { *; }
-keepclasseswithmembers class * {
    @retrofit2.* <methods>;
}

# Retrofit with Gson converter
-keep class * implements retrofit2.Converter$Factory
-keep class * implements retrofit2.CallAdapter$Factory

# Moshi - Alternative JSON library used by Naver SDK
-keep class com.squareup.moshi.** { *; }
-keep interface com.squareup.moshi.** { *; }
-keep class * extends com.squareup.moshi.JsonAdapter
-keep @com.squareup.moshi.JsonQualifier interface *
-keepclassmembers class * {
    @com.squareup.moshi.Json <fields>;
}

# Kotlin reflection - Critical for Moshi Kotlin support
-keep class kotlin.reflect.** { *; }
-keep class kotlin.Metadata { *; }
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}
-keepclassmembers class * {
    @kotlin.Metadata <methods>;
}

# OkHttp - HTTP client
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Fix generic type erasure issues in R8 Full Mode
-keepclassmembers class * {
    @retrofit2.http.* <methods>;
}
-keep class * implements java.lang.reflect.ParameterizedType { *; }
-keep class java.lang.reflect.ParameterizedType { *; }

# Keep classes that extend generic base classes (common source of cast exceptions)
-keep class * extends java.lang.reflect.Type { *; }
-keep class * implements java.lang.reflect.Type { *; }

# CRITICAL: Prevent R8 from optimizing away generic type information
-keep,allowobfuscation class ** {
    java.lang.reflect.Type getGenericSuperclass();
    java.lang.reflect.Type[] getGenericInterfaces();
}
-keepclassmembers class * {
    java.lang.Class getSuperclass();
    java.lang.Class[] getInterfaces();
}

# Keep all Type and ParameterizedType implementations in Naver SDK
-keep class com.navercorp.** implements java.lang.reflect.Type { *; }
-keep class com.navercorp.** implements java.lang.reflect.ParameterizedType { *; }

# Keep TypeToken pattern used by Gson
-keep class * extends com.google.gson.reflect.TypeToken { 
    protected <init>();
    public <init>();
}

# Preserve generic signatures of all Naver SDK classes
-keep,allowobfuscation,allowshrinking class com.navercorp.** {
    <fields>;
    <methods>;
}
-keepattributes Signature
-keepattributes *Annotation*

# Keep Retrofit's generic type handling
-keep,allowobfuscation class retrofit2.DefaultCallAdapterFactory { *; }
-keep,allowobfuscation class retrofit2.CompletableFutureCallAdapterFactory { *; }