import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res.dart';

class CustomDropdownButton extends StatefulWidget {
  final String placeholderText;
  final IconData icons;
  final int type;
  final String typeField;
  final bool isValidate;
  final List<dynamic> data;
  final bool readOnly;
  final Function(dynamic)? onSelectedCallback;
  final bool? isRefresh;

  const CustomDropdownButton({Key? key, required this.data, required this.placeholderText, this.icons = Icons.place_outlined, this.onSelectedCallback, required this.type, this.typeField = '', this.isValidate = false, this.readOnly = false, this.isRefresh}) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  int selectedIndex = -1;
  String placeholderText = '';

  @override
  void initState() {
    placeholderText = widget.placeholderText;

    // if(widget.data.isNotEmpty){
    //   int idx = widget.data.indexWhere((element) => element.isSelected == true);
    //   if(idx > -1){
    //     selectedIndex = idx;
    //     placeholderText = widget.data[idx].name;
    //   }
    // }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.placeholderText != widget.placeholderText){
      placeholderText = oldWidget.placeholderText;
    }
  }

  _showModalBottomSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 80),
                physics: const ClampingScrollPhysics(),
                itemCount: widget.data.isEmpty ? 0 : widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.data[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        placeholderText = item.name;
                        widget.onSelectedCallback?.call(item);
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: selectedIndex == index ? Theme.of(context).primaryColor :  Colors.grey.withOpacity(0.1))
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(item.name ?? '', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.black)),
                            selectedIndex == index ? SvgPicture.asset(Res.iconCheckCicle, color: Theme.of(context).primaryColor, width: 20) : const SizedBox(height: 0),
                          ]
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Text(widget.placeholderText, style:  Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.readOnly,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _showModalBottomSheet(context);
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: widget.isValidate ? Colors.red : Colors.grey.withOpacity(0.5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icons, color: Colors.black54, size: 20),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(text: widget.type == 2 ? '' : '* ', style: const TextStyle(color: Colors.red)),
                            TextSpan(text: placeholderText , style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 20),
                ],
              ),
            ),
            widget.readOnly ? Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }
}
