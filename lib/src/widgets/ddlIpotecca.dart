// import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/constants/colors.dart';
import 'package:openseasapp/src/constants/constants.dart';

import '../setup/setup.dart';

class DDLIp extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextInputType? textInputType;
  final List<dynamic>? itemsList;
  final DDLIpItems? items;
  final Function? itemSelect;
  final Mode menuMode;
  final bool showSearchBox;
  final bool showIcon;

  String? id;

  DDLIp(
      {Key? key,
      required this.label,
      this.hintText = "",
      this.textInputType = TextInputType.text,
      required this.itemsList,
      required this.itemSelect,
      this.menuMode = kIsWeb ? Mode.DIALOG : Mode.BOTTOM_SHEET,
      this.items,
      this.showSearchBox = false,
      this.showIcon = false,
      this.id})
      : super(key: key);

  @override
  State<DDLIp> createState() => _DDLIpState();
}

class _DDLIpState extends State<DDLIp> {
  TextEditingController? controller;
  dynamic ddlIpItems;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //ddlIpItems = DDLIpItems(id: "", descripcion: "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: widthheight(ctn: context, fSize: 70, tipo: 2),
      width: widthheight(ctn: context, fSize: 328),
      alignment: Alignment.centerLeft,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(
      //       widthheight(ctn: context, fSize: 8),
      //     ),
      //     border: Border.all(color: colorE5E5E5)),
      child: Stack(
        // clipBehavior: Clip,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned(
            top: widthheight(ctn: context, fSize: 1, tipo: 2),
            left: widthheight(ctn: context, fSize: 20, tipo: 2),
            child: Text(
              widget.label,
              style: textos(ctn: context, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: widthheight(ctn: context, fSize: 20), left: widthheight(ctn: context, fSize: 16), right: widthheight(ctn: context, fSize: 16)),
            child: Container(
              height: widthheight(ctn: context, fSize: 70),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 1.7, color: color050855), borderRadius: BorderRadius.circular(4)),
              child: DropdownSearch<dynamic>(
                mode: widget.menuMode,

                // showSelectedItem: false,
                items: widget.itemsList,
                selectedItem: widget.items,
                itemAsString: (item) => item.descripcion.toString(),
                showSearchBox: widget.showSearchBox,

                dropdownSearchDecoration: InputDecoration(
                  //  labelText: "Custom BottomShet mode",

                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 4, color: colorE5E5E5)),
                ),
                popupShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                dropdownBuilder: _customDropDownExample,
                popupItemBuilder: _customPopupItemBuilderExample,
                popupTitle: widget.showSearchBox
                    ? SizedBox(
                        height: widthheight(ctn: context, fSize: 30),
                        child: Center(
                          child: Text(
                            "Buscador",
                            style: textos(ctn: context, fSize: 16),
                          ),
                        ),
                      )
                    : SizedBox(),
                emptyBuilder: (context, _) => SizedBox(
                  // height: widthheight(ctn: context, fSize: 30),
                  child: Center(
                    child: Text(
                      "Datos no encontrados",
                      style: textos(ctn: context, fSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                onChanged: (a) => widget.itemSelect,
                //  (cm) {
                //   ddlIpItems = cm!;
                //   // widget.itemSelect!(ddlIpItems);
                // },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customPopupItemBuilderExample(BuildContext context, dynamic item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: color050855),
              borderRadius: BorderRadius.circular(5),
              //  color: Colors.white,
            ),
      child: ListTile(
          selected: isSelected,
          title: Text(
            item.descripcion,
            style: textos(ctn: context),
          ),
          // subtitle: Text(item.createdAt.toString()),
          leading: widget.showIcon
              ? CircleAvatar(
                  // this does not work - throws 404 error
                  backgroundColor: Colors.white,
                  backgroundImage: item.optional1 == "" ? null : NetworkImage(item.optional1 ?? ''),
                  child: item.optional1 == ""
                      ? Image.asset(
                          AppImages.openseasIco,
                          width: 20,
                        )
                      : null,
                )
              : null),
    );
  }

  Widget _customDropDownExample(BuildContext context, dynamic item) {
    if (item == null) {
      return Container();
    }

    return Container(
        color: Colors.white,
        child: Text(
          item.descripcion,
          style: textos(ctn: context),
        )

        //  (item.avatar == null)
        //     ? ListTile(
        //         contentPadding: EdgeInsets.all(0),
        //         leading: CircleAvatar(),
        //         title: Text("No item selected"),
        //       )
        //     : ListTile(
        //         contentPadding: EdgeInsets.all(0),
        //         leading: CircleAvatar(
        //             // this does not work - throws 404 error
        //             // backgroundImage: NetworkImage(item.avatar ?? ''),
        //             ),
        //         title: Text(item.des),
        //         subtitle: Text(
        //           item.createdAt.toString(),
        //         ),
        //       ),
        );
  }
}

class DDLIpItems {
  String id = "";
  String descripcion = "";
  String? optional1 = "";
  String? optional2 = "";
  String? optional3 = "";
  bool? select = false;
  dynamic? addicional;

  DDLIpItems({required this.id, required this.descripcion, this.optional1, this.optional2, this.optional3, this.select, this.addicional});
}
