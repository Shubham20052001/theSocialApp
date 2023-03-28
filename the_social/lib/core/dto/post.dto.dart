class PostDTO {
  final String post_title;
  final String post_images;
  final String useremail;

  const PostDTO(
      {required this.post_title,
      required this.post_images,
      required this.useremail});

  Map<String, dynamic> toJson() {
    return {"post_title": post_title, "post_images": post_images};
  }
}
