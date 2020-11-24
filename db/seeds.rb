# db/seeds/developmentの下に"テーブル名.rb"があれば、それをrequireメソッドで実行する
# Rails.rootで、アプリケーションのパスを取得できる。(~/省略/asagao)
# そこにjoinメソッドを使って、パスを組み立てる
table_names = %w(members)
table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end

end
