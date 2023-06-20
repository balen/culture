#
def add_likert(question)
    likert = Survey::LikertSetting.create!(
    left_label_en: "Strongly disagree",
    right_label_en: "Strongly agree",
    left_label_fr: "Pas du tout d'accord",
    right_label_fr: "Tout à fait d'accord",
    left_label_pt_br: "Discordo totalmente",
    right_label_pt_br: "Concordo plenamente",
    survey_question: question,
    likert_categories_attributes: [
      {
        label_en: '1',
        label_fr: '1',
        label_pt_br: '1',
        value: 1,
        order: 1
      },
      {
        label_en: '2',
        label_fr: '2',
        label_pt_br: '2',
        value: 2,
        order: 2
      },
      {
        label_en: '3',
        label_fr: '3',
        label_pt_br: '3',
        value: 3,
        order: 3
      },
      {
        label_en: '4',
        label_fr: '4',
        label_pt_br: '4',
        value: 4,
        order: 4
      },
      {
        label_en: '5',
        label_fr: '5',
        label_pt_br: '5',
        value: 5,
        order: 5
      },
      {
        label_en: '6',
        label_fr: '6',
        label_pt_br: '6',
        value: 6,
        order: 6
      },
      {
        label_en: '7',
        label_fr: '7',
        label_pt_br: '7',
        value: 7,
        order: 7
      }
    ]
  )
end

