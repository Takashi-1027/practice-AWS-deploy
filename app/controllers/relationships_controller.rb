class RelationshipsController < ApplicationController

  def create
    relationships = Relationship.new(follower: current_user)
    relationships.followed = User.find(params[:user_id])
    if (relationships.follower.id == current_user.id) or (relationships.follower.id != relationships.followed.id)
      relationships.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    user = User.find(params[:user_id])
    relationships = Relationship.find_by(followed: user, follower: current_user)
    if relationships
      relationships.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

end
