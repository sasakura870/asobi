<template>
  <button
    v-if="check"
    :disabled="isProcessing"
    @click="forget"
    type="button"
    class="btn btn-danger"
  >解除する</button>
  <button v-else :disabled="isProcessing" @click="remember" type="button" class="btn btn-main">設定する</button>
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
    isRemembered: Boolean
  },
  data: function() {
    return {
      check: this.isRemembered
    };
  },
  methods: {
    remember: async function() {
      try {
        this.startProcessing();
        const response = await Axios.post("/settings/remember");
        if (response.status === 200) {
          this.check = !this.check;
        }
      } catch (error) {
        console.log("rememberFailure");
        console.log(error);
      } finally {
        this.endProcessing();
      }
    },
    forget: async function() {
      try {
        this.startProcessing();
        const response = await Axios.delete("/settings/remember/0");
        if (response.status === 200) {
          this.check = !this.check;
        }
      } catch (error) {
        console.log("forgetFailure");
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
