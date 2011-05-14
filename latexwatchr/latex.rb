class Latex
  require 'fileutils'
  
  TEX_DIR = File.expand_path('tex') + '/'
  PDF_LATEX  = true
  
  def initialize source, latex_flags = nil
    @source = source
    latex_flags ||= [ "-halt-on-error", "-file-line-error" ].join(" ")
    @latex_flags = latex_flags
  end
  
  def compile!
    ok = false
    
    if PDF_LATEX
      ok = system "pdflatex -draftmode #{@latex_flags} #{@source}" if must_prepare?
      ok = system "bibtex #{aux_file}" if use_bibtex?
      ok = system "pdflatex #{@latex_flags} #{@source}"
    else
      ok = system "latex #{@latex_flags} #{@source}" if must_prepare?
      ok = system "bibtex #{aux_file}" if use_bibtex?
      ok = system "latex #{@latex_flags} #{@source}"
      ok = system "dvips #{dvi_file}" if ok
      ok = system "ps2pdf #{ps_file}" if ok
    end
    
    ok
  end
  
  def must_prepare?
    not file_exists? /.*\.aux$/
  end
  
  def use_bibtex?
    file_exists? /.*\.bib$/
  end
  
  def file_exists? filename, dir = TEX_DIR
    match = Dir.entries(dir).detect do |f|
      f.match filename
    end
    
    not match.nil?
  end

  def aux_file
    @source.gsub(/tex$/, 'aux')
  end
  
  def pdf_file
    @source.gsub(/tex$/, 'pdf')
  end
  
  def dvi_file
    @source.gsub(/tex$/, 'dvi')
  end
  
  def ps_file
    @source.gsub(/tex$/, 'ps')
  end
end