xml.instruct!
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url
    xml.lastmod @last_modified.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") if @last_modified
    xml.changefreq "daily"
    xml.priority "1.0"
  end
  @topics.each do |topic|
    xml.url do
      xml.loc topic_url(topic)
      xml.lastmod topic.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S_00:00")
      xml.changefreq "weekly"
      xml.priority "0.8"
    end
  end
  @nodes.each do |node|
    xml.url do
      xml.loc node_url(node)
      xml.lastmod node.topics.first.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S_00:00") unless node.topics.empty?
      xml.changefreq "weekly"
      xml.priority "0.6"
    end
  end
  @users.each do |user|
    xml.url do
      xml.loc user_url(user)
      xml.lastmod user.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S_00:00")
      xml.changefreq "weekly"
      xml.priority "0.6"
    end
  end
end
