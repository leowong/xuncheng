$(document).ready(function() {
  $("#upload_image_link").colorbox({innerWidth:"320px", innerHeight:"120px", iframe:true});
});

$(document).ready(function() {
  $(".reply.cell").hover(
    function() {
      $(this).addClass("hightlight");
    },
    function() {
      $(this).removeClass("hightlight");
    }
  );
});
