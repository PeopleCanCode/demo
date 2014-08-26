class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @invited_user = User.find(params[:relationship][:invited_id])
    @relationship = current_user.sent_invites.build(invited_id: @invited_user.id)

    if @relationship.save
      flash[:success] = "Successfully invited."
      redirect_to @invited_user
    else
      flash[:danger] = "Unsuccessful."
      redirect_to
    end
  end

  def index
    @sent_invites = current_user.sent_invites
    @received_invites = current_user.received_invites
  end
  
  def destroy
    @relationship = Relationship.find(params[:id])
    if @relationship.inviting_user == current_user
      @relationship.destroy
      flash[:success] = "Removed relationship"
    end
    redirect_to @relationship.invited_user
  end
end
