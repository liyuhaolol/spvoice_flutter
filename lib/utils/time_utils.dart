import 'package:date_format/date_format.dart';

class TimeUtils{
  static const int _second = 1000;
  static const int _minute = 60 * 1000;
  static const int _hour = 60 * _minute;
  static const int _day = 24 * _hour;

  static String getShowTime(int timeSeconds){
    int time = DateTime.now().millisecondsSinceEpoch;
    int diff = time - timeSeconds;
    int r= 0;

    if (diff > _second){
      r = (diff ~/_second);
      if (r < 59){//大于秒
        return "$r秒前";
      }
    }

    if (diff > _minute){
      r = (diff  ~/ _minute);
      if (r < 59){
        return "$r分钟前";
      }
    }

    if (diff > _hour){
      r = (diff  ~/ _hour);
      if (r < 24){
        return "$r小时前";
      }
    }

    return formatDate(DateTime.fromMillisecondsSinceEpoch(timeSeconds), [yyyy, '-', mm, '-', dd]);
  }
}