import Vue from 'vue/dist/vue.esm.js'

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
        console.log(this.$el)
      }
    }
  })
})
