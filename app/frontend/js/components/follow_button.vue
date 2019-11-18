<template>
  <div class="js-tooltip" :data-tippy-content="tooltipMessage">
    <button
      v-if="check"
      :disabled="isProcessing || !followable"
      @click="deleteFollow"
      type="button"
      class="c-hand-write-btn c-hand-write-btn--wide"
      :class="{ 'u-disable' : !followable }"
    >フォロー中</button>
    <button
      v-else
      :disabled="isProcessing || !followable"
      @click="createFollow"
      type="button"
      class="c-hand-write-btn c-hand-write-btn--supplement c-hand-write-btn--wide"
      :class="{ 'u-disable' : !followable }"
    >フォローする</button>
  </div>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";
import Processing from "../mixins/processing";
import Toast from "../mixins/toast";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  mixins: [Processing, Toast],
  props: {
    userId: Number,
    isFollowed: Boolean,
    followable: Boolean
  },
  data: function() {
    return {
      check: this.isFollowed
    };
  },
  computed: {
    tooltipMessage: function() {
      var message = this.check ? "フォロー解除" : "フォロー";
      message = this.followable ? message : "新規登録してフォローしましょう!";
      return message;
    }
  },
  methods: {
    createFollow: async function() {
      try {
        this.startProcessing();
        const response = await Axios.post("/relationships", {
          user_id: this.userId
        });
        if (response.status === 200) {
          this.check = !this.check;
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("createFollowFailure");
        console.log(error);
        this.toast(error.response.data.type, error.response.data.message);
      } finally {
        this.endProcessing();
      }
    },
    deleteFollow: async function() {
      try {
        this.startProcessing();
        const response = await Axios.delete("/relationships/0", {
          data: {
            user_id: this.userId
          }
        });
        if (response.status === 200) {
          this.check = !this.check;
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("deleteFollowFailure");
        console.log(error);
        this.toast(error.response.data.type, error.response.data.message);
      } finally {
        this.endProcessing();
      }
    }
  }
};
</script>

<style>
</style>
