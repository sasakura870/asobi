<template>
  <button
    v-if="check"
    :disabled="isProcessing"
    @click="forget"
    type="button"
    class="c-hand-write-btn c-hand-write-btn--danger"
  >解除する</button>
  <button
    v-else
    :disabled="isProcessing"
    @click="remember"
    type="button"
    class="c-hand-write-btn"
  >設定する</button>
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
    isRemembered: Boolean
  },
  data: function() {
    return {
      check: this.isRemembered
    };
  },
  methods: {
    remember: async function() {
      const toast = this.toast;
      try {
        this.startProcessing();
        const response = await Axios.post("/settings/remember");
        if (response.status === 200) {
          this.check = !this.check;
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("rememberFailure");
        console.log(error);
        this.toast(error.response.data.type, error.response.data.message);
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
          this.toast(response.data.type, response.data.message);
        }
      } catch (error) {
        console.log("forgetFailure");
        console.log(error);
      } finally {
        this.endProcessing();
        this.toast(error.response.data.type, error.response.data.message);
      }
    }
  }
};
</script>

<style>
</style>
