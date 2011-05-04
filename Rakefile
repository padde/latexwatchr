task :clean do
  require 'latexwatchr/latex.rb'
  dirname = Latex::TEX_DIR + Latex::OUTPUT_DIR
  
  dir = Dir.open(dirname)
  
  dir.each do |filename|
    next if filename == '.'
    next if filename == '..'
    
    f = dirname + filename 
    File.delete(f)
  end
end