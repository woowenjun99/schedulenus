class Module {
  final String description;
  final String moduleCode;
  final String moduleCredit;
  final String title;

  const Module({
    required this.description,
    required this.moduleCode,
    required this.moduleCredit,
    required this.title,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      description: json["description"],
      moduleCredit: json["moduleCredit"],
      moduleCode: json["moduleCode"],
      title: json["title"],
    );
  }
}
