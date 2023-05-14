class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @user = current_user
    @group.users << @user
    email_params['emails'].split(',').each do |e|
      @group.users << User.where(email: e) unless @group.users.collect { |p| p[:email].to_s }.include?(e)
    end

    return unless @group.save

    redirect_to root_path
  end

  def show
    @group = Group.find_by_id(params[:id])
    @expenses = Expense.where(group_id: @group.id)
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def email_params
    params.require(:group).permit(:emails)
  end
end
