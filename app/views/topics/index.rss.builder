xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title t('site.name')
    xml.description t('site.description')
    xml.link topics_url

    for topic in @topics
      xml.item do
        xml.title topic.title
        xml.description topic.content
        xml.pubDate topic.created_at.to_s(:rfc822)
        xml.link topic_url(topic)
        xml.guid topic_url(topic)
      end
    end
  end
end
