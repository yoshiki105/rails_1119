class ApplicationController < ActionController::Base
  private def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  # ヘルパーメソッド
  # テンプレートの中でも使えるように登録。
  helper_method :current_member
end
