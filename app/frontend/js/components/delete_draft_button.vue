<template>
  <button @click="deleteDraft" type="button" class="c-outline-btn c-outline-btn--danger">
    <i class="fas fa-trash-alt"></i>
  </button>
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
    articleId: Number
  },
  methods: {
    deleteDraft: function() {
      const element = this.$el.parentNode.parentNode;
      const toast = this.toast;
      Swal.fire({
        type: "warning",
        title: "下書きを削除してもよろしいですか？",
        text: "この操作は取り消せません",
        showCancelButton: true,
        confirmButtonText: "削除する",
        cancelButtonText: "キャンセル"
      }).then(result => {
        if (result.value) {
          Axios.delete(`/drafts/${this.articleId}`)
            .then(response => {
              if (response.status === 200) {
                element.remove();
                toast(response.data.type, response.data.message);
              }
            })
            .catch(error => {
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
