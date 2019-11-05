import DeleteDraftButton from "../../js/components/delete_draft_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: '#container',
    components: {
      "delete-draft-button": DeleteDraftButton
    }
  });
});
