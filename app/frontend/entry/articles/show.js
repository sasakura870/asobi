import CircleFavoriteButton from '../../js/components/circle_favorite_button';
import FollowButton from '../../js/components/follow_button';
import DeleteCommentButton from '../../js/components/delete_comment_button';
// import CommentForm from '../../js/components/comment_form'

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: '#container',
    components: {
      'circle-favorite-button': CircleFavoriteButton,
      'delete-comment-button': DeleteCommentButton,
      'follow-button': FollowButton
      // 'comment-form': CommentForm
    }
  });
});
