import FollowTagButton from "../../js/components/follow_tag_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#container",
    components: {
      "follow-tag-button": FollowTagButton
    }
  })
});
