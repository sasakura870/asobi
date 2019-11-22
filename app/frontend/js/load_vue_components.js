import CircleFavoriteButton from "./components/circle_favorite_button";
import DeleteCommentButton from "./components/delete_comment_button";
import DeleteDraftButton from "./components/delete_draft_button";
import FollowButton from "./components/follow_button";
import FollowTagButton from "./components/follow_tag_button";
import RememberButton from "./components/remember_button";

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: "#container",
    components: {
      CircleFavoriteButton,
      DeleteCommentButton,
      DeleteDraftButton,
      FollowButton,
      FollowTagButton,
      RememberButton
    }
  })
});
