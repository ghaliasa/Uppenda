class TypeModel{
  String id;
  String typename;


  TypeModel({this.id, this.typename}) ;

  TypeModel.fromJson(Map<String, dynamic> json){
      this.id       = json["id"].toString();
      this.typename = json["typename"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']          = this.id;
    data['typename']    = this.typename;
    return data;
  }

    String getId() {
    return id;
  }


  String getName() {
    return typename;
  }
}
