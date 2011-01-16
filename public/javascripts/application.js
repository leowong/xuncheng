jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

jQuery.fn.highlightCurrent = function() {
  this.hover(
    function() {
      $(this).addClass("hightlight");
    },
    function() {
      $(this).removeClass("hightlight");
    }
  );
  return this;
};

jQuery.fn.insertName = function() {
  this.click(function() {
    var name = this.getAttribute("data-name");
    var currentText = $('textarea.content').val();
    $('textarea.content').focus().val(currentText + '@' + name + ' ');
  });
  return this;
};

$(document).ready(function() {
  $("#upload_image_link").colorbox({innerWidth:"360px", innerHeight:"150px", iframe:true, returnFocus:false});
});

$(document).ready(function() {
  $(".reply.cell").highlightCurrent();
});

$(document).ready(function() {
  $(".reply .meta").insertName();
});

$(document).ready(function() {
  $("#new_topic").submit(function() {
    $("#topic_submit").attr("disabled", true).addClass('disabled');
    return true;
  });
});

$(document).ready(function() {
  $("#new_reply").submit(function() {
    $("#reply_submit").attr("disabled", true).addClass('disabled');
    return true;
  });
});
