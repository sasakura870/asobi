require("selectize");
import tippy from "tippy.js";

document.addEventListener('DOMContentLoaded', function () {
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

  // ツールチップ
  tippy(".js-tooltip", {
    placement: "bottom",
    trigger: "mouseenter focus",
    onTrigger: function (instance) {
      instance.setContent(instance.reference.getAttribute('data-tippy-content'));
    }
  });


  // selectize
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
});
