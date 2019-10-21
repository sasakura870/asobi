import DeleteDraftButton from "../../javascripts/components/delete_draft_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: '#draft-table',
    components: {
      "delete-draft-button": DeleteDraftButton
    }
  });
});
