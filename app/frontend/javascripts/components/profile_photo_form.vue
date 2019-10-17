<template>
  <div>
    <croppa
      v-model="myCroppa"
      :width="220"
      :height="220"
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
    ></croppa>
    <button @click="createUserPhoto" type="button" class="btn btn-primary btn-block">適応する</button>
    <img
      v-if="generateImg !== null"
      :src="generateImg"
      style="width: 220px; height: 220px; border: 1px solid gray"
      alt="Cropped Image"
    />
  </div>
</template>

<script>
import Croppa from "vue-croppa";
import "vue-croppa/dist/vue-croppa.css";

vue.use(Croppa);
export default {
  props: {
    imgSrc: String
  },
  data() {
    return {
      myCroppa: this.imgSrc,
      generateImg: ""
    };
  },
  computed: {
    croopingImgIsExists: function() {
      this.myCroppa !== null;
    }
  },
  methods: {
    createUserPhoto: function(event) {
      console.log(this.myCroppa.generateDataUrl());
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
