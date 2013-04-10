class ChannelsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  def self.channel_counter channel_id
    where("channel_id = ?", channel_id).count
  end

  def self.channel_exist_for_user? channel_id, user_id
    where("channel_id = ? AND user_id = ?", channel_id, user_id).count
  end

  def self.delete_channel_for_user channel_id, user_id
    id = where("channel_id = ? AND user_id = ?", channel_id, user_id).first.id
    self.find(id).destroy
  end
end
