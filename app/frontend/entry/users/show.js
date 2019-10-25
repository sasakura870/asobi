import '../default'
// import Vue from "vue/dist/vue.esm.js";
import FollowButton from "../../js/components/follow_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#user_profile",
    components: {
      "follow-button": FollowButton
    }
  });
});
