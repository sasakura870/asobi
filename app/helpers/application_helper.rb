module ApplicationHelper
  def javascript_path
    path = "#{controller_path}/#{action_name}"
    javascript_file_exist? ? path : 'default'
  end

  def javascript_file_exist?
    path = "#{controller_path}/#{action_name}.js"
    manifest = File.open('public/packs/manifest.json') do |file|
      JSON.load(file)
    end
    manifest.key?(path)
  end

  def full_title(title = '')
    base_title = 'Asobi'
    if title.empty?
      return base_title
    else
      return title + ' - ' + base_title
    end
  end

  def date_format(datetime)
    datetime.strftime '%F'
  end

  def relative_time(datetime)
    time_ago_in_words(datetime) + '前'
  end

  def visitor
    @visitor ||= VisitorViewModel.new(user: current_user)
  end
end
