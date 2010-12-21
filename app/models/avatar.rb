class Avatar < Asset
  has_attached_file :attachment,
    :styles => {
      :mini      => ['24x24#', :png],
      :normal    => ['48x48#', :png],
      :original  => ['73x73#', :png]
    },

    :storage => Rails.env.production? ? :s3 : :filesystem,

    :default_url => '/images/avatar/default/:style.png',
    :url => (Rails.env.production? ? "" : "/") +  "avatar/:hash_path/:style.:extension",
    :path => (Rails.env.production? ? "" : ":rails_root/public/") + "avatar/:hash_path/:style.:extension",

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
end
