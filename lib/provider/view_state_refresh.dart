import 'package:makingfriends/provider/view_state_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description：上拉刷新 下载加载 加载数据
/// @author：liuzhidong
/// @date：2020/3/27 20:08
/// @version：1.0

abstract class ViewStateRefresh<T> extends ViewStateProvider {
  ///页面列表数据
  List<T> list = [];

  ///第一页
  static const int pageFirst = 1;

  ///每页条数
  static final int pageTotal = 10;

  ///当前页码
  int _currentPage = pageFirst;

  ///分页控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  initData() async {
    setBusy();
    await refresh();
  }

  ///下拉刷新
  Future<List<T>> refresh() async {
    try {
      _currentPage = pageFirst;
      List<T> data = await loadData(pageFirst: pageFirst);
      if (data.isEmpty || data.length == 0) {
        refreshController.refreshCompleted(resetFooterState: true);
        setEmpty();
        list.clear();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < pageTotal) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        setDef();
      }
      return data;
    } catch (e, s) {
      list.clear();
      setError(e, s);
      refreshController.loadFailed();
      return null;
    }
  }

  ///下拉加载
  ///加载更多数据
  Future<List<T>> loadMore() async {
    try {
      List<T> data = await loadData(pageFirst: ++_currentPage);
      if (data.isEmpty || data.length == 0) {
        _currentPage--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageTotal) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      _currentPage--;
      refreshController.loadFailed();
      return null;
    }
  }

  Future<List<T>> loadData({int pageFirst});

  void onCompleted(List<T> data) {}

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

}
