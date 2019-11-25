document.addEventListener('DOMContentLoaded', function () {
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
});
