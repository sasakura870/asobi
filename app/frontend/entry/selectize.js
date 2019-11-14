require("selectize");

document.addEventListener('DOMContentLoaded', function () {
  $("#article_tag").selectize({
    plugins: ['restore_on_backspace', 'remove_button'],
    delimiter: " ",
    persist: false,
    maxItems: 10,
    create: function (input) {
      return {
        value: input,
        text: input
      }
    }
  });
});
