abstract class ApiUrl{
  static String baseUrl = 'https://api.themoviedb.org';
  static String trendingMovies = '/3/trending/movie/day';
  static String upcomingMovies = '/3/movie/upcoming';
  static String imagePrefix = 'https://image.tmdb.org/t/p/w500';
  static String genreList = '/3/genre/movie/list';
  static String movieImages = '/3/movie/{movie_id}/images';
  static String movieDetails = '/3/movie/';
  static String movieSearch = '/3/search/movie';

  // We should store it in env file or secure it other way but for demo purpose I am making it static
  static String TMDBAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiODZhMzk4YWIzMzc4MDdmNjA4YWQ4MDAyMDI2NTliNyIsIm5iZiI6MTcyNTE3MDE4NC4wNjk2NDksInN1YiI6IjY2ZDNmZjU1MmE3NTdlMTA0ODc4ZWE5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2w-AXcVLijsFo3mMPtqPanR3z6Lv37QHqBOVmmQSEJo';
}