desc 'Clean up the output directory'
task :clean do
  require './latexwatchr/latex.rb'
  dirname = Latex::TEX_DIR
  
  dir = Dir.open(dirname)
  
  dir.each do |filename|
    next if filename == '.'
    next if filename == '..'
    
    if filename =~ /.*\.aux/ or
       filename =~ /.*\.bbl/ or
       filename =~ /.*\.blg/ or
       filename =~ /.*\.log/ or
       filename =~ /.*\.pdf/
    
      f = dirname + filename 
      File.delete(f)
      # puts "delete#{f}"
    end
  end
end