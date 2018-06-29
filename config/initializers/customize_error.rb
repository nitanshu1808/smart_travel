ActionView::Base.field_error_proc =  Proc.new do |html_tag, instance|
  if html_tag.to_s.include?("data-validate-error=\"true\"")
    tag_id = Nokogiri::HTML(html_tag).xpath('//textarea/@id | //input/@id | //select/@id')
    error_msg = Nokogiri::HTML(html_tag).xpath("//textarea/@*[starts-with(name(), 'data-error')] | //input/@*[starts-with(name(), 'data-err')] | //select/@*[starts-with(name(), 'data-err')]")
    %Q(#{html_tag}<label class="validation-error" id="#{tag_id}-error" for="#{tag_id}">#{error_msg}</label>).html_safe
  else
    %Q(<div class="validation-error">#{html_tag}</div>).html_safe
  end
end
