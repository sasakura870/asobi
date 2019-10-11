import '../default'
import Vue from 'vue/dist/vue.esm.js'
import Swal from 'sweetalert2'

Vue.component('test-button', {
  data: () => ({
    count: 0
  }),
  props: ['text'],
  template: '<button type="button" class="btn btn-success" @click="countDown">{{text}} {{count}}</button>',
  methods: {
    countDown: function () {
      this.count--
    }
  }
})

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
        this.color = event.currentTarget.getAttribute('data-color');
        Swal.fire({
          type: 'success',
          title: this.color,
          text: this.message,
          showCancelButton: true,
          confirmButtonText: '削除する',
          cancelButtonText: 'キャンセル'
        }).then((result) => {
          if (result.value) {
            console.log(this.color);
          } else if (result.dismiss) {
            console.log(result.dismiss)
          }
        })
      }
    }
  })
})
