class Friendlist < ActiveRecord::Base
	belongs_to :user
	 validates :user_id, presence: true
     validates :friendid, presence: true
     validates_uniqueness_of :user_id, :scope =>[:friendid], :message => "you both are already friends"
end
