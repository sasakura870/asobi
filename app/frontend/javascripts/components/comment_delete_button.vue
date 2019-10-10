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
    deleteComment: async function() {
      try {
        const confirmation = confirm("コメントを削除しますか？");
        if (confirmation) {
          const response = await Axios.delete(`/comments/${this.commentId}`);
          console.log("vueSuccess");
          if (response.status === 200) {
            this.$el.parentNode.remove();
            console.log("deleteComment");
          }
        }
      } catch (error) {
        console.log("deleteFailure");
        console.log(error);
      }
    }
  }
};
</script>

<style>
</style>
