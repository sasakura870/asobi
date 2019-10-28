import FollowButton from "../../js/components/follow_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#user_profile",
    components: {
      "follow-button": FollowButton
    }
  });
});
