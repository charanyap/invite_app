class Post < ActiveRecord::Base
	 belongs_to :user
	  validates :comment, presence: true, length: { maximum: 100 }
	 default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true

	# Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    frinds_user_ids = "SELECT friendid  FROM friendlists
                         WHERE user_id = :user_id and status = 1 "
    where("user_id IN (#{frinds_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

end
