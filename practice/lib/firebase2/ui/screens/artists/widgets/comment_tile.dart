// lib/ui/screens/artist_detail/widgets/comment_tile.dart
import 'package:flutter/material.dart';
import 'package:practice/firebase2/model/artist/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.text, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 4),
          Text(
            "Just now", 
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
