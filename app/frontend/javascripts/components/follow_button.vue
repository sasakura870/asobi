<template>
  <button
    v-if="check"
    :disabled="isPocessing"
    @click="deleteFollow"
    type="button"
    class="btn btn-main btn-unfollow"
  >フォロー中</button>
  <button
    v-else
    :disabled="isPocessing"
    @click="createFollow"
    type="button"
    class="btn btn-outline-main"
  >フォローする</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";
import Processing from "../mixin/processing";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  mixins: [Processing],
  props: {
    userId: Number,
    isFollowed: Boolean
  },
  data: function() {
    return {
      check: this.isFollowed
    };
  },
  methods: {
    createFollow: async function() {
      try {
        this.startProcessing();
        const response = await Axios.post("/relationships", {
          user_id: this.userId
        });
        if (response.status === 201) {
          this.check = !this.check;
        }
      } catch (error) {
        console.log("createFollowFailure");
        console.log(error);
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
        }
      } catch (error) {
        console.log("deleteFollowFailure");
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
