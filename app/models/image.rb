class Image < Asset
  IMAGE_URI = "image/:hash_path/:id/:style.:extension"

  has_attached_file :attachment,
    :styles => {
      :thumb => ['73x73#', :jpg],
      :original  => ['565>', :jpg]
    },

    :convert_options => { :all => '-strip -background white -flatten +matte' },
    :storage => Rails.env.production? ? :s3 : :filesystem,

    :url => (Rails.env.production? ? "" : "/") +  IMAGE_URI,
    :path => (Rails.env.production? ? "" : ":rails_root/public/") + IMAGE_URI,

    :bucket => ENV['S3_BUCKET'] || AWS_S3['bucket'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'] || AWS_S3['access_key_id'],
      :secret_access_key => ENV['S3_SECRET'] || AWS_S3['secret_access_key']
    },

    :s3_headers => {'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate }

  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 2.megabytes
  validates_attachment_content_type :attachment,
    :content_type => [
      'image/gif', 'image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png'
    ]

  after_post_process :find_dimensions

  private

  def find_dimensions
    temp_file = attachment.queued_for_write[:original]
    dimensions = Paperclip::Geometry.from_file(temp_file)
    self.attachment_width = dimensions.width
    self.attachment_height = dimensions.height
  end
end
