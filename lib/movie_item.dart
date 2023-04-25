class MovieItem {
  String title;
  String year;
  String? imdbIDm;
  String type;
  String poster;

  MovieItem(
      {this.imdbIDm,
      required this.poster,
      required this.title,
      required this.type,
      required this.year});
}
