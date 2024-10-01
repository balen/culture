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

  SEED_SURVEY2 = {
    id: "9a4fc3e9-288e-458c-ae42-57f7895991f8",
    name_en: "Better Understand My Organizational Culture (sans GM)",
    name_fr: "Mieux Comprendre Ma Culture Organisationnelle (sans GM)",
    name_pt_br: "Entender melhor minha cultura organizacional (sans GM)"
  }

  SEED_PS_GROUP = {
    id: "e93e88e8-f956-4595-a6f3-251f94d70941",
    short_code: "PS",
    name_en: "Psychological Safety",
    name_fr: "Sécurité psychologique",
    name_pt_br: "Segurança psicológica"    
  }

  SEED_TM_GROUP = {    
    id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
    short_code: "TM",
    name_en: "Total Motivation",
    name_fr: "Motivation totale",
    name_pt_br: "Motivação total",
  }

  SEED_P2T_GROUP = {
    id: "72acdcff-2324-455a-acd0-7ccc418492a4",
    short_code: "P2T",
    name_en: "Propensity to Trust",
    name_fr: "Propension à la confiance",
    name_pt_br: "Propensão a confiar"
  }
  SEED_PTW_GROUP = {
    id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
    short_code: "PTW",
    name_en: "Perceived Trustworthiness",
    name_fr: "Perception de fiabilité",
    name_pt_br: "Percepção de confiabilidade"
  }
  SEED_CB_GROUP = {
    id: "ec30265e-1939-4f6c-a760-7753de0732f9",
    short_code: "CB",
    name_en: "Cooperative Behaviours",
    name_fr: "Comportements coopératifs",
    name_pt_br: "Comportamentos cooperativos"
  }
 SEED_MB_GROUP = {
   id: "33fe464c-6797-436b-91dc-5254a0220fbf",
   short_code: "MB",
   name_en: "Monitoring Behaviours",
   name_fr: "Comportements de surveillance",
   name_pt_br: "Monitoramento de comportamentos"
 }

  SEED_GM_GROUP = {    
    id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
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
      question_pt_br: "Se você comete um erro neste time, isso será frequentemente jogado contra você",
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
      question_en: "I continue to work at my current job because if I didn't, I would disappoint myself or people I care about",
      question_fr: "Je continue de travailler ici car si je le quittais, je me décevrais ou je décevrais des personnes qui me sont chères",
      question_pt_br: "Eu continuo a trabalhar aqui porque caso contrário, eu desapontaria a mim ou pessoas que valorizo",
      question_type: :likert
    },
    {
      id: "8b993a19-a266-450c-b19b-cdd6795792b0",
      group_id: "c57ffd76-bd0b-4b27-9294-3393cd8600e7",
      short_code: "TM05",
      question_en: "I continue to work at my current job because without this job, I would be worried I couldn't meet my financial objectives",
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
  
  SEED_P2T_QUESTIONS = [
    {
      id: "5d217c4e-281b-44dd-b04d-c5609d01b502",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T1",
      question_en: "Most people in this team do not hesitate to help a person in need",
      question_fr: "La plupart des membres de cette équipe n'hésitent pas à aider une personne dans le besoin",
      question_pt_br: "A maioria das pessoas dessa equipe não hesita em ajudar uma pessoa necessitada",
      question_type: :likert
    },
    {
      id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T2",
      question_en: "In this team most people speak out for what they believe in",
      question_fr: "Dans cette équipe, la plupart des gens s'expriment pour ce en quoi ils croient",
      question_pt_br: "Nesta equipe, a maioria das pessoas fala sobre o que acredita",
      question_type: :likert
    },
    {
      id: "33fe464c-6797-436b-91dc-5254a0220fbf",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T3",
      question_en: "In this team most people stand behind their convictions",
      question_fr: "Dans cette équipe, la plupart des gens soutiennent leurs convictions",
      question_pt_br: "Nesta equipe, a maioria das pessoas mantém suas convicções",
      question_type: :likert
    },
    {
      id: "9ddd9d93-6364-487b-90b1-f4dcf67425b7",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T4",
      question_en: "The typical person in this team is sincerely concerned about the problems of others",
      question_fr: "La personne typique dans cette équipe se soucie sincèrement des problèmes des autres",
      question_pt_br: "A pessoa típica nesta equipe se preocupa sinceramente com os problemas dos outros",
      question_type: :likert
    },
    {
      id: "de24accc-8e4a-4ef3-aafe-0c15b505b1c6",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T5",
      question_en: "Most people will act as 'Good Samaritans' if given the opportunity",
      question_fr: "La plupart des gens agiront comme des 'bons samaritains' si l'occasion se présente",
      question_pt_br: "A maioria das pessoas agirá como 'bons samaritanos' se tiverem a oportunidade",
      question_type: :likert
    },
    {
      id: "acf5716e-e7bf-4cf0-a92d-7e0e39e70e37",
      group_id: "72acdcff-2324-455a-acd0-7ccc418492a4",
      short_code: "P2T6",
      question_en: "People usually tell the truth, even when they know they will be better off by lying",
      question_fr: "Les gens disent habituellement la vérité, même lorsqu'ils savent qu'ils seraient mieux en mentant",
      question_pt_br: "As pessoas geralmente dizem a verdade, mesmo quando sabem que se sairiam melhor mentindo",
      question_type: :likert
    }
  ]
  SEED_PTW_QUESTIONS = [
    {
      id: "336e0ff8-fdfd-4e60-9807-f900cb43dc0a",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW1",
      question_en: "In this team people can rely on each other",
      question_fr: "Dans cette équipe, les gens peuvent compter les uns sur les autres",
      question_pt_br: "Nessa equipe, as pessoas podem confiar umas nas outras",
      question_type: :likert
    },
    {
      id: "879cf988-3d5d-4877-93b4-73bc1ebee066",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW2",
      question_en: "We have complete confidence in each other’s ability to perform tasks",
      question_fr: "Nous avons une confiance totale dans la capacité des uns et des autres à accomplir les tâches",
      question_pt_br: "Temos total confiança na capacidade de cada um de realizar tarefas",
      question_type: :likert
    },
    {
      id: "c7d03405-c4af-4fa9-b9b8-af6c80164e03",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW3",
      question_en: "In this team people will keep their word",
      question_fr: "Dans cette équipe, les gens tiennent leur parole",
      question_pt_br: "Nesta equipe, as pessoas manterão sua palavra",
      question_type: :likert
    },
    {
      id: "2a0942cb-e5f8-4cb9-8736-42d8e81296ed",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW4",
      question_en: "There are some hidden agendas in this team.",
      question_fr: "Il y a des intentions cachées dans cette équipe",
      question_pt_br: "Há algumas agendas ocultas nesta equipe",
      question_type: :likert
    },
    {
      id: "91ffd9ee-a3a6-4c65-97d5-657a49848f74",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW5",
      question_en: "Some people in this team often try to get out of previous commitments",
      question_fr: "Certaines personnes de cette équipe essaient souvent de se soustraire à des engagements antérieurs",
      question_pt_br: "Algumas pessoas desta equipe frequentemente tentam se livrar de compromissos anteriores",
      question_type: :likert
    },
    {
      id: "47388575-6a39-4814-aac6-6aad71fe3e94",
      group_id: "7a1ba9b2-6fd5-49dd-8a66-7b7ff464a286",
      short_code: "PTW6",
      question_en: "In this team people look for each other’s interests honestly",
      question_fr: "Dans cette équipe, les gens cherchent honnêtement à défendre les intérêts des autres",
      question_pt_br: "Nesta equipe, as pessoas buscam honestamente os interesses umas das outras",
      question_type: :likert
    }
  ]
  SEED_CB_QUESTIONS = [
    {
      id: "f04493c7-0c2b-4b09-b02f-6591291e3b86",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB01",
      question_en: "In this team we work in a climate of cooperation",
      question_fr: "Dans cette équipe, nous travaillons dans un climat de coopération",
      question_pt_br: "Nesta equipe, trabalhamos em um clima de cooperação",
      question_type: :likert
    },
    {
      id: "ba16ad72-f720-438c-ab9b-4799694fc058",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB02",
      question_en: "In this team we discuss and deal with issues or problems openly",
      question_fr: "Dans cette équipe, nous discutons et traitons les questions ou les problèmes ouvertement",
      question_pt_br: "Nesta equipe, discutimos e lidamos com questões ou problemas abertamente",
      question_type: :likert
    },
    {
      id: "a3b577d9-6822-4449-8bf7-79404c358887",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB03",
      question_en: "While taking a decision we take each other’s opinion into consideration",
      question_fr: "Lorsque nous prenons une décision, nous tenons compte de l'avis de chacun",
      question_pt_br: "Ao tomarmos uma decisão, levamos em consideração a opinião uns dos outros",
      question_type: :likert
    },
    {
      id: "1780d640-05ca-40d9-88c5-7e21c468fb77",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB04",
      question_en: "Some people hold back relevant information in this team",
      question_fr: "Dans cette équipe, certaines personnes cachent des informations importantes",
      question_pt_br: "Algumas pessoas retêm informações relevantes nesta equipe",
      question_type: :likert
    },
    {
      id: "a1e58529-9d76-4b36-8468-bb3a4496b37c",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB05",
      question_en: "In this team people minimize what they tell about themselves",
      question_fr: "Dans cette équipe, les gens minimisent ce qu'ils disent d'eux-mêmes",
      question_pt_br: "Nesta equipe, as pessoas minimizam o que dizem sobre si mesmas",
      question_type: :likert
    },
    {
      id: "3b8fe548-49f5-4010-a747-cbd9fc388194",
      group_id: "ec30265e-1939-4f6c-a760-7753de0732f9",
      short_code: "CB06",
      question_en: "Most people in this team are open to advice and help from others",
      question_fr: "La plupart des membres de cette équipe sont ouverts aux conseils et à l'aide des autres",
      question_pt_br: "A maioria das pessoas desta equipe está aberta a conselhos e ajuda de outras pessoas",
      question_type: :likert
    }
  ]

  SEED_MB_QUESTIONS = [
   {
     id: "49e21a43-fc95-4ddd-8468-56d9f15807ea",
     group_id: "33fe464c-6797-436b-91dc-5254a0220fbf",
     short_code: "MB01",
     question_en: "In this team people watch each other very closely.",
     question_fr: "Dans cette équipe, les gens se surveillent de très près.",
     question_pt_br: "Nesta equipe, as pessoas observam umas às outras com muita atenção.",
     question_type: :likert
   },
   {
     id: "2820b0c6-5e77-42a7-b046-c6eaed9fa66e",
     group_id: "33fe464c-6797-436b-91dc-5254a0220fbf",
     short_code: "MB02",
     question_en: "In this team people check whether others keep their promises.",
     question_fr: "Dans cette équipe, les gens vérifient si les autres tiennent leurs promesses.",
     question_pt_br: "Nesta equipe, as pessoas verificam se os outros cumprem suas promessas.",
     question_type: :likert
   },
   {
     id: "b6bb1d77-3325-4ed6-875f-2032bed2905b",
     group_id: "33fe464c-6797-436b-91dc-5254a0220fbf",
     short_code: "MB03",
     question_en: "In this team most people tend to keep each other’s work under surveillance.",
     question_fr: "Dans cette équipe, la plupart des personnes ont tendance à surveiller le travail des autres.",
     question_pt_br: "Nesta equipe, a maioria das pessoas tende a manter o trabalho umas das outras sob vigilância.",
     question_type: :likert
   }
 ]

  SEED_GM_QUESTIONS = [
    {
      id: "cc74c4e0-2840-4eba-b0f1-4b6a4f525f52",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM01",
      question_en: "I don't think I personally can do much to increase my intelligence",
        question_fr: "Personnellement, je ne pense pas que je peux faire grand chose pour augmenter mon intelligence",
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
      question_en: "My intelligence is something about me that I personally can't change very much",
      question_fr: "Mon intelligence est quelque chose en moi que je ne peux pas changer beaucoup",
      question_pt_br: "Minha inteligência é algo sobre mim que eu pessoalmente não consigo mudar muito",
      question_type: :likert
    },
    {
      id: "82d14e67-2f71-4e07-9eac-ca5fa3f5a823",
      group_id: "fa2d2b55-2c45-4c8c-b2a0-039883c86d80",
      short_code: "GM04",
      question_en: "To be honest, I don't think I can really change how intelligent I am",
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
    # or update
    return if question.likert_setting
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

  def self.create_groups
    [
      SEED_PS_GROUP,
      SEED_TM_GROUP,
      SEED_P2T_GROUP,
      SEED_PTW_GROUP,
      SEED_CB_GROUP,
      SEED_GM_GROUP,
      SEED_MB_GROUP
    ].each do |data|
      create_or_update(model: Survey::Group, data: data)
    end

    [
      SEED_PS_QUESTIONS,
      SEED_TM_QUESTIONS,
      SEED_P2T_QUESTIONS,
      SEED_PTW_QUESTIONS,
      SEED_CB_QUESTIONS,
      SEED_GM_QUESTIONS,
      SEED_MB_QUESTIONS
    ].each do |questions|
      questions.each do |data|
        q = create_or_update(model: Survey::Question, data: data)
        add_likert(q)
      end
    end
  end

  def self.add_group(survey: , short_code:)
    group = Survey::Group.find_by short_code: short_code
    if group
      survey.groups << group unless survey.groups.exists?(group.id)
    end
  end

  def self.create_survey
    create_groups

    # survey = Survey.create! SEED_SURVEY
    survey = create_or_update(model: Survey, data: SEED_SURVEY)
    add_group(survey: survey, short_code: 'PS')
    add_group(survey: survey, short_code: 'TM')
    add_group(survey: survey, short_code: 'P2T')
    add_group(survey: survey, short_code: 'PTW')
    add_group(survey: survey, short_code: 'CB')
    add_group(survey: survey, short_code: 'GM')
    

    # survey = Survey.create! SEED_SURVEY2
    survey = create_or_update(model: Survey, data: SEED_SURVEY2)
    add_group(survey: survey, short_code: 'PS')
    add_group(survey: survey, short_code: 'TM')
    add_group(survey: survey, short_code: 'P2T')
    add_group(survey: survey, short_code: 'PTW')
    add_group(survey: survey, short_code: 'CB')
  end

  def self.create_or_update(model:, data:)
    instance = model.find_by id: data[:id]
    if instance
      instance.update! data
      instance
    else
      model.create! data
    end
  end
end