class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :avatar_attributes, :signature, :biography, :email_publishing, :locale, :login

  attr_accessor :login

  has_many :topics
  has_many :replies
  has_many :posts
  has_one :avatar, :as => :viewable, :dependent => :destroy
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :callings
  has_many :notifications, :through => :callings, :class_name => "Post"
  has_many :groupings
  has_many :nodes, :through => :groupings

  accepts_nested_attributes_for :avatar, :reject_if => :all_blank, :allow_destroy => true

  validates :username, :presence => true, :uniqueness => true
  validate :username_cannot_contain_whitespace_characters
  validate :username_cannot_contain_at_sign

  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_role, lambda { |role| where("roles_mask & #{2**ROLES.index(role.to_s)} > 0") }
  scope :node_subscribers, lambda { |post| subscribers_for(post) }

  ROLES = %w[admin moderator author]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def avatar_path(style = :normal)
    avatar.nil? ? "/images/avatar/default/#{style}.png" : avatar.attachment.url(style.to_sym)
  end

  def join_group(node)
    node.users << self unless node.users.include?(self)
  end

  def quit_group(node)
    node.users.delete(self) if node.users.include?(self)
  end

  protected

  def self.find_for_database_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end

  def self.subscribers_for(post)
    node_ids = %(SELECT nodes.id FROM nodes INNER JOIN nodings ON nodes.id = nodings.node_id WHERE (nodings.topic_id = :post_id))
    joins(:groupings).
      where("groupings.node_id IN (#{node_ids})", { :post_id => post }).
      select('DISTINCT users.*')
  end

  private

  def username_cannot_contain_whitespace_characters
    errors.add(:username, I18n.t('activerecord.errors.messages.contain_whitespace')) if username.index(/\s/)
  end

  def username_cannot_contain_at_sign
    errors.add(:username, I18n.t('activerecord.errors.messages.contain_at_sign')) if username.index(/@/)
  end
end
