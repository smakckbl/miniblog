import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticlesInitial());

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticles) {
      yield* _mapFetchArticlesToState();
    } else if (event is AddArticle) {
      // AddArticle event handling
    }
  }

  Stream<ArticleState> _mapFetchArticlesToState() async* {
    try {
      yield ArticlesLoading();
      final List<Blog> blogs = await ArticleRepository().fetchBlogs();
      yield ArticlesLoaded(blogs: blogs);
    } catch (e) {
      yield ArticlesError();
    }
  }
}
