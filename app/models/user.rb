class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :avatar_attributes, :signature, :biography, :email_publishing, :locale

  has_many :topics
  has_many :replies
  has_one :avatar, :as => :viewable, :dependent => :destroy
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :callings
  has_many :notifications, :through => :callings, :class_name => "Post"

  accepts_nested_attributes_for :avatar, :reject_if => :all_blank, :allow_destroy => true

  validates :username, :presence => true, :uniqueness => true
  validate :username_cannot_contain_whitespace_characters

  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_role, lambda { |role| where("roles_mask & #{2**ROLES.index(role.to_s)} > 0") }

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

  private

  def username_cannot_contain_whitespace_characters
    errors.add(:username, I18n.t('activerecord.errors.messages.contain_whitespace')) if username.index(/\s/)
  end
end
