class Announce {
  dynamic id;
  String img;
  String title;
  String description;
  String dealtype;
  String propretytype;
  int roomnumber;
  int surface;
  int price;
  int viewsnumber;
  Announce(
      this.id,
      this.img,
      this.title,
      this.description,
      this.dealtype,
      this.propretytype,
      this.roomnumber,
      this.surface,
      this.viewsnumber,
      this.price);
  Announce.fromJson(Map json)
      : id = json['id'],
        img=json['img'],
        title = json['title'],
        description = json['description'],
        dealtype = json['dealtype'],
        propretytype = json['propretytype'],
        roomnumber = json['roomnumber'],
        surface = json['surface'],
        viewsnumber = json['viewsnumber'],
        price = json['price'];
}
