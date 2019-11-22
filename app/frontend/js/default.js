require("selectize");
import tippy from "tippy.js";
import CircleFavoriteButton from "./components/circle_favorite_button";
import DeleteCommentButton from "./components/delete_comment_button";
import DeleteDraftButton from "./components/delete_draft_button";
import FollowButton from "./components/follow_button";
import FollowTagButton from "./components/follow_tag_button";
import RememberButton from "./components/remember_button";

const toast = function (type, message) {
  Swal.fire({
    type: type,
    title: message,
    toast: true,
    position: 'bottom-start',
    grow: 'column',
    showConfirmButton: false,
    showCloseButton: true
  });
}

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: "#container",
    components: {
      CircleFavoriteButton,
      DeleteCommentButton,
      DeleteDraftButton,
      FollowButton,
      FollowTagButton,
      RememberButton
    }
  });

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
    toast(type.value, message.value);
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

  //ujsのメッセージを表示
  document.body.addEventListener("ajax:complete", function (event) {
    var data = JSON.parse(event.detail[0].response);
    toast(data.type, data.message);
  });
});
