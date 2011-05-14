class Latex
  require 'fileutils'
  
  BASE_DIR = File.expand_path('.') + '/'
  TEX_DIR = File.expand_path('tex') + '/'
  PDF_LATEX  = true
  
  def initialize source, latex_flags = nil
    @source = source
    latex_flags ||= [ "-halt-on-error", "-file-line-error" ].join(" ")
    @latex_flags = latex_flags
  end
  
  def compile!
    status_ok = 1
    
    if PDF_LATEX
      status_ok = system "pdflatex -draftmode #{@latex_flags} #{@source}" if must_prepare?
      status_ok = system "bibtex #{aux_file}"
      status_ok = system "pdflatex #{@latex_flags} #{@source}"
    else
      status_ok = system "latex #{@latex_flags} #{@source}" if must_prepare?
      status_ok = system "bibtex #{aux_file}"
      status_ok = system "latex #{@latex_flags} #{@source}"
      status_ok = system "dvips #{dvi_file}" if status_ok
      status_ok = system "ps2pdf #{ps_file}" if status_ok
    end
    
    status_ok
  end
  
  def must_prepare?
    # REDO
    true
  end

  def aux_file; @source.gsub(/tex$/, 'aux'); end
  def pdf_file; @source.gsub(/tex$/, 'pdf'); end
  def dvi_file; @source.gsub(/tex$/, 'dvi'); end
  def ps_file;  @source.gsub(/tex$/, 'ps');  end
end