Paperclip.interpolates :hash_path do |attachment, style|
  Digest::MD5.hexdigest(attachment.instance.viewable_type.to_s + attachment.instance.viewable_id.to_s) 
end
