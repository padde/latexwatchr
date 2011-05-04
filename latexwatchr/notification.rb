class Notification
  def self.send message_type, message
    icon = case message_type
      when :success then ".growl_icons/success.png"
      when :error   then ".growl_icons/error.png"
    end
  
    system "growlnotify -n latexwatchr --image #{icon} -m \"#{message}\" LaTeXwatchr"
  end
end