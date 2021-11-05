import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

bottomBar(context,int currentIndex, int iconSize) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.4, color: Colors.grey[300], style: BorderStyle.solid),
        )
    ),
    height: ScreenUtil().setHeight(64),
    child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: 5
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItems(
              Icons.home_outlined,Icons.home_sharp,'Home', 0,iconSize),
          _bottomItems(
              Icons.new_releases_outlined,Icons.new_releases,'Latest', 1,iconSize),
          _bottomItems(
              Icons.favorite_border_outlined,Icons.favorite_rounded,'Favorite', 2,iconSize),
          _bottomItems(
              Icons.watch_later_outlined,Icons.watch_later,'Recent', 3,iconSize),
          _bottomItems(
              Icons.folder_outlined,Icons.folder_rounded,'Library', 4,iconSize),
        ],
      ),
    ),
  );
}

_bottomItems(IconData icon_outlined, IconData icon_filled, String title, int index,int iconSize) {
  return Container(
    child: InkWell(
        onTap: () {
          HomepageCurrentIndex.value = index;
          appBarTitleFunc(index);
        },
        child: ValueListenableBuilder(
          valueListenable: HomepageCurrentIndex,
          builder: (context, value, widget){
            return Column(
              children: [
                value == index?Icon(icon_filled,
                  color: Colors.redAccent,
                  size: ScreenUtil().setWidth(35),
                ):Icon(icon_outlined,
                  color: Colors.black,
                  size: ScreenUtil().setWidth(iconSize),
                ),
                title != '' ? new Text(title,style: GoogleFonts.roboto(textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: value == index?Colors.redAccent:Colors.black,
                )),)
                    : SizedBox(height: 0,),
              ],
            );
          },

        )
    ),
  );
}

appBarTitleFunc(int pageIndex){
  if(pageIndex == 0){
    appBArTitle.value = 'Home';
  }else if(pageIndex == 1){
    appBArTitle.value = 'Hotest';
  }else if(pageIndex == 2){
    appBArTitle.value = 'Favorite';
  }else if(pageIndex == 3){
    appBArTitle.value = 'Recent';
  }else if(pageIndex == 4){
    appBArTitle.value = 'Library';
  }else if(pageIndex == 5){
    appBArTitle.value = 'Category';
  }else{
    appBArTitle.value = 'Error';
  }
  return appBArTitle.value;
}