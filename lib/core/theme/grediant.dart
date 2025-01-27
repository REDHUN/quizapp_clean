import 'dart:math';

import 'package:flutter/material.dart';

class GradientColors {
  static final List<List<Color>> gradients = [
    // Deep Ocean
    [const Color(0xFF2E3192), const Color(0xFF1BFFFF)],

    // Sunset Vibes
    [const Color(0xFFFF6B6B), const Color(0xFF556270)],

    // Forest Fresh
    [const Color(0xFF134E5E), const Color(0xFF71B280)],

    // Royal Purple
    [const Color(0xFF654EA3), const Color(0xFFEAAFC8)],

    // Electric Violet
    [const Color(0xFF4776E6), const Color(0xFF8E54E9)],

    // Coral Reef
    [const Color(0xFFFF8008), const Color(0xFFFFC837)],

    // Midnight City
    [const Color(0xFF232526), const Color(0xFF414345)],

    // Spring Warmth
    [const Color(0xFFee9ca7), const Color(0xFFffdde1)],

    // Ocean View
    [const Color(0xFF36D1DC), const Color(0xFF5B86E5)],

    // Crimson Night
    [const Color(0xFFED213A), const Color(0xFF93291E)],

    // Emerald Dream
    [const Color(0xFF11998e), const Color(0xFF38ef7d)],

    // Deep Space
    [const Color(0xFF000428), const Color(0xFF004e92)],

    // Golden Hour
    [const Color(0xFFf46b45), const Color(0xFFeea849)],

    // Arctic Aurora
    [const Color(0xFF9D50BB), const Color(0xFF6E48AA)],

    // Tropical Paradise
    [const Color(0xFF00B4DB), const Color(0xFF0083B0)],
  ];

  static List<Color> getRandomGradient() {
    final random = Random();
    return gradients[random.nextInt(gradients.length)];
  }

  static List<Color> getGradientByIndex(int index) {
    return gradients[index % gradients.length];
  }
}