# Survey
p "Start Survey seeds"
unless Survey.count > 0
  survey = Survey.create!(
    name_en: "Better Understand My Organizational Culture",
    name_fr: "Mieux Comprendre Ma Culture Organisationnelle",
    name_pt_br: "Entender melhor minha cultura organizacional"
  )

  # Psychological Safety
  survey_group = Survey::Group.create!(
    name_en: "Psychological Safety",
    name_fr: "Sécurité psychologique",
    name_pt_br: "Segurança psicológica",
    survey: survey
  )
  question = Survey::Question.create!(
    question_en: "If you make a mistake on this team, it is often held against you",
    question_fr: "Si vous commettez une erreur dans cette équipe, elle sera souvent retenue contre vous",
    question_pt_br: "Se você comete um erro neste time, isso será frequentemente jogado contra você.",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "Members of this team are able to bring up problems and tough issues",
    question_fr: "Les membres de cette équipe sont capables de soulever des problèmes et des questions sans concession",
    question_pt_br: "Membros desta equipe são capazes de discutir problemas sensíveis e sérios",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "People on this team sometimes reject others for being different",
    question_fr: "Il arrive que les gens de cette équipe rejettent les autres parce qu'ils sont différents",
    question_pt_br: "Pessoas neste time tendem a rejeitar outros por serem diferentes",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "It is safe to take a risk in this team",
    question_fr: "On peut sans danger prendre des risques dans cette équipe",
    question_pt_br: "É seguro tomar riscos neste time",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "It is difficult to ask other members of this team for help",
    question_fr: "Il est difficile de demander de l'aide aux autres membres de cette équipe",
    question_pt_br: "É difícil pedir aos membros deste time por ajuda",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "No one on this team would deliberately act in a way that undermines my efforts",
    question_fr: "Personne dans cette équipe n'agirait délibérément de manière à saper mes efforts",
    question_pt_br: "Ninguém neste time agiria deliberadamente em uma maneira que atrapalharia meus esforços",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "Working with members of this team my unique skills and talents are valued and utilized",
    question_fr: "Quand je travaille avec les membres de cette équipe, mes compétences et talents propres sont appréciés et employés",
    question_pt_br: "Ao trablhar com membros deste time meus talentos e habilidades únicas são valorizadas e utilizadas",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)

  # Total Motivation
  survey_group = Survey::Group.create!(
    name_en: "Total Motivation",
    name_fr: "Motivation totale",
    name_pt_br: "Motivação total",
    survey: survey
  )
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because the work itself is fun to do",
    question_fr: "Je continue de travailler ici car le travail lui-même est gratifiant",
    question_pt_br: "Eu continuo a trabalhar nesta atividade porque o trabalho é divertido",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because I believe this work has an important purpose",
    question_fr: "Je continue de travailler ici car l'objectif de ce travail a une grande importance pour moi",
    question_pt_br: "Eu continuo a trabalhar aqui pois meu trabalho tem um propósito importante",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because this type of work will help me to reach my personal goals",
    question_fr: "Je continue à travailler ici car le travail est utile pour l'atteinte de mes objectifs personnels",
    question_pt_br: "Eu continuo a trabalhar aqui pois meu trabalho me ajuda a atingir meus objetivos pessoais",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because if I didn’t, I would disappoint myself or people I care about",
    question_fr: "Je continue de travailler ici car si je le quittais, je me décevrais ou je décevrais des personnes qui me sont chères",
    question_pt_br: "Eu continuo a trabalhar aqui porque caso contrário, eu desapontaria a mim ou pessoas que valorizo",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because without this job, I would be worried I couldn’t meet my financial objectives",
    question_fr: "Je continue de travailler ici car si je le quittais, je me décevrais ou je décevrais des personnes qui me sont chères",
    question_pt_br: "Eu continuo a trabalhar aqui pois sem este trabalho, eu não atenderia meus objetivos financeiros",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I continue to work at my current job because without this job, I would be worried I couldn’t meet my financial objectives",
    question_fr: "Je continue à travailler ici car sans ce travail, je serais inquiet pour mes objectifs financiers",
    question_pt_br: "Não há boa razão para continuar no meu trabalho atual",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)

  # Growth Mindset
  survey_group = Survey::Group.create!(
    name_en: "Growth Mindset",
    name_fr: "Mentalité de croissance",
    name_pt_br: "Mentalidade de crescimento",
    survey: survey
  )
  question = Survey::Question.create!(
    question_en: "There is no good reason why I continue working at my current job",
    question_fr: "Il n'existe aucune bonne raison pour laquelle je continue à travailler ici",
    question_pt_br: "Eu pessoalmente não acredito que possa fazer muito para aumentar minha inteligência",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I don’t think I personally can do much to increase my intelligence.",
    question_fr: "Personnellement, je ne pense pas que je peux faire grand chose pour augmenter mon intelligence.",
    question_pt_br: "Eu pessoalmente não acredito que possa fazer muito para aumentar minha inteligência",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I can learn new things, but I don’t have the ability to change my basic intelligence",
    question_fr: "Je peux acquérir de nouvelles connaissances, mais je n'ai pas la capacité de changer mon intelligence de départ",
    question_pt_br: "Eu posso aprender novas coisas, mas acredito não ter habilidade de mudar minha inteligência básica",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "My intelligence is something about me that I personally can’t change very much",
    question_fr: "Mon intelligence est quelque chose en moi que je ne peux pas changer beaucoup",
    question_pt_br: "Minha inteligência é algo sobre mim que eu pessoalmente não consigo mudar muito",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "To be honest, I don’t think I can really change how intelligent I am",
    question_fr: "Pour être honnête, je ne pense pas que je peux vraiment changer l'efficacité de mon intelligence",
    question_pt_br: "Para ser honesto, eu não sei se posso mudar o meu grau de inteligencia",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "With enough time and effort I think I could significantly improve my intelligence level",
    question_fr: "Avec assez de temps et d'effort, je peux augmenter mon intelligence de façon significative",
    question_pt_br: "Com tempo e esforço eu acredito que possa melhorar meu nivel de inteligencia",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I believe I can always substantially improve on my intelligence",
    question_fr: "Je pense qu'il est toujours possible pour moi d'augmenter mon intelligence",
    question_pt_br: "Eu acredito que sempre possa aumentar substancialmente minha inteligencia",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "Regardless of my current intelligence level, I think I have the capacity to change it quite a bit",
    question_fr: "Peu importe mon degré d'intelligence, j'ai la capacité de l'augmenter de façon significative",
    question_pt_br: "Apesar do meu nivel atual de inteligência, eu acredito que tenha capacidade de mudar um pouco.",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
  question = Survey::Question.create!(
    question_en: "I believe I have the ability to change my basic intelligence level considerably over time",
    question_fr: "Je crois que j'ai la capacité d'augmenter considérablement mon intelligence avec le temps",
    question_pt_br: "Eu acredito que tenho a abilidade de mudar o meu nível básico de inteligência de forma considerável ao longo do tempo.",
    group: survey_group,
    question_type: :likert
  )
  add_likert(question)
end
p "End Survey seeds"
