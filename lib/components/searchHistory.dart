import 'package:api/colours.dart';
import 'package:api/components/functions/shared_preferences.dart';
import 'package:flutter/material.dart';

class SearchHistory extends StatefulWidget {
  final List<String> history;
  final Function search;
  const SearchHistory({super.key, required this.history, required this.search});

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.history.length,
      itemBuilder: (BuildContext c, int i) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            widget.search(widget.history[i], true);
          },
          child: Card(
            color: const Color.fromARGB(255, 52, 57, 61),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      widget.history[i],
                      style: textPrimary18,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: IconButton(
                        onPressed: (() {
                          removeFromSearchHistory(widget.history[i], refresh);
                        }),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
