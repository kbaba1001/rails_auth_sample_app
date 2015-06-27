module Users
  class PasswordsController < ApplicationController
    def edit
      @form = PasswordForm.new(User.find(params[:user_id]))
    end

    def update

    end
  end
end
