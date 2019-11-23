import CapsuleToyArticle from "./components/capsule_toy_article";
import CircleFavoriteButton from "./components/circle_favorite_button";
import DeleteCommentButton from "./components/delete_comment_button";
import DeleteDraftButton from "./components/delete_draft_button";
import FollowButton from "./components/follow_button";
import FollowTagButton from "./components/follow_tag_button";
import RememberButton from "./components/remember_button";

vue.config.ignoredElements = [
  'trix-toolbar',
  'trix-editor',
  'action-text-attachment'
]

document.addEventListener('DOMContentLoaded', function () {
  if (document.getElementById("container") != null) {
    new vue({
      el: "#container",
      components: {
        // CapsuleToyArticle,
        CircleFavoriteButton,
        DeleteCommentButton,
        DeleteDraftButton,
        FollowButton,
        FollowTagButton,
        RememberButton
      }
    });
  }
});
