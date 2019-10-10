<template>
  <div>
    <div class="form-group">
      <textarea
        class="form-control"
        v-model="contents"
        placeholder="コメントを入力してください"
        required
        rows="4"
      ></textarea>
      <p>{{contents}}</p>
    </div>
    <button @click="createComment" class="btn btn-main">投稿する</button>
  </div>
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
      contents: ""
    };
  },
  methods: {
    createComment: async function() {}
  }
};
</script>

<style>
</style>
