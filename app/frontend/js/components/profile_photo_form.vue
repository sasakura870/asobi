<template>
  <form @submit="setUserPhoto" action="/settings/profile/0" accept-charset="UTF-8" method="post">
    <input type="hidden" name="_method" value="patch" />
    <input type="hidden" name="authenticity_token" :value="token" />
    <croppa
      v-model="myCroppa"
      :initial-image="imgSrc"
      :width="250"
      :height="250"
      :canvas-color="'default'"
      :placeholder="'プロフィール画像をアップロード'"
      :placeholder-font-size="0"
      :placeholder-color="'default'"
      :accept="'image/*'"
      :file-size-limit="2 * 1024 * 1024"
      :prevent-white-space="true"
      :show-remove-button="true"
      :disable-drag-and-drop="true"
      @file-type-mismatch="onFileTypeMismatch"
      @file-size-exceed="onFileSizeExceed"
      class="u-mb-3"
    ></croppa>
    <div class="p-settings-profile-contents__photo-submit">
      <input type="hidden" id="profile_photo" name="profile[photo]" :value="generateImg" />
      <button class="c-hand-write-btn c-hand-write-btn--wide">適応する</button>
    </div>
  </form>
</template>

<script>
import Croppa from "vue-croppa";
import "vue-croppa/dist/vue-croppa.css";

vue.use(Croppa);
export default {
  props: {
    imgSrc: String,
    token: String
  },
  data() {
    return {
      myCroppa: {},
      generateImg: ""
    };
  },
  methods: {
    setUserPhoto: function(event) {
      this.generateImg = this.myCroppa.generateDataUrl();
    },
    onFileTypeMismatch: function() {
      Swal.fire({
        type: "error",
        title: "対応していないファイルの形式です",
        text: "画像ファイルを選択してください。"
      });
    },
    onFileSizeExceed: function() {
      Swal.fire({
        type: "error",
        title: "画像のデータサイズが大きすぎます",
        text: "プロフィール画像に使えるファイルのデータサイズは2MBまでです。"
      });
    }
  }
};
</script>

<style>
</style>
