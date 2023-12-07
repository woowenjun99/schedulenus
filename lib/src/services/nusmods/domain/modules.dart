class SimplifiedModule {
  final String moduleCode;
  final List<int> semesters;
  final String title;

  const SimplifiedModule({
    required this.moduleCode,
    required this.semesters,
    required this.title,
  });

  factory SimplifiedModule.fromJson(Map<String, dynamic> json) {
    return SimplifiedModule(
      moduleCode: json["moduleCode"],
      semesters: json["semesters"],
      title: json["title"],
    );
  }
}
