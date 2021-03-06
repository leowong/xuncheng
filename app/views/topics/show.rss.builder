xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @topic.title
    xml.description @topic.content
    xml.link topic_url(@topic)

    for reply in @topic.replies.order('created_at DESC')
      xml.item do
        xml.title truncate(reply.content, :length => 50)
        xml.pubDate reply.created_at.to_s(:rfc822)
        xml.link topic_url(@topic, :anchor => "r#{reply.reply_counter}")
        xml.guid topic_url(@topic, :anchor => "r#{reply.reply_counter}")
      end
    end
  end
end
