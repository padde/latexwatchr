require 'latexwatchr.rb'

output_dir = "./output/"
FileUtils.mkdir_p output_dir

puts "Watching .tex files..."

watch /.*\.tex/ do |md|
  source = md[0]
  tex = Latex.new( source )
  # output = tex.output_file
  
  if tex.compile!
    Notification.send :success, "Compiled #{source}"
    Application.activate "Preview"
  else
    Notification.send :error, "Error in #{source}"
    Application.activate "Terminal"
  end
end