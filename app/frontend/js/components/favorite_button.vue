<template>
  <div>
    <div v-if="check">
      <p class="text-center text-muted">{{count}}</p>
      <button
        @click="deleteFavorite"
        :disabled="isProcessing"
        class="btn btn-danger btn-round mb-4"
      >
        <i class="fas fa-star fa-fw"></i>
      </button>
    </div>
    <div v-else>
      <p class="text-center text-muted">{{count}}</p>
      <button
        @click="createFavorite"
        :disabled="isProcessing"
        class="btn btn-primary btn-round mb-4"
      >
        <i class="fas fa-star fa-fw"></i>
      </button>
    </div>
  </div>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import Processing from "../mixins/processing";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

export default {
  mixins: [Processing],
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
        this.startProcessing();
        const response = await Axios.post("/favorites", {
          article_id: this.articleId
        });
        if (response.status === 201) {
          this.check = !this.check;
          this.count++;
        }
      } catch (error) {
        console.log("createFavoriteFailure");
        console.log(error);
      } finally {
        this.endProcessing();
      }
    },
    deleteFavorite: async function() {
      try {
        this.startProcessing();
        const response = await Axios.delete("/favorites/0", {
          data: {
            article_id: this.articleId
          }
        });
        if (response.status === 200) {
          this.check = !this.check;
          this.count--;
        }
      } catch (error) {
        console.log("deleteFavoriteFailure");
        console.log(error);
      } finally {
        this.endProcessing();
      }
    }
  }
};
</script>

<style>
</style>
