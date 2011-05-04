task :clean do
  dirname = "output/"
  dir = Dir.open(dirname)
  
  dir.each do |filename|
    next if filename == '.'
    next if filename == '..'
    
    f = dirname + filename 
    File.delete(f)
  end
end