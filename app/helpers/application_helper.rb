module ApplicationHelper
  def setup_user(user)
    user.tap do |u|
      u.build_avatar if u.avatar.nil?
    end
  end

  def wrap_text(content, render = { :images => true })
    content = simple_format(h(content))

    if render[:images]
      content = content.gsub /\[img\](.*?)\[\/img\]/, do |s|
        image_tag $1
      end
    end

    content = content.gsub /(<a .*?href=".*?".*?>)(.*?)(<\/a>)/ do |s|
      $1 + trim_url($2) + $3
    end

    content = auto_link(content, :html => { :rel => "nofollow noindex external" })

    content = content.gsub /(<a .*?href=".*?".*?>)(.*?)(<\/a>)/ do |s|
      $1 + trim_url($2) + $3
    end
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
