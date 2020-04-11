class MovieModel {
  final int idx;
  final String img;
  final String title;
  final String seconDaryImg;

  MovieModel(this.idx, this.img, this.title, this.seconDaryImg);
}

List<MovieModel> movies = [
  MovieModel(
    0,
    "early_man.jpg",
    "early man",
    "early_man2.jpg",
  ),
  MovieModel(
    1,
    "infinity_war.jpg",
    "avengers\ninfinity war",
    "infinity_war2.jpg",
  ),
  MovieModel(
    2,
    "the_grinch.jpg",
    "the grinch",
    "the_grinch2.jpg",
  ),
];
