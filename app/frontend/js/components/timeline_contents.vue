<template>
  <div class="p-list-contents">
    <div class="p-list-contents__header">
      <h1>
        <i class="far fa-clock"></i>タイムライン
      </h1>
    </div>
    <ul class="p-list-contents__list">
      <li v-for="item in timelineItems" v-bind:key="item.id">{{ item }} - {{item.id}}</li>
    </ul>
    <div class="p-list-contents__footer">
      <button class="c-outline-btn c-outline-btn--primary">続きをみる</button>
    </div>
  </div>
</template>

<script>
import Axios from "axios";
import { csrfToken } from "@rails/ujs";
import { async } from "q";
import Processing from "../mixins/processing";

Axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();
export default {
  props: {
    timelineItems: Array
  }
};
</script>

<style>
</style>
