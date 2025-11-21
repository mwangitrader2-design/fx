enum TimeframeType {
  M1, // 1 minute
  M5, // 5 minutes
  M15, // 15 minutes
  M30, // 30 minutes
  H1, // 1 hour
  H4, // 4 hours
  D1, // 1 day
  W1, // 1 week
  MN1 // 1 month
}

extension TimeframeTypeExtension on TimeframeType {
  String get displayName {
    switch (this) {
      case TimeframeType.M1:
        return '1 Minute';
      case TimeframeType.M5:
        return '5 Minutes';
      case TimeframeType.M15:
        return '15 Minutes';
      case TimeframeType.M30:
        return '30 Minutes';
      case TimeframeType.H1:
        return '1 Hour';
      case TimeframeType.H4:
        return '4 Hours';
      case TimeframeType.D1:
        return '1 Day';
      case TimeframeType.W1:
        return '1 Week';
      case TimeframeType.MN1:
        return '1 Month';
    }
  }

  int get minutes {
    switch (this) {
      case TimeframeType.M1:
        return 1;
      case TimeframeType.M5:
        return 5;
      case TimeframeType.M15:
        return 15;
      case TimeframeType.M30:
        return 30;
      case TimeframeType.H1:
        return 60;
      case TimeframeType.H4:
        return 240;
      case TimeframeType.D1:
        return 1440;
      case TimeframeType.W1:
        return 10080;
      case TimeframeType.MN1:
        return 43200;
    }
  }
}
