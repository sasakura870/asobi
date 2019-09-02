module ApplicationHelper
  def full_title(title = '')
    base_title = 'Asobi'
    if title.empty?
      return base_title
    else
      return title + ' - ' + base_title
    end
  end
end
