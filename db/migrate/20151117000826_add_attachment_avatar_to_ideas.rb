class AddAttachmentAvatarToIdeas < ActiveRecord::Migration
  def self.up
    change_table :ideas do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :ideas, :avatar
  end
end
