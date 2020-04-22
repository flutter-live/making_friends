import 'package:makingfriends/model/adsense.dart';
import 'package:makingfriends/model/hot_topic.dart';
import 'package:makingfriends/provider/view_state_list.dart';
import 'package:makingfriends/service/makng_friends_api.dart';

/// @description： 话题
/// @author：liuzhidong
/// @date：2020/3/30 21:41
/// @version：1.0

class TocpicVM extends ViewStateList {
  List<Adsense> _listAdsense;
  List<HotTopic> _listHotTopic;

  List<Adsense> get listAdsense => _listAdsense;

  List<HotTopic> get listHotTopic => _listHotTopic;

  @override
  Future<List> loadData({int pageFirst}) async{
    List<Future> futures = [];
    futures.add(MakingFriendsApi.fetchAdsense());
    futures.add(MakingFriendsApi.fetchHotTopic());
    var respose = await Future.wait(futures);
    _listAdsense = respose[0];
    _listHotTopic = respose[1];
    return futures;
  }

}