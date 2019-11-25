const capsuleToyFunc = async function () {
  try {
    const request = await fetch("/capsule_toys");
    const data = await request.json();
    const articleData = data.article;
    const userData = data.user;
    const tags = data.tags;
    let articleHtml = `<div class="p-article-card u-float">
          <a href="/articles/${articleData.id_digest}" class="p-article-card__body c-link">
          <p class="p-article-card__overview">${articleData.overview}</p>
          <p class="p-article-card__title">${articleData.title}</p>
          <img src="${articleData.thumbnail}" class="p-article-card__thumbnail c-thumbnail">
          <ul class="p-article-card__tag-list">`;
    for (let index = 0; index < tags.length; index++) {
      articleHtml += `<li class="p-article-card__tag-item"><span class="c-badge c-badge--tag">${tags[index].name}</span></li>`;
    }
    articleHtml += `</ul>
          <div class="p-article-card__reaction">
          <div class="p-article-card__favorite"><span class="c-badge c-badge--favorite">${articleData.favorites_count}</span></div>
          <div class="p-article-card__comment"><span class="c-badge c-badge--comment">${articleData.comments_count}</span></div>
          </div>
          </a>
          <a href="/users/${userData.name}" class="p-article-card__footer c-link">
          <div class="p-article-card__icon">
          <img src="${userData.photo}" width="40" height="40" class="c-user-photo">
          </div>
          <div class="p-article-card__user-name">${userData.nick_name === "" ? `@${userData.name}` : userData.nick_name}</div>
          </a>
          </div>`

    Swal.fire({
      text: articleData.title,
      html: articleHtml,
      showCancelButton: true,
      focusConfirm: true,
      confirmButtonText: '<i class="fas fa-surprise fa-fw"></i>もう一度引く',
      cancelButtonText: '閉じる',
    }).then(result => {
      if (result.value) {
        capsuleToyFunc();
      }
    });
  } catch (error) {
    Swal.fire({
      type: "error",
      text: "ガチャを引けませんでした...時間をおいてもう一度お試しください"
    });
  }
}

document.addEventListener('DOMContentLoaded', function () {
  const capsuleToy = document.getElementsByClassName("js-capsule-toy");
  for (let index = 0; index < capsuleToy.length; index++) {
    capsuleToy[index].addEventListener('click', capsuleToyFunc);
  }
});
