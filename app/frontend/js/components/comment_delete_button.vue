<template>
  <button :disabled="isToastRunning" @click="deleteComment" class="btn btn-outline-danger">削除</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";
import Toast from "../mixins/toast";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  mixins: [Toast],
  props: {
    commentId: Number
  },
  data: function() {
    return {};
  },
  computed: {
    isToastRunning: function() {
      return Swal.isTimerRunning();
    }
  },
  methods: {
    deleteComment: function() {
      const element = this.$el.parentNode;
      const toast = this.toast;
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
              console.log(response.data);
              if (response.status === 200) {
                element.remove();
                toast(response.data.type, response.data.message);
              }
            })
            .catch(function(error) {
              console.log("deleteCommentFailure");
              console.log(error);
              toast(
                "error",
                "コメントの削除に失敗しました。時間を置いて再度やり直してください"
              );
            });
        }
      });
    }
  }
};
</script>

<style>
</style>
