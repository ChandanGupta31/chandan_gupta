import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // The primary accent. High energy, "Cyber" feel.
  static const Color primary = Color(0xFF00E5FF); 
  
  // Secondary accent for subtle highlights or gradients
  static const Color secondary = Color(0xFF2979FF); 

  // --- Backgrounds ---
  // Deep dark for the main background (OLED friendly)
  static const Color background = Color(0xFF0A0A0A); 
  
  // Slightly lighter for cards/containers (Elevation 1)
  static const Color surface = Color(0xFF1E1E1E); 
  
  // Even lighter for hover states or inputs (Elevation 2)
  static const Color surfaceLight = Color(0xFF2C2C2C); 

  // --- Typography ---
  // Headings
  static const Color textPrimary = Color(0xFFF5F5F5); 
  
  // Body
  static const Color textSecondary = Color(0xFFB0BEC5); 
  
  // disabled text, placeholders
  static const Color textDisabled = Color(0xFF757575); 

  // --- Functional ---
  static const Color error = Color(0xFFCF6679);
  static const Color success = Color(0xFF00C853);
  
  // A semi-transparent overlay for glassmorphism effects
  static const Color glassOverlay = Color(0x1AFFFFFF); 
}