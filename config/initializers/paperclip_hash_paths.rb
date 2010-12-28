Paperclip.interpolates :hash_path do |attachment, style|
  hash = Digest::MD5.hexdigest(attachment.instance.viewable_type.to_s + attachment.instance.viewable_id.to_s + attachment.instance.id.to_s)
  File.join(hash[0..1], hash[2..4], hash[5..8])
end
