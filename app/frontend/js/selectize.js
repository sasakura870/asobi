require("selectize");

document.addEventListener('DOMContentLoaded', function () {
  if ($("#article_tag")[0]) {
    $("#article_tag").selectize({
      plugins: ['restore_on_backspace', 'remove_button'],
      delimiter: ",",
      persist: false,
      maxItems: 5,
      create: function (input) {
        return {
          value: input,
          text: input
        }
      }
    });
  }
});
