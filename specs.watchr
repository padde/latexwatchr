require 'latexwatchr/latex.rb'
require 'latexwatchr/application.rb'
require 'latexwatchr/notification.rb'

output_dir = Latex::TEX_DIR + Latex::OUTPUT_DIR
FileUtils.mkdir_p output_dir

puts "Watching .tex files..."

watch /tex\/.*\.tex/ do |md|
  source = md[0]
  
  tex = Latex.new( source )
  
  if tex.compile!
    Notification.send :success, "Compiled #{source}"
    Application.activate "Preview"
  else
    Notification.send :error, "Error in #{source}"
    Application.activate "Terminal"
  end
end