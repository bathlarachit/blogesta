String def =
    "https://images.unsplash.com/photo-1554188248-986adbb73be4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80";


class Blog {
  final title;
  final url;
  final content;
  final author;
  Blog({this.title, this.url, this.content, this.author});

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "url": this.url??def,
      "content": this.content,
      "author": this.author
    };
  }
}
