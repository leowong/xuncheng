class Topic < Post
  attr_accessible :title, :content

  belongs_to :user
  has_many :nodings
  has_many :nodes, :through => :nodings
  has_many :replies, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'posts.updated_at DESC'

  scope :replied_by, lambda { |user| topics_replied_by(user) }

  def node_names
    nodes.map(&:name).join(', ')
  end

  private

  def self.topics_replied_by(user)
    topic_ids = %(SELECT topic_id FROM posts WHERE user_id = :user_id AND posts.type = 'Reply')
    where("posts.user_id <> :user_id AND posts.id IN (#{topic_ids})", { :user_id => user })
  end
end
