class Module {
  final String description;
  final String moduleCode;
  final String title;

  const Module({
    required this.description,
    required this.moduleCode,
    required this.title,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      description: json["description"],
      moduleCode: json["moduleCode"],
      title: json["title"],
    );
  }
}
