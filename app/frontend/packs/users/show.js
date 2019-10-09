import Vue from "vue/dist/vue.esm.js";
import FollowButton from "../../javascripts/component/follow_button";

document.addEventListener("DOMContentLoaded", function () {
  new Vue({
    el: "#user_profile",
    components: {
      "follow-button": FollowButton
    }
  });
});
