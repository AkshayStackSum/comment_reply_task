class CommentModel {
  late String _userName;
  late String _userImage;
  late String _userCommentTime;
  late String _userComment;
  late List<CommentModel> _userCommentArray;

  CommentModel(this._userName, this._userImage, this._userCommentTime,
      this._userComment, this._userCommentArray);

  List<CommentModel> get userCommentArray => _userCommentArray;

  String get userComment => _userComment;

  String get userCommentTime => _userCommentTime;

  String get userImage => _userImage;

  String get userName => _userName;
}
