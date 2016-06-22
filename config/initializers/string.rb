#
class String
  def somente_numeros
    gsub(/[^0-9]/, '')
  end

  def somente_letras
    gsub(/[^a-zA-Z ]/, '')
  end

  def sem_numeros
    gsub(/[*0-9]/, '')
  end

  def remover_acentos
    return self if self.blank?
    texto = self
    texto = texto.gsub(/(á|à|ã|â|ä)/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    texto = texto.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    texto
  end

  def fileize
    remover_acentos.somente_letras.squish.underscore.gsub(" ", "_")
  end
end
