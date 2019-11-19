<template>
  <div v-if="check">
    <span class="p-sticky-menu__btn-counter u-text-main c-link">{{count}}</span>
    <div class="p-sticky-menu__btn js-tooltip" :data-tippy-content="tooltipMessage">
      <button
        @click="deleteFavorite"
        :disabled="isProcessing || !favoritable || myArticle"
        class="c-circle-btn"
        :class="{ 'u-disable' : !favoritable || myArticle }"
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
        :disabled="isProcessing || !favoritable || myArticle"
        class="c-circle-btn c-circle-btn--supplement"
        :class="{ 'u-disable' : !favoritable || myArticle }"
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
import Toast from "../mixins/toast";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

export default {
  mixins: [Processing, Toast],
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
      letmessage = this.check ? "いいね解除" : "いいね";
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
        if (response.status === 200) {
          this.check = !this.check;
          this.count++;
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("createFavoriteFailure");
        console.log(error);
        this.toast(error.response.data.type, error.response.data.message);
      } finally {
        this.endProcessing();
      }
    },
    deleteFavorite: async function() {
      // const toast = this.toast;
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
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("deleteFavoriteFailure");
        console.log(error);
        this.toast(error.response.data.type, error.response.data.message);
      } finally {
        this.endProcessing();
      }
    }
  }
};
</script>

<style></style>
