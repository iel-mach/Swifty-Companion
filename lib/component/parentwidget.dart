import 'package:flutter/material.dart';
import 'package:swif/component/custommarks.dart';

class Parentwidget extends StatefulWidget {
  final List<dynamic> parents;
  final  Map<int, List<dynamic>> children;
  final String selectedCursus;
  const Parentwidget({super.key, required this.parents, required this.children, required this.selectedCursus});

  @override
  State<Parentwidget> createState() => _ParentwidgetState();
}

class _ParentwidgetState extends State<Parentwidget> {
  int? expandedIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.parents.length,
      itemBuilder: (context, index) {
        final child = widget.children[widget.parents[index]['project']['id']];
        bool isExpanded = expandedIndex == index;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                     expandedIndex = (expandedIndex == index) ? null : index;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            widget.parents[index]['project']['name'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(!isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Custommarks(
                        mark: widget.parents[index]['final_mark'],
                        cursus: widget.selectedCursus,
                        project: widget.parents[index]
                      )
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(32, 32, 38, 0.85),
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ) 
                  )
                ),
                child:  child == null ? SizedBox.shrink()  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: child.length,
                itemBuilder: (context, index){
                  return  isExpanded ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Text(
                              child[index]['project']['name'],
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Custommarks(
                          mark: child[index]['final_mark'],
                          cursus: widget.selectedCursus,
                          project: child[index]
                        ),
                      )
                    ],
                  ) : SizedBox.shrink();
                } 
              ) ,
              ),
            ],
          ),
        );
      }
    );
  }
}
