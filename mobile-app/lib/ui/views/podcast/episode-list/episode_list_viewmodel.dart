import 'dart:convert';
import 'dart:developer';

import 'package:freecodecamp/app/app.locator.dart';
import 'package:freecodecamp/models/podcasts/episodes_model.dart';
import 'package:freecodecamp/models/podcasts/podcasts_model.dart';
import 'package:freecodecamp/service/podcasts_service.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';

const baseUrl = "http://10.0.2.2:3000/";

class EpisodeListViewModel extends BaseViewModel {
  final _databaseService = locator<PodcastsDatabaseService>();
  final Podcasts podcast;
  int epsLength = 0;
  late Future<List<Episodes>> _episodes;
  Future<List<Episodes>> get episodes => _episodes;
  
  final PagingController<int, Episodes> _pagingController = PagingController(
    firstPageKey: 0,
  );
  PagingController<int, Episodes> get pagingController => _pagingController;

  EpisodeListViewModel(this.podcast);

  void initState(bool isDownloadView) async {
    _databaseService.initialise();
    if (isDownloadView) {
      _episodes = _databaseService.getEpisodes(podcast);
      epsLength = (await episodes).length;
    } else {
      _pagingController.addPageRequestListener((pageKey) {
        fetchEpisodes(podcast.id, pageKey);
      });
      // _episodes = fetchEpisodes(podcast.id);
    }
    notifyListeners();
    // Parse html description
    // log("PARSED ${parse(podcast.description!).documentElement?.text}");
  }

  void fetchEpisodes(String podcastId, [int pageKey = 0]) async {
    try {
      final res = await http.get(
        Uri.parse(baseUrl +
            "podcasts/" +
            podcastId +
            "/episodes?page=" +
            pageKey.toString()),
      );
      final List<dynamic> episodes = json.decode(res.body)["episodes"];
      epsLength = json.decode(res.body)["podcast"]["numOfEps"];
      notifyListeners();
      final List<Episodes> eps =
          episodes.map((e) => Episodes.fromAPIJson(e)).toList();
      final prevCount = _pagingController.itemList?.length ?? 0;
      if (prevCount + 20 >= epsLength) {
        _pagingController.appendLastPage(eps);
      } else {
        _pagingController.appendPage(eps, pageKey + 1);
      }
      // return episodes.map((episode) => Episodes.fromAPIJson(episode)).toList();
    } catch (e) {
      log(e.toString());
      _pagingController.error = e;
    }
    // return episodes.map((episode) => Episodes.fromAPIJson(episode)).toList();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
