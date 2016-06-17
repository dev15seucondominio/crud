#
class String
  def somente_numeros
    gsub(/[^0-9]/, '')
  end

  def sem_numeros
    gsub(/[*0-9]/, '')
  end
end
