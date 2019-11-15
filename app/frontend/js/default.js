require("selectize");
import tippy from "tippy.js";

document.addEventListener('DOMContentLoaded', function (event) {
  // flash表示用toast
  const type = document.getElementById("toast_type");
  const message = document.getElementById("toast_message");
  if (type && message) {
    Swal.fire({
      type: type.value,
      title: message.value,
      toast: true,
      position: 'bottom-start',
      showConfirmButton: false,
      showCloseButton: true
    });
  }

  // // ツールチップ
  // const t = tippy("button", {
  //   content: 'test'
  // });
  // console.log(t);
  // console.log(t._tippy);


  // selectize
  $("#article_tag").selectize({
    plugins: ['restore_on_backspace', 'remove_button'],
    delimiter: ",",
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
