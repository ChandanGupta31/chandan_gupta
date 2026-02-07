class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? liveUrl;
  final String? githubUrl;
  final String? imageUrl;
  final int priority;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.liveUrl,
    this.githubUrl,
    this.imageUrl,
    this.priority = 99,
  });

  // Factory constructor to create a Project from Firestore data
  factory Project.fromMap(String id, Map<String, dynamic> map) {
    return Project(
      id: id,
      title: map['title'] ?? 'Untitled Project',
      description: map['description'] ?? 'No description available.',
      technologies: List<String>.from(map['technologies'] ?? []),
      liveUrl: map['live_url'],
      githubUrl: map['github_url'],
      imageUrl: map['image_url'],
      priority: map['priority'] ?? 99,
    );
  }

  // Convert Project back to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'technologies': technologies,
      'live_url': liveUrl,
      'github_url': githubUrl,
      'image_url': imageUrl,
      'priority': priority,
    };
  }
}