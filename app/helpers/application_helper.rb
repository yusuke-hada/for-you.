module ApplicationHelper
  def tailwind_alert_class(type)
    alert_classes = {
      notice: 'bg-green-100 border-green-400 text-green-700',
      alert: 'bg-red-500 border-red-400 text-white',
      error: 'bg-orange-100 border-orange-400 text-orange-700',
      info: 'bg-blue-100 border-blue-400 text-blue-700',
      default: 'bg-gray-100 border-gray-400 text-gray-700'
    }

    alert_classes[type.to_sym] || alert_classes[:default]
  end

  def page_title(page_title = '')
    base_title = 'foy you'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
