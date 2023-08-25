import 'package:ppp/Model/QuestionModel.dart';

import 'UserModel.dart';

class AnswerModel {
  String id;
  String answer;
  UserModel user;
  QuestionModel question;

  AnswerModel({this.id, this.answer, this.question, this.user});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.answer = json["answer"];
    if (json["user"] != null) this.user = UserModel.fromJson(json["user"]);
    if (json["question"] != null)
      this.question = QuestionModel.fromJson(json["question"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    if (this.user != null) data['user'] = this.user.toJson();
    if (this.question != null) data['question'] = this.question.toJson();
    return data;
  }

  get getId => this.id;

  set setId(id) => this.id = id;

  get getAnswer => this.answer;

  set setAnswer(answer) => this.answer = answer;

  get getQuestion => this.question;

  set setQuestion(question) => this.question = question;

  get getUser => this.user;

  set setUsers(user) => this.user = user;
}
