class Admin::OperatorsController < Admin::ApplicationController
  def show
    @operator = current_user
  end
end
