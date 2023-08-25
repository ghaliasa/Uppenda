class QuestionModel{


  String id;
  String question;

  QuestionModel({this.id,this.question});

  QuestionModel.fromJson(Map<String, dynamic> json){
    this.id       = json["id"];
    this.question = json["question"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']          = this.id;
    data['question']    = this.question;
    return data;
  }



}