module ApplicationHelper
  def tailwind_alert_class(type)
    case type.to_sym
    when :notice
      "bg-green-100 border-green-400 text-green-700"
    when :alert
      "bg-red-500 border-red-400 text-white"
    when :error
      "bg-orange-100 border-orange-400 text-orange-700"
    when :info
      "bg-blue-100 border-blue-400 text-blue-700"
    else
      "bg-gray-100 border-gray-400 text-gray-700"
    end
  end
end