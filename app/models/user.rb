class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  # belongs_to :books
  has_many :favorites, dependent: :destroy
  # has_many :favorites,through: :favorites
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォローしている人取得(Userのfollowerから見た関係)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォローされている人取得(Userのfollowedから見た関係)
  has_many :following_user, through: :follower, source: :followed # 自分がフォローされている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  def self.search(search, word)
    if search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @user = User.where("#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

end
