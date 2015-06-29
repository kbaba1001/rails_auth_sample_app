module Users
  class PasswordsController < ApplicationController
    def edit
      @form = PasswordForm.new(User.find(params[:user_id]))
    end

    def update
      @form = PasswordForm.new(User.find(params[:user_id]))

      if @form.validate(params[:users_password])
        @form.save do |attributes|
          user = @form.model
          user.update(password_digest: Monban.hash_token(params[:users_password][:new_password]))
        end

        redirect_to root_path
      else
        render :edit
      end
    end
  end
end
