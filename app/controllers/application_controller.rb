class ApplicationController < ActionController::Base
  # ヘルパーメソッド
  # テンプレートの中でも使えるように登録。
  helper_method :current_member

  # 自作例外を定義
  class LoginRequired < StandardError; end

  class Forbidden < StandardError; end

  # 本番環境またはエラー処理自体の開発時のとき
  if Rails.env.production? || ENV['RESCUE_EXCEPTIONS']
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end

  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden

  # before_action用メソッド
  private

  def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def login_required
    raise LoginRequired unless current_member
  end

  def login_required
    raise LoginRequired unless current_member
  end

  def rescue_bad_request(exception)
    render 'errors/bad_request', status: 400, layout: 'error',
      formats: [:html]
  end

  def rescue_login_required(exception)
    render 'errors/login_required', status: 403, layout: 'error',
      formats: [:html]
  end

  def rescue_forbidden(exception)
    render 'errors/forbidden', status: 403, layout: 'error',
      formats: [:html]
  end

  def rescue_not_found(exception)
    render 'errors/not_found', status: 404, layout: 'error',
      formats: [:html]
  end

  def rescue_internal_server_error(exception)
    render 'errors/internal_server_error', status: 500, layout: 'error',
      formats: [:html]
  end
end
