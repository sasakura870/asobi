import '../default'
// import Vue from "vue/dist/vue.esm.js";
import FollowButton from "../../javascripts/components/follow_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#user_profile",
    components: {
      "follow-button": FollowButton
    }
  });
});
