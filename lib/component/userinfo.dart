import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swif/component/custombar.dart';

class UserInfo extends StatefulWidget {
  final Function(String) onCursusChange;
  final dynamic coalition;
  final dynamic data;
  final String selectedCursus;
  final Color color;
  const UserInfo({
    super.key,
    required this.color,
    required this.coalition,
    required this.data,
    required this.onCursusChange,
    required this.selectedCursus
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final List<String> cursusOptions = ['42cursus', 'C Piscine'];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait =  MediaQuery.of(context).orientation == Orientation.portrait;
    final levelData = widget.selectedCursus == '42cursus' ? 
      widget.data['cursus_users'][1]['level'] :
      widget.data['cursus_users'][0]['level'] ;
    final levelParts = levelData.toString().split('.');
    final level = int.tryParse(levelParts[0]) ?? 0;
    final percentage = (levelParts.length > 1) ? double.tryParse(levelParts[1]) ?? 0 : 0;
    final per = percentage / 100;
    return Column(
      children: [
        Container(
              height: 1,
              width: screenWidth,
              decoration: BoxDecoration(color: widget.color),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.selectedCursus == '42cursus' && widget.coalition.isNotEmpty ? Row(
              children: [
                widget.coalition.isNotEmpty ? Container(
                  height: isPortrait ?  screenHeight * 0.08 : screenHeight * 0.13,
                  width: isPortrait ? screenWidth * 0.12 : screenWidth * 0.08,
                  decoration: BoxDecoration(
                    color: widget.color,
                  ),
                  child: ClipOval(
                    child: SvgPicture.network( 
                      widget.coalition[0]['image_url'],
                      placeholderBuilder: (context) => CircularProgressIndicator(),
                    ),
                  ),
                ) : SizedBox.shrink(),
                SizedBox(width: 10,),
                Text(
                  widget.coalition[0]['name'],
                  style: TextStyle(
                    color: widget.color,
                    fontSize: isPortrait ? screenHeight * 0.025 : screenWidth * 0.035,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ) : SizedBox.shrink(),
            Text(
              widget.data['login'],
              style: TextStyle(
                color: Colors.white,
                fontSize: isPortrait ? screenHeight * 0.025 : screenWidth * 0.035,
                fontWeight: FontWeight.bold
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 38, 0.85),
                borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                
                child: DropdownButton(
                  value: widget.selectedCursus,
                  dropdownColor: Color.fromRGBO(32, 32, 38, 1),
                  items: cursusOptions.map(
                    (cursus){
                      return DropdownMenuItem(
                        value: cursus,
                        child: Text(
                          cursus,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      );
                    }
                  ).toList(), 
                  onChanged: (String? newvalue){
                    widget.onCursusChange(newvalue!);
                  }
                )
              ),
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.030,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.data['image']['versions']['large']),
              radius: 50,
            ),
            Flexible(
              child: Text(
                widget.data['usual_full_name'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: widget.color,
                  fontSize: isPortrait ? screenHeight * 0.025 : screenWidth * 0.035,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 38, 1),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: widget.data['location'] == null ?Colors.red : Colors.green,
                      shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    widget.data['location'] ?? "Unavailable",
                    style: TextStyle(
                      color: widget.data['location'] == null ?Colors.red : Colors.green,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.030,),
        Custombar(level: level , percentage: per, color: widget.color,),
        SizedBox(height: screenHeight * 0.030,),
        Container(
          height: 1,
          width: screenWidth,
          decoration: BoxDecoration(color: widget.color),
        ),
      ],
    );
  }
}