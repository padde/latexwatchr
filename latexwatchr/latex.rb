class Latex
  TEX_DIR    = "tex/"
  OUTPUT_DIR = "output/"
  PDF_LATEX  = true
  
  def initialize source, latex_flags = nil
    @source = "../" + source
    latex_flags ||= [ "-halt-on-error", "-file-line-error", "-output-directory #{OUTPUT_DIR}" ].join(" ")
    @latex_flags = latex_flags
  end
  
  def compile!
    Dir.chdir(TEX_DIR)
    
    if PDF_LATEX
      system "pdflatex -draftmode #{@latex_flags} #{@source}" if must_prepare?
      system "pdflatex #{@latex_flags} #{@source}"
    else
      system "latex #{@latex_flags} #{@source}" if must_prepare?
      system "latex #{@latex_flags} #{@source}"
      system "dvips #{dvi_file}"
      FileUtils.move(ps_filename, ps_file)
      system "ps2pdf #{ps_file}"
      FileUtils.move(pdf_filename, pdf_file)
    end
    
    Dir.chdir('..')
  end
  
  def must_prepare?
    d = Dir.open OUTPUT_DIR
    d.entries.count == 2
  end

  def pdf_filename; @source.gsub(/tex$/, 'pdf'); end
  def dvi_filename; @source.gsub(/tex$/, 'dvi'); end
  def ps_filename;  @source.gsub(/tex$/, 'ps');  end
  
  def pdf_file; OUTPUT_DIR + pdf_filename; end
  def dvi_file; OUTPUT_DIR + dvi_filename; end
  def ps_file;  OUTPUT_DIR + ps_filename;  end
end