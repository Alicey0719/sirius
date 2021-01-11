module AdminsHelper
    def page_title
        title = "Sirius"
        title = title + " | " + @page_title if @page_title
        title
    end

    def menu_link_to(text, path, options = {})
        content_tag :li do
            condition = options[:method] || !current_page?(path)            
            #リンク先が現ページ
            link_to_if(condition,text, path, options) do
                #txtをspanタグで囲む
                content_tag(:span, text)
            end
        end
    end
end