require("selectize");
import tippy from "tippy.js";

document.addEventListener('DOMContentLoaded', function () {
  // ドロップダウンメニュー
  const dropdown = document.getElementsByClassName("js-dropdown");
  const dropdownMenu = document.getElementsByClassName("js-dropdown-target");
  for (let index = 0; index < dropdown.length; index++) {
    const target = dropdown[index].querySelector(".js-dropdown-target");
    dropdown[index].addEventListener('click', function () {
      if (target.className.includes("u-hide")) {
        target.classList.remove("u-hide");
      }
    });
  }
  // ドロップダウンメニュー外をクリックでメニューを閉じる
  document.body.addEventListener("click", function (event) {
    for (let index = 0; index < dropdown.length; index++) {
      if (dropdown[index].contains(event.srcElement)) {
        continue;
      }

      const element = dropdownMenu[index];
      if (!element.className.includes("u-hide")) {
        element.classList.add("u-hide");
      }
    }
  });

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
