<template>
  <button v-if="check" @click="forget" type="button" class="btn btn-danger">解除する</button>
  <button v-else @click="remember" type="button" class="btn btn-main">設定する</button>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  props: {
    isRemembered: Boolean
  },
  data: function() {
    return {
      check: this.isRemembered
    };
  },
  methods: {
    remember: async function() {
      const response = await Axios.post("/settings/remember");
      console.log("Vuesuccess");
      if (response.status === 200) {
        this.check = !this.check;
        console.log("remember");
      }
    },
    forget: async function() {
      const response = await Axios.delete("/settings/remember/0");
      console.log("Vuesuccess");
      if (response.status === 200) {
        this.check = !this.check;
        console.log("forget");
      }
    }
  }
};
</script>

<style>
</style>
