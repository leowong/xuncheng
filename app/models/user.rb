class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :avatar_attributes, :signature, :biography, :email_publishing

  has_many :topics
  has_many :replies
  has_one :avatar, :as => :viewable, :dependent => :destroy

  accepts_nested_attributes_for :avatar, :reject_if => :all_blank, :allow_destroy => true

  validates :username, :presence => true, :uniqueness => true

  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def avatar_path(style = :normal)
    avatar.nil? ? "/images/avatar/default/#{style}.png" : avatar.attachment.url(style.to_sym)
  end
end
