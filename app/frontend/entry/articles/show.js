import FavoriteButton from '../../js/components/favorite_button'
import CommentDeleteButton from '../../js/components/comment_delete_button'
// import CommentForm from '../../js/components/comment_form'

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: '#app',
    components: {
      'favorite-button': FavoriteButton,
      'comment-delete-button': CommentDeleteButton,
      // 'comment-form': CommentForm
    }
  });
});
