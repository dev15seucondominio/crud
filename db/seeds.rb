# ruby encoding: utf-8
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TIPO = {
  desenvolvedor: 'Desenvolvedor',
  analista: 'Analista'
}

Pessoa.create!(
  [
    { nome: 'David Brahiam',        tipo: TIPO[:desenvolvedor] },
    { nome: 'Diego Felipe',         tipo: TIPO[:desenvolvedor] },
    { nome: 'Renato Jesus',         tipo: TIPO[:desenvolvedor] },
    { nome: 'José Eduardo',         tipo: TIPO[:analista] },
    { nome: 'Guilherme Nascimento', tipo: TIPO[:analista] },
    { nome: 'Júlio',                tipo: TIPO[:analista] }
  ]
)
