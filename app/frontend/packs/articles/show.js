import Vue from 'vue/dist/vue.esm.js'
import Axios from 'axios';
import {
  csrfToken
} from '@rails/ujs'
import FavoriteButton from '../../javascripts/component/favorite_button'

Axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

document.addEventListener('DOMContentLoaded', function () {
  new Vue({
    el: '#item-contents',
    components: {
      'favorite-button': FavoriteButton
    }
  })
})
