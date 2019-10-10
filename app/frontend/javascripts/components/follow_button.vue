<template>
  <button v-if="check" @click="deleteFollow" type="button" class="btn btn-main btn-unfollow">フォロー中</button>
  <button v-else @click="createFollow" type="button" class="btn btn-outline-main">フォローする</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
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
      const response = await Axios.post("/relationships", {
        user_id: this.userId
      });
      console.log("vueSuccess");
      if (response.status === 201) {
        this.check = !this.check;
        console.log("createFollow");
      }
    },
    deleteFollow: async function() {
      const response = await Axios.delete("/relationships/0", {
        data: {
          user_id: this.userId
        }
      });
      console.log("vueSuccess");
      if (response.status === 200) {
        this.check = !this.check;
        console.log("deleteFollow");
      }
    }
  }
};
</script>

<style>
</style>
