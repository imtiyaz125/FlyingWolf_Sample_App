import 'package:bluestack_assignment/Screens/Widget/TournamentCard.dart';
import 'package:bluestack_assignment/bloc/BlocManager.dart';
import 'package:bluestack_assignment/bloc/HomeBloc.dart';
import 'package:bluestack_assignment/data/Models/request/RecommendedRequest.dart';
import 'package:bluestack_assignment/data/Models/response/RecommendedResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'Widget/CommonErrorWidget.dart';
import 'Widget/CommonLoadingWidget.dart';

class RecommendedTournament extends StatefulWidget {
  RecommendedTournament();

  @override
  _RecommendedTournamentState createState() => _RecommendedTournamentState();
}

class _RecommendedTournamentState extends State<RecommendedTournament> {
  final PagingController<int, Tournaments> _pagingController =
      PagingController(firstPageKey: 0);
  String _currentCursor;
  int _pageKey=0;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      print("calling from paging");
      fetchRecommendedData();
    });
    super.initState();
  }

  fetchRecommendedData() {
    _bloc.dispatch(RecommendedEvent(
        request: RecommendedRequest(
            limit: 10, status: "all", cursor: _currentCursor)));
  }

  HomeBloc _bloc;
  Widget _latestWidget;

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = BlocProvider.of<HomeBloc>(context);
      print("calling from build");
    }
    return BlocManager(
      initState: (context) {
        fetchRecommendedData();
      },
      child: BlocListener(
        bloc: _bloc,
        listener: (BuildContext context, HomeState state) {
          if (state is RecommendedError) {
            print("${state.errorMessage}");
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, HomeState state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Builder(builder: (_context) {
                if (state is RecommendedError) {
                  if(_latestWidget==null)
                  return Center(
                    child: CommonErrorWidget(state.errorMessage),
                  );
                } else if (state is RecommendedSuccess) {
                  try {
                    _currentCursor = state.response.cursor;
                    final isLastPage = _currentCursor == null ||
                        _currentCursor
                            .isEmpty;
                    if (isLastPage) {
                      _pagingController
                          .appendLastPage(state.response.tournaments);
                      return _latestWidget;
                    } else {
                      final nextPageKey =
                          _pageKey + state.response.tournaments.length;
                      _pagingController.appendPage(
                          state.response.tournaments, nextPageKey);
                    }
                  } catch (error) {
                    _pagingController.error = error;
                  }
                  _latestWidget = PagedListView<int, Tournaments>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Tournaments>(
                        itemBuilder: (context, item, index) {
                      return TournamentCard(
                        coverUrl: item.coverUrl,
                        name: item.name,
                        gameName: item.gameName,
                      );
                    }),
                  );
                  return _latestWidget;
                }
                return _latestWidget == null
                    ? Center(child: CommonLoadingWidget())
                    : _latestWidget;
              }),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc=null;
    _pagingController.dispose();
    super.dispose();
  }
}
