class Topic < Post
  attr_accessible :title, :content

  belongs_to :user, :touch => true
  has_many :nodings
  has_many :nodes, :through => :nodings
  has_many :replies, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  scope :replied_by, lambda { |user| topics_replied_by(user) }

  self.per_page = 30

  def node_names
    nodes.map(&:name).join(', ')
  end

  def update_reply_counters
    replies.where(:reply_counter => nil).order(:id).each_with_index do |reply, i|
      reply.update_counter
    end
  end

  def increment_pageviews
    current_count = pageviews_count || 0
    Topic.record_timestamps=false
    update_attribute(:pageviews_count, current_count + 1)
    Topic.record_timestamps=true
  end

  private

  def self.topics_replied_by(user)
    topic_ids = %(SELECT topic_id FROM posts WHERE user_id = :user_id AND posts.type = 'Reply')
    order("posts.created_at DESC").
      where("posts.user_id <> :user_id AND posts.id IN (#{topic_ids})", { :user_id => user })
  end
end
