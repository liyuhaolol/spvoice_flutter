class Channel {
  int _allowTopNumber;
  int _channelId;
  String _channelName;
  bool _containSubcolumn;
  int _openTopLevel;

  int get allowTopNumber => _allowTopNumber;
  int get channelId => _channelId;
  String get channelName => _channelName;
  bool get containSubcolumn => _containSubcolumn;
  int get openTopLevel => _openTopLevel;

  Channel({
    int allowTopNumber,
    int channelId,
    String channelName,
    bool containSubcolumn,
    int openTopLevel}){
    _allowTopNumber = allowTopNumber;
    _channelId = channelId;
    _channelName = channelName;
    _containSubcolumn = containSubcolumn;
    _openTopLevel = openTopLevel;
  }

  Channel.fromJson(dynamic json) {
    _allowTopNumber = json["allowTopNumber"];
    _channelId = json["channelId"];
    _channelName = json["channelName"];
    _containSubcolumn = json["containSubcolumn"];
    _openTopLevel = json["openTopLevel"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["allowTopNumber"] = _allowTopNumber;
    map["channelId"] = _channelId;
    map["channelName"] = _channelName;
    map["containSubcolumn"] = _containSubcolumn;
    map["openTopLevel"] = _openTopLevel;
    return map;
  }

}