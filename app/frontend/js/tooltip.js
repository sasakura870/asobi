import tippy from "tippy.js";

document.addEventListener('DOMContentLoaded', function () {
  tippy(".js-tooltip", {
    placement: "bottom",
    trigger: "mouseenter focus",
    onTrigger: function (instance) {
      instance.setContent(instance.reference.getAttribute('data-tippy-content'));
    }
  });
});
