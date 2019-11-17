<template>
  <div v-if="check">
    <span class="p-sticky-menu__btn-counter u-text-main c-link">
      {{
      count
      }}
    </span>
    <div class="p-sticky-menu__btn js-tooltip" :data-tippy-content="tooltipMessage">
      <button
        @click="deleteFavorite"
        :disabled="isProcessing || !favoritable"
        class="c-circle-btn"
        :class="{ 'u-disable' : !favoritable }"
      >
        <i class="fas fa-star fa-fw"></i>
      </button>
    </div>
  </div>
  <div v-else>
    <span class="p-sticky-menu__btn-counter c-link">{{ count }}</span>
    <div class="p-sticky-menu__btn js-tooltip" :data-tippy-content="tooltipMessage">
      <button
        @click="createFavorite"
        :disabled="isProcessing || !favoritable"
        class="c-circle-btn c-circle-btn--supplement"
        :class="{ 'u-disable' : !favoritable }"
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
    favoritable: Boolean,
    myArticle: Boolean,
    favoriteCount: Number
  },
  data: function() {
    return {
      check: this.isFavorited,
      count: this.favoriteCount
    };
  },
  computed: {
    tooltipMessage: function() {
      var message = this.check ? "いいね解除" : "いいね";
      message = this.favoritable ? message : "新規登録していいねしましょう！";
      message = this.myArticle ? "自分の遊びにはいいねできません" : message;
      return message;
    }
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

<style></style>
