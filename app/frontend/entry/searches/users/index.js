import FollowButton from "../../../js/components/follow_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#container",
    components: {
      "follow-button": FollowButton
    }
  });
});
