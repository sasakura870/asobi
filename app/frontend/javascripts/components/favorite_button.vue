<template>
  <div>
    <div v-if="check">
      <p class="text-center text-muted">{{count}}</p>
      <button class="btn btn-danger btn-round mb-4" @click="deleteFavorite">
        <i class="fas fa-star fa-fw"></i>
      </button>
    </div>
    <div v-else>
      <p class="text-center text-muted">{{count}}</p>
      <button class="btn btn-primary btn-round mb-4" @click="createFavorite">
        <i class="fas fa-star fa-fw"></i>
      </button>
    </div>
  </div>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

export default {
  props: {
    articleId: Number,
    isFavorited: Boolean,
    favoriteCount: Number
  },
  data: function() {
    return {
      check: this.isFavorited,
      count: this.favoriteCount
    };
  },
  methods: {
    createFavorite: async function() {
      try {
        const response = await Axios.post("/favorites", {
          article_id: this.articleId
        });
        console.log("vueSuccess");
        if (response.status === 201) {
          this.check = !this.check;
          this.count++;
          console.log("createFavorite");
        }
      } catch (error) {
        console.log("Failure");
        console.log(error);
      }
    },
    deleteFavorite: async function() {
      try {
        const response = await Axios.delete("/favorites/0", {
          data: {
            article_id: this.articleId
          }
        });
        console.log("vueSuccess - delete");
        if (response.status === 200) {
          this.check = !this.check;
          this.count--;
          console.log("deleteFavorite");
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
