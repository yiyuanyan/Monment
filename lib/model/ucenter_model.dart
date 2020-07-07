class UcenterModel {
  int code;
  String message;
  UserInfo userInfo;
  List<UserDynamic> userDynamic;

  UcenterModel({this.code, this.message, this.userInfo, this.userDynamic});

  UcenterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    if (json['user_dynamic'] != null) {
      userDynamic = new List<UserDynamic>();
      json['user_dynamic'].forEach((v) {
        userDynamic.add(new UserDynamic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    if (this.userDynamic != null) {
      data['user_dynamic'] = this.userDynamic.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int userId;
  String backgroundImg;
  String userImgBig;
  String userName;
  String userDesc;
  int follow;
  String fans;

  UserInfo(
      {this.userId,
        this.backgroundImg,
        this.userImgBig,
        this.userName,
        this.userDesc,
        this.follow,
        this.fans});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    backgroundImg = json['background_img'];
    userImgBig = json['user_img_big'];
    userName = json['user_name'];
    userDesc = json['user_desc'];
    follow = json['follow'];
    fans = json['fans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['background_img'] = this.backgroundImg;
    data['user_img_big'] = this.userImgBig;
    data['user_name'] = this.userName;
    data['user_desc'] = this.userDesc;
    data['follow'] = this.follow;
    data['fans'] = this.fans;
    return data;
  }
}

class UserDynamic {
  int id;
  int type;
  String userImgSmall;
  String userName;
  String releaseTime;
  String desc;
  String thumb;
  String watch;
  String playTime;
  String title;
  int like;
  int message;
  int forward;

  UserDynamic(
      {this.id,
        this.type,
        this.userImgSmall,
        this.userName,
        this.releaseTime,
        this.desc,
        this.thumb,
        this.watch,
        this.playTime,
        this.title,
        this.like,
        this.message,
        this.forward});

  UserDynamic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userImgSmall = json['user_img_small'];
    userName = json['user_name'];
    releaseTime = json['release_time'];
    desc = json['desc'];
    thumb = json['thumb'];
    watch = json['watch'];
    playTime = json['play_time'];
    title = json['title'];
    like = json['like'];
    message = json['message'];
    forward = json['forward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['user_img_small'] = this.userImgSmall;
    data['user_name'] = this.userName;
    data['release_time'] = this.releaseTime;
    data['desc'] = this.desc;
    data['thumb'] = this.thumb;
    data['watch'] = this.watch;
    data['play_time'] = this.playTime;
    data['title'] = this.title;
    data['like'] = this.like;
    data['message'] = this.message;
    data['forward'] = this.forward;
    return data;
  }
}