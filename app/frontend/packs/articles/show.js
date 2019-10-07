import Vue from 'vue/dist/vue.esm.js'
import Axios from 'axios';

document.addEventListener('DOMContentLoaded', function () {
  new Vue({
    el: '#item-contents',
    data: {
      counter: 0
    },
    created: function () {
      console.log('created')
      console.log(this)
    },
    mounted: function () {
      console.log('mounted')
      console.log(this)
    },
    methods: {
      countUp: function () {
        this.counter++
      },
      ajaxRequest: function (id) {
        Axios.get('/ajaxTest', {
          params: {
            id: id
          }
        }).then(function (response) {
          console.log(response)
        }).catch(function (error) {
          console.log(error)
        })
      }
    }
  })
})
