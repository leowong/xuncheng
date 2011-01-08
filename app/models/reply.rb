class Reply < Post
  attr_accessible :content, :topic_id

  belongs_to :user, :touch => true
  belongs_to :topic, :touch => true

  validates :content, :presence => true
  validates :topic_id, :presence => true

  default_scope :order => 'posts.created_at'

  def update_counter
    update_attribute(:reply_counter, counter)
  end

  private

  def counter
    topic.replies.where('id <= ?', self.id).order(:id).count
  end
end
