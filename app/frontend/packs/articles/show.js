import Vue from 'vue/dist/vue.esm.js'
import FavoriteButton from '../../javascripts/components/favorite_button'
import CommentDeleteButton from '../../javascripts/components/comment_delete_button'
// import CommentForm from '../../javascripts/components/comment_form'

document.addEventListener('DOMContentLoaded', function () {
  new Vue({
    el: '#app',
    components: {
      'favorite-button': FavoriteButton,
      'comment-delete-button': CommentDeleteButton,
      // 'comment-form': CommentForm
    }
  })
})
