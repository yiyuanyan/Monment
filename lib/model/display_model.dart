class DisplayModel {
  VideoInfo videoInfo;
  List<Relevant> relevant;
  int stateCode;
  String message;

  DisplayModel({this.videoInfo, this.relevant, this.stateCode, this.message});

  DisplayModel.fromJson(Map<String, dynamic> json) {
    videoInfo = json['video_info'] != null
        ? new VideoInfo.fromJson(json['video_info'])
        : null;
    if (json['relevant'] != null) {
      relevant = new List<Relevant>();
      json['relevant'].forEach((v) {
        relevant.add(new Relevant.fromJson(v));
      });
    }
    stateCode = json['stateCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoInfo != null) {
      data['video_info'] = this.videoInfo.toJson();
    }
    if (this.relevant != null) {
      data['relevant'] = this.relevant.map((v) => v.toJson()).toList();
    }
    data['stateCode'] = this.stateCode;
    data['message'] = this.message;
    return data;
  }
}

class VideoInfo {
  int id;
  String videoPath;
  String videoName;
  String videoTag;
  String videoDesc;
  int videoLike;
  int videoShare;
  int videoMessage;
  String userImg;
  String userName;
  String regTime;

  VideoInfo(
      {this.id,
        this.videoPath,
        this.videoName,
        this.videoTag,
        this.videoDesc,
        this.videoLike,
        this.videoShare,
        this.videoMessage,
        this.userImg,
        this.userName,
        this.regTime});

  VideoInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoPath = json['video_path'];
    videoName = json['video_name'];
    videoTag = json['video_tag'];
    videoDesc = json['video_desc'];
    videoLike = json['video_like'];
    videoShare = json['video_share'];
    videoMessage = json['video_message'];
    userImg = json['user_img'];
    userName = json['user_name'];
    regTime = json['reg_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_path'] = this.videoPath;
    data['video_name'] = this.videoName;
    data['video_tag'] = this.videoTag;
    data['video_desc'] = this.videoDesc;
    data['video_like'] = this.videoLike;
    data['video_share'] = this.videoShare;
    data['video_message'] = this.videoMessage;
    data['user_img'] = this.userImg;
    data['user_name'] = this.userName;
    data['reg_time'] = this.regTime;
    return data;
  }
}

class Relevant {
  int id;
  String thumb;
  String title;
  String tag;
  String playTime;

  Relevant({this.id, this.thumb, this.title, this.tag, this.playTime});

  Relevant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumb = json['thumb'];
    title = json['title'];
    tag = json['tag'];
    playTime = json['play_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumb'] = this.thumb;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['play_time'] = this.playTime;
    return data;
  }
}