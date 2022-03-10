module RelationshipsHelper
  def find_followed_by_user_id user
    current_user.active_relationships.find_by followed_id: user.id
  end
end
