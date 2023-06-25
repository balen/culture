class Survey::CultureData
  LIKERT_DEFAULT = {
              left_label_en: "Strongly disagree",
              right_label_en: "Strongly agree",
              left_label_fr: "Pas du tout d'accord",
              right_label_fr: "Tout à fait d'accord",
              left_label_pt_br: "Discordo totalmente",
              right_label_pt_br: "Concordo plenamente",
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
            }
  SEED_SURVEY = {
    id: "55d68108-c458-4bbf-b164-4f5c4dc3d7b6",
    name_en: "Better Understand My Organizational Culture",
    name_fr: "Mieux Comprendre Ma Culture Organisationnelle",
    name_pt_br: "Entender melhor minha cultura organizacional",
  }

  SEED_PS_GROUP = {
    id: "e93e88e8-f956-4595-a6f3-251f94d70941",
    survey_id: "55d68108-c458-4bbf-b164-4f5c4dc3d7b6",
    short_code: "PS",
    name_en: "Psychological Safety",
    name_fr: "Sécurité psychologique",
    name_pt_br: "Segurança psicológica"    
  }

  SEED_TM_GROUP = {    
    id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
    survey_id: "55d68108-c458-4bbf-b164-4f5c4dc3d7b6",
    short_code: "TM",
    name_en: "Total Motivation",
    name_fr: "Motivation totale",
    name_pt_br: "Motivação total",
  }

  SEED_GM_GROUP = {    
    id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
    survey_id: "55d68108-c458-4bbf-b164-4f5c4dc3d7b6",
    short_code: "GM",
    name_en: "Growth Mindset",
    name_fr: "Mentalité de croissance",
    name_pt_br: "Mentalidade de crescimento"
  }

  SEED_PS_QUESTIONS = [
    {
      id: "06bed0ce-22f5-4274-9c8b-7a1b86f386fb",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS01",
      question_en: "If you make a mistake on this team, it is often held against you",
      question_fr: "Si vous commettez une erreur dans cette équipe, elle sera souvent retenue contre vous",
      question_pt_br: "Se você comete um erro neste time, isso será frequentemente jogado contra você.",
      question_type: :likert
    },
    {
      id: "4a784b42-3e87-4fb5-a94e-4028c7684a0c",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS02",
      question_en: "Members of this team are able to bring up problems and tough issues",
      question_fr: "Les membres de cette équipe sont capables de soulever des problèmes et des questions sans concession",
      question_pt_br: "Membros desta equipe são capazes de discutir problemas sensíveis e sérios",
      question_type: :likert
    },
    {
      id: "3be36669-abc2-449c-8403-e96107ebcf7b",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS03",
      question_en: "People on this team sometimes reject others for being different",
      question_fr: "Il arrive que les gens de cette équipe rejettent les autres parce qu'ils sont différents",
      question_pt_br: "Pessoas neste time tendem a rejeitar outros por serem diferentes",
      question_type: :likert
    },
    {
      id: "d77d426b-489e-4a3e-87db-dd76496ccab1",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS04",
      question_en: "It is safe to take a risk in this team",
      question_fr: "On peut sans danger prendre des risques dans cette équipe",
      question_pt_br: "É seguro tomar riscos neste time",
      question_type: :likert
    },
    {
      id: "2056c40d-ee31-418e-a647-16cd40d34603",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS05",
      question_en: "It is difficult to ask other members of this team for help",
      question_fr: "Il est difficile de demander de l'aide aux autres membres de cette équipe",
      question_pt_br: "É difícil pedir aos membros deste time por ajuda",
      question_type: :likert
    },
    {
      id: "acc64ab5-f4a5-44b4-a19b-fc53c6f72428",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS06",
      question_en: "No one on this team would deliberately act in a way that undermines my efforts",
      question_fr: "Personne dans cette équipe n'agirait délibérément de manière à saper mes efforts",
      question_pt_br: "Ninguém neste time agiria deliberadamente em uma maneira que atrapalharia meus esforços",
      question_type: :likert
      # likert_setting_attributes: LIKERT_DEFAULT
    },
    {
      id: "060c8187-897a-4e39-bfc7-9b37f2812bbc",
      group_id: "e93e88e8-f956-4595-a6f3-251f94d70941",
      short_code: "PS07",
      question_en: "Working with members of this team my unique skills and talents are valued and utilized",
      question_fr: "Quand je travaille avec les membres de cette équipe, mes compétences et talents propres sont appréciés et employés",
      question_pt_br: "Ao trablhar com membros deste time meus talentos e habilidades únicas são valorizadas e utilizadas",
      question_type: :likert
    }
  ]

  SEED_TM_QUESTIONS = [
    {
      id: "30ebedf9-20c0-43af-9669-be136f283af9",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM01",
      question_en: "I continue to work at my current job because the work itself is fun to do",
      question_fr: "Je continue de travailler ici car le travail lui-même est gratifiant",
      question_pt_br: "Eu continuo a trabalhar nesta atividade porque o trabalho é divertido",
      question_type: :likert
    },
    {
      id: "1179405e-c064-47ef-833b-1cc3cae92cb6",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM02",
      question_en: "I continue to work at my current job because I believe this work has an important purpose",
      question_fr: "Je continue de travailler ici car l'objectif de ce travail a une grande importance pour moi",
      question_pt_br: "Eu continuo a trabalhar aqui pois meu trabalho tem um propósito importante",
      question_type: :likert
    },
    {
      id: "ed84783d-22c4-4257-81f4-f3e3a8377585",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM03",
      question_en: "I continue to work at my current job because this type of work will help me to reach my personal goals",
      question_fr: "Je continue à travailler ici car le travail est utile pour l'atteinte de mes objectifs personnels",
      question_pt_br: "Eu continuo a trabalhar aqui pois meu trabalho me ajuda a atingir meus objetivos pessoais",
      question_type: :likert
    },
    {
      id: "273d31d5-9200-449f-9880-39c9a46e578b",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM04",
      question_en: "I continue to work at my current job because if I didn’t, I would disappoint myself or people I care about",
      question_fr: "Je continue de travailler ici car si je le quittais, je me décevrais ou je décevrais des personnes qui me sont chères",
      question_pt_br: "Eu continuo a trabalhar aqui porque caso contrário, eu desapontaria a mim ou pessoas que valorizo",
      question_type: :likert
    },
    {
      id: "8b993a19-a266-450c-b19b-cdd6795792b0",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM05",
      question_en: "I continue to work at my current job because without this job, I would be worried I couldn’t meet my financial objectives",
      question_fr: "Je continue à travailler ici car sans ce travail, je serais inquiet pour mes objectifs financiers",
      question_pt_br: "Eu continuo a trabalhar aqui pois sem este trabalho, eu não atenderia meus objetivos financeiros",
      question_type: :likert
    },
    {
      id: "05503af9-4cf6-4375-9e72-88a7aa3bb867",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM06",
      question_en: "There is no good reason why I continue working at my current job",
      question_fr: "Il n'existe aucune bonne raison pour laquelle je continue à travailler ici",
      question_pt_br: "Não há boa razão para continuar no meu trabalho atual",
      question_type: :likert
    }
  ]
  SEED_GM_QUESTIONS = [
    {
      id: "cc74c4e0-2840-4eba-b0f1-4b6a4f525f52",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM01",
      question_en: "I don’t think I personally can do much to increase my intelligence.",
      question_fr: "Personnellement, je ne pense pas que je peux faire grand chose pour augmenter mon intelligence.",
      question_pt_br: "Eu pessoalmente não acredito que possa fazer muito para aumentar minha inteligência",
      question_type: :likert
    },
    {
      id: "6c09f8a1-5357-494c-aaa8-a35e553f2083",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM02",
      question_en: "I can learn new things, but I don’t have the ability to change my basic intelligence",
      question_fr: "Je peux acquérir de nouvelles connaissances, mais je n'ai pas la capacité de changer mon intelligence de départ",
      question_pt_br: "Eu posso aprender novas coisas, mas acredito não ter habilidade de mudar minha inteligência básica",
      question_type: :likert
    },
    {
      id: "41d5255e-40f2-4027-ae31-91718c95a0ac",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM03",
      question_en: "My intelligence is something about me that I personally can’t change very much",
      question_fr: "Mon intelligence est quelque chose en moi que je ne peux pas changer beaucoup",
      question_pt_br: "Minha inteligência é algo sobre mim que eu pessoalmente não consigo mudar muito",
      question_type: :likert
    },
    {
      id: "82d14e67-2f71-4e07-9eac-ca5fa3f5a823",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM04",
      question_en: "To be honest, I don’t think I can really change how intelligent I am",
      question_fr: "Pour être honnête, je ne pense pas que je peux vraiment changer l'efficacité de mon intelligence",
      question_pt_br: "Para ser honesto, eu não sei se posso mudar o meu grau de inteligencia",
      question_type: :likert
    },
    {
      id: "1598f462-56b4-4ba0-bed6-0ff85becc11e",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM05",
      question_en: "With enough time and effort I think I could significantly improve my intelligence level",
      question_fr: "Avec assez de temps et d'effort, je peux augmenter mon intelligence de façon significative",
      question_pt_br: "Com tempo e esforço eu acredito que possa melhorar meu nivel de inteligencia",
      question_type: :likert
    },
    {
      id: "fb9e5f44-2a09-4a86-bbc2-7b0a72c23c26",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM06",
      question_en: "I believe I can always substantially improve on my intelligence",
      question_fr: "Je pense qu'il est toujours possible pour moi d'augmenter mon intelligence",
      question_pt_br: "Eu acredito que sempre possa aumentar substancialmente minha inteligencia",
      question_type: :likert
    },
    {
      id: "95a91a15-369f-47c2-9b5c-c69d321a3358",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM07",
      question_en: "Regardless of my current intelligence level, I think I have the capacity to change it quite a bit",
      question_fr: "Peu importe mon degré d'intelligence, j'ai la capacité de l'augmenter de façon significative",
      question_pt_br: "Apesar do meu nivel atual de inteligência, eu acredito que tenha capacidade de mudar um pouco.",
      question_type: :likert
    },
    {
      id: "f9c2ca5f-9614-4348-8640-e30c1f627588",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM08",
      question_en: "I believe I have the ability to change my basic intelligence level considerably over time",
      question_fr: "Je crois que j'ai la capacité d'augmenter considérablement mon intelligence avec le temps",
      question_pt_br: "Eu acredito que tenho a abilidade de mudar o meu nível básico de inteligência de forma considerável ao longo do tempo.",
      question_type: :likert
    }
  ]

  def self.add_likert(question)
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

  def self.create_survey
    Survey.create! SEED_SURVEY
    Survey::Group.create! SEED_PS_GROUP
    SEED_PS_QUESTIONS.each do |data|
      q = Survey::Question.create! data
      add_likert(q)
    end

    Survey::Group.create! SEED_TM_GROUP
    SEED_TM_QUESTIONS.each do |data|
      q = Survey::Question.create! data
      add_likert(q)
    end

    Survey::Group.create! SEED_GM_GROUP
    SEED_GM_QUESTIONS.each do |data|
      q = Survey::Question.create! data
      add_likert(q)
    end
  end

  def self.update_survey
    s = Survey.first
    s.update! SEED_SURVEY

    g = Survey::Group.find SEED_PS_GROUP[:id]
    g.update! SEED_PS_GROUP
    SEED_PS_QUESTIONS.each do |data|
      q = Survey::Question.find data[:id]
      q.update! data
    end

    g = Survey::Group.find SEED_TM_GROUP[:id]
    g.update! SEED_TM_GROUP
    SEED_TM_QUESTIONS.each do |data|
      q = Survey::Question.find data[:id]
      q.update! data
    end

    g = Survey::Group.find SEED_GM_GROUP[:id]
    g.update! SEED_GM_GROUP
    SEED_GM_QUESTIONS.each do |data|
      q = Survey::Question.find data[:id]
      q.update! data
    end
  end
end