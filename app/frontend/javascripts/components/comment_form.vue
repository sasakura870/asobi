<template>
  <form @submit.prevent>
    <div class="form-group">
      <textarea
        class="form-control"
        v-model="content"
        placeholder="コメントを入力してください"
        required="true"
        rows="4"
      ></textarea>
    </div>
    <input type="submit" @click="createComment" value="投稿する" class="btn btn-main" />
  </form>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  props: {
    articleId: Number
  },
  data: function() {
    return {
      content: ""
    };
  },
  methods: {
    createComment: async function() {
      try {
        const response = await Axios.post("/comments", {
          article_id: this.articleId,
          content: this.content
        });
        console.log("vueSuccess");
        if (response.status === 201) {
          this.content = "";
          //要素を追加する
          console.log("creaateComment");
        }
      } catch (error) {
        console.log("createFailure");
        console.log(error);
      }
    }
  }
};
</script>

<style>
</style>
