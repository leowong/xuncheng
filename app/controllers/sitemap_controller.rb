class SitemapController < ApplicationController
  def sitemap
    @topics = Topic.all
    @nodes = Node.all
    @users = User.all
    @last_modified = Post.order(:id).last.created_at if Post.count > 0

    headers["Content-Type"] = "text/xml"
    headers["Last-Modified"] = @last_modified.nil? ? DateTime.new(2011, 1, 1).httpdate : @last_modified.httpdate
    render :layout => false
  end
end
