class ErrorsController < ActionController::Base
  layout 'error'

  def show
    # 発生した例外をexに代入
    ex = request.env['action_dispatch.exception']

    if ex.kind_of?(ActionController::RoutingError)
      # 発生した例外がActionController::RoutingErrorクラスのインスタンスの時
      render 'not_found', status: 404, formats: [:html]
    else
      # それ以外はhtml書式でinternal_server_errorを実行
      render 'internal_server_error', status: 500, formats: [:html]
    end
  end

end
