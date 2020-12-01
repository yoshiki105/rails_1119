module ApplicationHelper
  def page_title
    title = 'Morning Glory'
    title = "#{@page_title}-#{title}" if @page_title
    title
  end

  def menu_link_to(text, path, options = {})
    # liタグを生成
    content_tag :li do
      # 現在のページの場合はリンクせずに、spanタグでテキストを囲む
      link_to_unless_current(text, path, options) do
        # spanタグを生成
        content_tag(:span, text)
      end
    end
  end
end
