class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  
  has_many :sent_invites, class_name: "Relationship", foreign_key: :inviting_id
  has_many :received_invites, class_name: "Relationship", foreign_key: :invited_id

  has_many :invited_users, through: :sent_invites, source: :invited_user
  has_many :inviting_users, through: :received_invites, source: :inviting_user

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # With Amazon S3 it would look like this:
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" },
  #   :default_url => "/images/:style/missing.png",
  #   :url  => ":s3_domain_url",
  #   :path => "public/avatars/:id/:style_:basename.:extension",
  #   :storage => :fog,
  #   :fog_credentials => {
  #     provider: 'AWS',
  #     aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
  #     aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  #   },
  #   fog_directory: ENV["FOG_DIRECTORY"]


  def full_name
    name.blank? ? email : name
    # same as code above:
    # if self.name.blank?
    #   self.email
    # else
    #   self.name
    # end
  end
end
