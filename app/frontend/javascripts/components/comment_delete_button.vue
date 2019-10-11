<template>
  <button @click="deleteComment" class="btn btn-outline-danger">削除</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  props: {
    commentId: Number
  },
  data: function() {
    return {};
  },
  methods: {
    deleteComment: function() {
      const element = this.$el.parentNode;
      const confirmation = Swal.fire({
        type: "warning",
        title: "コメントを削除してもよろしいですか？",
        text: "この操作は取り消しできません",
        showCancelButton: true,
        confirmButtonText: "削除する",
        cancelButtonText: "キャンセル"
      }).then(result => {
        if (result.value) {
          Axios.delete(`/comments/${this.commentId}`)
            .then(function(response) {
              console.log("vueSuccess");
              if (response.status === 200) {
                element.remove();
                console.log("deleteComment");
              }
            })
            .catch(function(error) {
              console.log("deleteFailure");
              console.log(error);
            });
        }
      });
    }
  }
};
</script>

<style>
</style>
