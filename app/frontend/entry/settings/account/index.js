import RememberButton from "../../../js/components/remember_button";

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: "#remember-form",
    components: {
      "remember-button": RememberButton
    }
  })
});
