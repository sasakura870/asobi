import Vue from 'vue/dist/vue.esm.js'

document.addEventListener('DOMContentLoaded', function () {
  new Vue({
    el: '#app',
    data: {
      message: 'Hello, About!',
      counter: 0,
      odd: false,
      class_name: 'text-danger',
      color: ''
    },
    methods: {
      countUp: function () {
        this.odd = !this.odd
        this.counter++
      },
      changeColor: function (event) {
        this.color = event.currentTarget.getAttribute('data-color')
      }
    }
  })
})
