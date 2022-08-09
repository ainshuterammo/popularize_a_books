# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    '/books'
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  # def reject_inactive_customer
  #   @customer = Customer.find_by(email: params[:customer][:email])
  #   if @customer
  #     if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
  #       flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
  #       redirect_to new_customer_session_path
  #     end
  #   end
  # end

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to books_path, notice: 'guestuserでログインしました。'
  end

  # def reject_customer
  #   @customer = Customer.find_by(email: params[:customer][:email])
  #   if @customer
  #     if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
  #       reset_session
  #       flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
  #       redirect_to root_path
  #     else
  #       flash[:notice] = "項目を入力してください"
  #     end
  #   end
  # end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
