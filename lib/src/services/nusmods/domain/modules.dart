class Module {
  final String description;
  final String department;
  final String moduleCode;
  final String moduleCredit;
  final String title;

  const Module({
    required this.description,
    required this.department,
    required this.moduleCode,
    required this.moduleCredit,
    required this.title,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      description: json["description"],
      department: json["department"],
      moduleCredit: json["moduleCredit"],
      moduleCode: json["moduleCode"],
      title: json["title"],
    );
  }
}
