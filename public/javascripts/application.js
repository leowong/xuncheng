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

$(document).ready(function() {
  $(".reply .meta").click(function() {
    var name = this.getAttribute("data-name");
    var currentText = $('textarea.content').val();
    $('textarea.content').focus().val(currentText + '@' + name + ' ');
  });
});
