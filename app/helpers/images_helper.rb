module ImagesHelper
  def mark_used_images(post)
    ids = post.content.scan /\[img\].*?[\da-f]{2}\/[\da-f]{3}\/[\da-f]{4}\/(\d+?)\/\w+?\.?\w+?\?\d+?\[\/img\]/
    ids.flatten.uniq.each do |id|
      Image.find(id.to_i).update_attributes(:used => true, :post_type => post.class.to_s, :post_id => post.id)
    end
  end        
end
