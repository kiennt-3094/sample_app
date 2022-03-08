$('#micropost_image').blind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > Settings.settings.micropost.image.max_size) {
    alert(I18n.t("microposts.oversized"));
  }
})
