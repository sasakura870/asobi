import RememberButton from "../../../js/components/remember_button";

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: "#container",
    components: {
      "remember-button": RememberButton
    }
  })
});
