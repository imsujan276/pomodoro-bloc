String formatDuration(int sec) {
  final Duration duration = Duration(seconds: sec);
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return (hours != "0") ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
}
