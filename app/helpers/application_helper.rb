module ApplicationHelper
  def setup_user(user)
    user.tap do |u|
      u.build_avatar if u.avatar.nil?
    end
  end

  def wrap_text(content, render = { :images => true, :videos => true })
    content = simple_format(h(content))

    if current_user
      content = content.gsub '@' + current_user.username,
        '@' + '<span class="name me">' + current_user.username + '</span>'
    end

    if render[:images]
      content = content.gsub /\[img\](.*?)\[\/img\]/ do |s|
        image_tag $1
      end
    end

    if render[:videos]
      content = content.gsub /http:\/\/player\.youku\.com\/player\.php\/sid\/\w+?\/v.swf/ do |s|
        %Q(<embed src="#{$&}" quality="high" width="480" height="400" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"></embed>)
      end
    end

    content = content.gsub /(<a .*?href=".*?".*?>)(.*?)(<\/a>)/ do |s|
      $1 + trim_url($2) + $3
    end

    content = auto_link(content, :html => { :target => "_blank", :rel => "nofollow" })

    content = content.gsub /(<a .*?href=".*?".*?>)(.*?)(<\/a>)/ do |s|
      $1 + trim_url($2) + $3
    end
  end

  def cloudfront(url)
    url.gsub(/^https?:\/\/s3.amazonaws.com\/xuncheng/, "http://cdn.xuncheng.net")
  end

  private

  def trim_url(url, max_width = 42)
    if url.length <= max_width
      url
    else
      head = truncate(url, :length => max_width - 7)
      tail = url[-7, 7]
      head + tail
    end
  end
end
