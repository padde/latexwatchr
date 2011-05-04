class Latex
  DEFAULTS = {
    :output_dir => "output/",
    :pdf_latex  => true
  }
  
  attr_reader :output_dir
  
  def initialize source, output_dir = DEFAULTS[:output_dir], latex_flags = nil
    @source = source
    
    @output_dir = output_dir
    
    latex_flags ||= [
      "-halt-on-error",
      "-file-line-error",
      "-output-directory #{@output_dir}"
    ].join(" ")
    @latex_flags = latex_flags
  end
  
  def compile!
    if DEFAULTS[:pdf_latex]
      if must_prepare?
        system "pdflatex -draftmode #{@latex_flags} #{@source}"
      end
      
      system "pdflatex #{@latex_flags} #{@source}"
    else
      if must_prepare?
        system "latex  #{@latex_flags} #{@source}"
      end
      
      system "latex  #{@latex_flags} #{@source}"
      
      system "dvips #{dvi_file}"
      FileUtils.move(ps_filename, ps_file)
      
      system "ps2pdf #{ps_file}"
      FileUtils.move(pdf_filename, pdf_file)
    end
  end
  
  def must_prepare?
    d = Dir.open @output_dir
    d.entries.count == 2
  end

  def pdf_filename
    @source.gsub(/tex$/, 'pdf')
  end
  
  def pdf_file
    output_dir + pdf_filename
  end
  
  def dvi_file
    output_dir + @source.gsub(/tex$/, 'dvi')
  end

  def ps_filename
    @source.gsub(/tex$/, 'ps')
  end
  
  def ps_file
    output_dir + ps_filename
  end
end



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



class Notification
  def self.send message_type, message
    icon = case message_type
      when :success then ".growl_icons/success.png"
      when :error   then ".growl_icons/error.png"
    end
  
    system "growlnotify -n latexwatchr --image #{icon} -m \"#{message}\" LaTeXwatchr"
  end
end