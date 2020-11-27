class ApplicationController < ActionController::Base
  private def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  # ヘルパーメソッド
  # テンプレートの中でも使えるように登録。
  helper_method :current_member

  # 自作例外を定義
  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  # before_action用メソッド
  private def login_required
    raise LoginRequired unless current_member
  end

end
