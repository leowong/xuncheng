class Avatar < Asset
  has_attached_file :attachment,
    :styles => {
      :mini      => ['24x24#', :png],
      :normal    => ['48x48#', :png],
      :original  => ['73x73#', :png]
    },
    :url => "/avatar/:hash_path/:style.:extension",
    :path => ":rails_root/public/avatar/:hash_path/:style.:extension"

  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 2.megabytes
  validates_attachment_content_type :attachment,
    :content_type => [
      'image/gif', 'image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png'
    ]
end
