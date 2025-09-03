import 'package:flutter/material.dart';
import 'package:swif/component/custommarks.dart';
import 'package:swif/component/parentwidget.dart';

class Projects extends StatefulWidget {
  final dynamic data;
  final String selectedCursus;
  const Projects({super.key, required this.data, required this.selectedCursus});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    final selectedCursus = widget.selectedCursus;
    final List<dynamic> rawProjects = widget.data;
    final List<dynamic> filteredProjects = rawProjects.where((project) {
      final List cursusIds = project['cursus_ids'];
      final String name = project['project']['name'].toString().toLowerCase();
      final bool isExam = name.contains('exam');
      final bool isFinished = project['status'] == 'finished';
      final bool matchesCursus = selectedCursus == '42cursus'
        ? cursusIds.contains(21)
        : cursusIds.contains(6) || cursusIds.contains(9);
      return cursusIds.isNotEmpty && matchesCursus && (isFinished || isExam);
    },).toList();
    final Set<int> parentIds = {};
    for (var project in filteredProjects) {
      final parentId = project['project']['parent_id'];
      if (parentId != null) {
        parentIds.add(parentId);
      }
    }
    final Map<int, List<dynamic>> groupedByParent = {};
    for (int id in parentIds) {
      groupedByParent[id] = filteredProjects
          .where((proj) => proj['project']['parent_id'] == id)
          .toList();
    }
    final List<dynamic> parentProjects = filteredProjects.where((item) {
      final int projectId = item['project']['id'];
      return parentIds.contains(projectId);
    }).toList();
    List<dynamic> finalProject = filteredProjects.where((item) {
      int projectId = item['project']['id'];
      int? parentId = item['project']['parent_id'];
      return !(parentIds.contains(projectId) || parentIds.contains(parentId));
    }).toList();
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(32, 32, 38, 0.85),
      ),
      child: Column(
        children: [
          Parentwidget(
            parents: parentProjects,
            children: groupedByParent,
            selectedCursus : widget.selectedCursus
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: finalProject.length,
            itemBuilder: (context, index) {
              final mark = finalProject[index]['final_mark'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            finalProject[index]['project']['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16
                            ),
                          ),
                        ),
                        Custommarks(
                          mark: mark,
                          cursus: widget.selectedCursus,
                          project: finalProject[index]
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}