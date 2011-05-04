class Application
  def self.activate app
    script = <<-OSASCRIPT
      tell application "#{app}"
        activate
      end tell
    OSASCRIPT
  
    system "osascript -e '#{script}'"
  end
end