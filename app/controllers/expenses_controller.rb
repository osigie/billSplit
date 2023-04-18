class ExpensesController < ApplicationController
  def create
    @group_id = params[:group_id]
    @payer = User.where(email: params[:email])[0]

    # total
    @total = params[:total].to_i

    # update main expense
    @old_expense = Expense.where(user_id: @payer.id, group_id: @group_id).first
    @expense_new = @old_expense.update(amount: @old_expense.amount.to_i + @total)

    if params[:type] == 'equal'

      # division
      @members = []
      params.except(:authenticity_token, :group_id, :email, :action, :total, :commit, :controller,
                    :type).each do |key, value|
        puts key
        @members.append(key) if value == '1'
      end

      # splitting amount
      @members.each do |member|
        old_row = Expense.where(user_id: member, group_id: @group_id).first
        new_row = old_row.update(amount: old_row.amount.to_i - @total / @members.length)
      end
    else
      @members = params.except(:authenticity_token, :group_id, :email, :action, :total, :commit, :controller,
                               :type).each

      # splitting amount
      @members.each do |key, value|
        old_row = Expense.where(user_id: key, group_id: @group_id).first
        new_row = old_row.update(amount: old_row.amount.to_i - value.to_i)
      end
    end

    return unless @expense_new

    redirect_back(fallback_location: root_path)
  end
end
