<template>
  <button
    v-if="check"
    :disabled="isProcessing"
    @click="deleteFollow"
    type="button"
    class="c-hand-write-btn c-hand-write-btn--wide"
  >フォロー中</button>
  <button
    v-else
    :disabled="isProcessing"
    @click="createFollow"
    type="button"
    class="c-hand-write-btn c-hand-write-btn--supplement c-hand-write-btn--wide"
  >フォローする</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";
import Processing from "../mixins/processing";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  mixins: [Processing],
  props: {
    tagId: Number,
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
        const response = await Axios.post("/tag_maps", {
          tag_id: this.tagId
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
        const response = await Axios.delete("/tag_maps/0", {
          data: {
            tag_id: this.tagId
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
