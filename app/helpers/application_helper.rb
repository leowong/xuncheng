module ApplicationHelper
  def setup_user(user)
    returning(user) do |u|
      u.build_avatar if @user.avatar.nil?
    end
  end

  def wrap_text(content)
    content = auto_link(simple_format(h(content)), :html => { :rel => "nofollow noindex external" })
    content.gsub /(<a .*?href=".*?".*?>)(.*?)(<\/a>)/ do |s|
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
