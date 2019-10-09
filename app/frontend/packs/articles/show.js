import Vue from 'vue/dist/vue.esm.js'
import FavoriteButton from '../../javascripts/component/favorite_button'

document.addEventListener('DOMContentLoaded', function () {
  new Vue({
    el: '#item-contents',
    components: {
      'favorite-button': FavoriteButton
    }
  })
})
