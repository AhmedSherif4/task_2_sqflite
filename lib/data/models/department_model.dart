import 'package:equatable/equatable.dart';

// باخد اكستند من الانتيتي عشان اشوفه هو عاوز اية وهبعتهوله، عاوز داتا؟ عينيا حاضر هبعتهالك عن طريق السوبر ياحبيب اخوك
class DepartmentModel extends Equatable {
  final int? id;
  final String title;
  final String body;
  final String imagePath;

  const DepartmentModel(
      {this.id,
      required this.title,
      required this.body,
      required this.imagePath});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json['id'],
        imagePath: json['imagePath'],
        title: json['title'],
        body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'imagePath': imagePath, 'title': title, 'body': body};
  }

  @override
  List<Object?> get props => [id, title, body, imagePath];
}
