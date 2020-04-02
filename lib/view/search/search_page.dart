import 'package:flutter/material.dart';

/// @description: 搜索页面
/// @author: liuzhidong
/// @date: 2020/4/2 15:31
/// @version: 1.0
const searchList = ['王二', '王老吉', '赵四', '王佳佳'];

const recentSuggest = [
  '王佳佳',
  '王二',
];


class DefaultSearchDelegate extends SearchDelegate<String> {


  //清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }

  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, 'text') //点击时关闭整个搜索页面
    );
  }

  //搜到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    print(query);
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) {
      print(input.indexOf(query));
      if (input.indexOf(query) > -1) {
        return true;
      } else {
        return false;
      }
    }).toList();
//    List<String> arr = 'wordwocoocwssw'.split('w');
//    for(int i=0; i<arr.length; i++){
//      if((i+1)%2 == 0){
//        print('1111');
//      }
//      String val = arr[i];
//      if(val != null && val.length > 0){
//        print("2222");
//      }
//    }

    return ListView.builder(
      itemCount: suggestionsList?.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: _title(word: suggestionsList[index],keyword: query),
        );
      },
    );
  }


  _title({String word, String keyword}) {
    if (word == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(word, keyword));
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
