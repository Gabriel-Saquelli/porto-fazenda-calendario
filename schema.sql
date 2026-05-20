-- ============================================================
-- Calendário Estratégico — Porto Fazenda Hotel
-- Rodar no Supabase: SQL Editor → New query → Cole e execute
-- ============================================================

-- TABELA: feriados
CREATE TABLE IF NOT EXISTS public.feriados (
  id          uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  name        text        NOT NULL,
  sub         text,
  event_date  date        NOT NULL,
  date_label  text,
  type        text        NOT NULL DEFAULT 'nacional',
  ponte       text,
  ponte_ok    boolean     DEFAULT false,
  stars       int         DEFAULT 2 CHECK (stars BETWEEN 1 AND 3),
  emoji       text        DEFAULT '📅',
  notes       text,
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now()
);

-- TABELA: cidades
CREATE TABLE IF NOT EXISTS public.cidades (
  id          uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  city        text        NOT NULL,
  uf          text        NOT NULL,
  pop         text,
  role        text,
  event_date  date        NOT NULL,
  date_label  text,
  notes       text,
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now()
);

-- ============================================================
-- SEGURANÇA — RLS com políticas abertas (sem autenticação por ora)
-- ============================================================
ALTER TABLE public.feriados ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cidades  ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_all_feriados" ON public.feriados
  FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "public_all_cidades" ON public.cidades
  FOR ALL TO anon USING (true) WITH CHECK (true);

-- ============================================================
-- DADOS: FERIADOS (17 itens)
-- ============================================================
INSERT INTO public.feriados (name, sub, event_date, date_label, type, ponte, ponte_ok, stars, emoji) VALUES
('Páscoa',                   'Sexta Santa + Domingo de Páscoa',                          '2026-04-03', '03–05 Abr', 'nacional',     '3 dias',               true,  3, '🐣'),
('Tiradentes',               'P. facultativo na seg. — feriadão de 4 dias',               '2026-04-20', '20–21 Abr', 'nacional',     '4 dias',               true,  3, '⚖️'),
('Dia do Trabalho',          'Cai na sexta — feriadão natural de 3 dias',                 '2026-05-01', '01–03 Mai', 'nacional',     '3 dias',               true,  2, '⚙️'),
('Dia das Mães',             '2ª maior data do varejo — pacotes especiais',               '2026-05-10', '10 Mai',   'comemorativa', '—',                    false, 3, '🌷'),
('Corpus Christi',           'Feriado municipal Alfenas + ponto facultativo federal',     '2026-06-04', '04–07 Jun', 'municipal',    '4 dias (qui–dom)',     true,  3, '✝️'),
('Dia dos Namorados',        'Cai na sexta — fim de semana romântico',                    '2026-06-12', '12–14 Jun', 'comemorativa', '3 dias',               true,  2, '💑'),
('Festas Juninas + Copa',    'São João (24/06) + jogos do Brasil na Copa do Mundo',       '2026-06-13', '13–24 Jun', 'comemorativa', 'Múltiplos fins de sem.', true, 3, '🎪'),
('Férias de Julho + 9 Jul SP','Feriado estadual SP (qui) em plenas férias escolares',    '2026-07-07', '07–23 Jul', 'estadual',     '4 dias + férias esc.', true,  3, '🏖️'),
('Dia dos Pais',             'Pacotes aventura, pescaria, churrasco',                     '2026-08-09', '09 Ago',   'comemorativa', 'Fim de semana',        false, 2, '🎣'),
('Independência do Brasil',  'Feriado na segunda — feriadão de 3 dias',                   '2026-09-05', '05–07 Set', 'nacional',     '3 dias',               true,  2, '🇧🇷'),
('N. Sra. Aparecida / Crianças','Feriado na seg. — demanda familiar máxima',             '2026-10-10', '10–12 Out', 'nacional',     '3 dias',               true,  3, '🎡'),
('Finados',                  'Feriado na segunda — feriadão de 3 dias',                   '2026-10-31', '31 Out–02 Nov','nacional',   '3 dias',               true,  1, '🕯️'),
('Proclamação da República', 'Cai no domingo — único feriado sem ponte em 2026',          '2026-11-15', '15 Nov',   'nacional',     'Sem ponte',            false, 1, '🏛️'),
('Consciência Negra',        'Feriado nacional desde 2024 — 3 dias',                      '2026-11-20', '20–22 Nov', 'nacional',     '3 dias',               true,  2, '✊'),
('Black Friday',             'Venda antecipada: Natal, Réveillon, verão',                 '2026-11-27', '27 Nov',   'comemorativa', '—',                    false, 2, '🏷️'),
('Natal',                    'Feriado na sexta + véspera facultativa (qui)',               '2026-12-24', '24–27 Dez', 'nacional',     '4 dias',               true,  3, '🎄'),
('Réveillon',                'Megaponte qui tarde + 01/01/2027 (sexta)',                   '2026-12-31', '31 Dez–04 Jan','comemorativa','4+ dias',            true,  3, '🎆');

-- ============================================================
-- DADOS: CIDADES ÂNCORA (49 cidades)
-- ============================================================
INSERT INTO public.cidades (city, uf, pop, role, event_date, date_label) VALUES
('Poços de Caldas',          'MG', '169k',  'Âncora Sul MG',         '2026-11-06', '06 Nov'),
('Varginha',                 'MG', '137k',  'Âncora Sul MG',         '2026-10-07', '07 Out'),
('Pouso Alegre',             'MG', '156k',  'Âncora Sul MG',         '2026-10-19', '19 Out'),
('Alfenas',                  'MG', '82k',   'Município sede',         '2026-10-15', '15 Out'),
('Três Corações',            'MG', '81k',   'Sul de Minas',           '2026-03-21', '21 Mar'),
('Três Pontas',              'MG', '57k',   'Sul de Minas',           '2026-07-03', '03 Jul'),
('Lavras',                   'MG', '106k',  'Sul de Minas',           '2026-10-06', '06 Out'),
('Passos',                   'MG', '115k',  'Sul de Minas',           '2026-05-14', '14 Mai'),
('Itajubá',                  'MG', '97k',   'Sul de Minas',           '2026-03-19', '19 Mar'),
('Campinas',                 'SP', '1,2M',  'Âncora Campinas',        '2026-07-14', '14 Jul'),
('Jundiaí',                  'SP', '430k',  'Campinas e Região',      '2026-12-14', '14 Dez'),
('Piracicaba',               'SP', '441k',  'Campinas e Região',      '2026-08-01', '01 Ago'),
('Sorocaba',                 'SP', '265k',  'Campinas / SP',          '2026-08-15', '15 Ago'),
('Americana',                'SP', '247k',  'Campinas e Região',      '2026-08-27', '27 Ago'),
('Limeira',                  'SP', '301k',  'Campinas e Região',      '2026-09-15', '15 Set'),
('Valinhos',                 'SP', '132k',  'Campinas e Região',      '2026-05-28', '28 Mai'),
('Ribeirão Preto',           'SP', '720k',  'Âncora Ribeirão',        '2026-06-19', '19 Jun'),
('Franca',                   'SP', '364k',  'Ribeirão Preto',         '2026-11-28', '28 Nov'),
('Barretos',                 'SP', '120k',  'Ribeirão Preto',         '2026-08-25', '25 Ago'),
('São Joaquim da Barra',     'SP', '49k',   'Ribeirão Preto',         '2026-05-30', '30 Mai'),
('Mococa',                   'SP', '69k',   'Ribeirão Preto',         '2026-04-05', '05 Abr'),
('Orlândia',                 'SP', '43k',   'Ribeirão Preto',         '2026-03-06', '06 Mar'),
('São Paulo',                'SP', '11,5M', 'Âncora GSP',             '2026-01-25', '25 Jan'),
('Guarulhos',                'SP', '1,4M',  'Grande SP',              '2026-12-08', '08 Dez'),
('Osasco',                   'SP', '759k',  'Grande SP',              '2026-02-19', '19 Fev'),
('São Bernardo do Campo',    'SP', '851k',  'Grande SP',              '2026-04-08', '08 Abr'),
('Santo André',              'SP', '749k',  'Grande SP',              '2026-04-08', '08 Abr'),
('São José dos Campos',      'SP', '729k',  'Vale do Paraíba',        '2026-07-27', '27 Jul'),
('Taubaté',                  'SP', '317k',  'Vale do Paraíba',        '2026-12-05', '05 Dez'),
('Jacareí',                  'SP', '240k',  'Vale do Paraíba',        '2026-04-03', '03 Abr'),
('Campos do Jordão',         'SP', '47k',   'Mantiqueira',            '2026-04-29', '29 Abr'),
('Guaratinguetá',            'SP', '118k',  'Vale do Paraíba',        '2026-06-13', '13 Jun'),
('São João da Boa Vista',    'SP', '96k',   'Mogiana Paulista',       '2026-06-24', '24 Jun'),
('Paulínia',                 'SP', '117k',  'Campinas e Região',      '2026-02-28', '28 Fev'),
('Altinópolis',              'SP', '17k',   'Ribeirão Preto',         '2026-03-09', '09 Mar'),
('Cachoeira Paulista',       'SP', '29k',   'Vale do Paraíba',        '2026-03-09', '09 Mar'),
('Ouro Fino',                'MG', '33k',   'Sul de Minas',           '2026-03-16', '16 Mar'),
('Ribeirão Pires',           'SP', '124k',  'Grande São Paulo',       '2026-03-19', '19 Mar'),
('Cravinhos',                'SP', '34k',   'Ribeirão Preto',         '2026-03-19', '19 Mar'),
('Lindóia',                  'SP', '7k',    'Circuito das Águas',     '2026-03-21', '21 Mar'),
('Louveira',                 'SP', '54k',   'Campinas e Região',      '2026-03-21', '21 Mar'),
('Ipeúna',                   'SP', '7k',    'Eixo Anhanguera',        '2026-03-21', '21 Mar'),
('Araras',                   'SP', '131k',  'Eixo Anhanguera',        '2026-03-24', '24 Mar'),
('Caldas',                   'MG', '14k',   'Sul de Minas',           '2026-03-27', '27 Mar'),
('Mairiporã',                'SP', '94k',   'Fernão Dias',            '2026-03-27', '27 Mar'),
('Matão',                    'SP', '79k',   'Eixo Anhanguera',        '2026-03-28', '28 Mar'),
('Artur Nogueira',           'SP', '55k',   'Campinas e Região',      '2026-04-10', '10 Abr'),
('Serrana',                  'SP', '43k',   'Ribeirão Preto',         '2026-04-10', '10 Abr'),
('Caçapava',                 'SP', '100k',  'Vale do Paraíba',        '2026-04-14', '14 Abr'),
('Baependi',                 'MG', '20k',   'Sul de Minas',           '2026-05-02', '02 Mai'),
('Itapecerica da Serra',     'SP', '159k',  'Grande São Paulo',       '2026-05-08', '08 Mai'),
('Santa Rita do Passa Quatro','SP','26k',   'Eixo Anhanguera',        '2026-05-22', '22 Mai'),
('Igarapava',                'SP', '27k',   'Ribeirão Preto',         '2026-05-22', '22 Mai'),
('Guaxupé',                  'MG', '19k',   'Sul de Minas',           '2026-06-01', '01 Jun'),
('Santo Antônio do Pinhal',  'SP', '7k',    'Mantiqueira',            '2026-06-13', '13 Jun'),
('Monte Santo de Minas',     'MG', '21k',   'Sul de Minas',           '2026-06-26', '26 Jun'),
('Águas de Lindóia',         'SP', '18k',   'Circuito das Águas',     '2026-07-02', '02 Jul'),
('Águas da Prata',           'SP', '8k',    'Mogiana Paulista',       '2026-07-03', '03 Jul'),
('Pindamonhangaba',          'SP', '165k',  'Vale do Paraíba',        '2026-07-10', '10 Jul'),
('Jardinópolis',             'SP', '45k',   'Ribeirão Preto',         '2026-07-27', '27 Jul'),
('Tremembé',                 'SP', '51k',   'Vale do Paraíba',        '2026-08-01', '01 Ago'),
('Araraquara',               'SP', '242k',  'Eixo Anhanguera',        '2026-08-21', '21 Ago'),
('Leme',                     'SP', '101k',  'Eixo Anhanguera',        '2026-08-29', '29 Ago'),
('Guará',                    'SP', '19k',   'Ribeirão Preto',         '2026-09-07', '07 Set'),
('Itaú de Minas',            'MG', '14k',   'Sul de Minas',           '2026-09-11', '11 Set'),
('Serra Negra',              'SP', '31k',   'Circuito das Águas',     '2026-09-23', '23 Set'),
('Campanha',                 'MG', '16k',   'Sul de Minas',           '2026-10-02', '02 Out'),
('Cruzeiro',                 'SP', '75k',   'Vale do Paraíba',        '2026-10-03', '03 Out'),
('Bragança Paulista',        'SP', '186k',  'Fernão Dias',            '2026-10-24', '24 Out'),
('Holambra',                 'SP', '15k',   'Campinas e Região',      '2026-10-27', '27 Out'),
('Cabo Verde',               'MG', '12k',   'Sul de Minas',           '2026-10-30', '30 Out'),
('Pedreira',                 'SP', '44k',   'Circuito das Águas',     '2026-10-31', '31 Out'),
('Santana de Parnaíba',      'SP', '154k',  'Grande São Paulo',       '2026-11-14', '14 Nov'),
('Lorena',                   'SP', '87k',   'Vale do Paraíba',        '2026-11-14', '14 Nov'),
('Muzambinho',               'MG', '22k',   'Sul de Minas',           '2026-11-30', '30 Nov'),
('Cosmópolis',               'SP', '61k',   'Campinas e Região',      '2026-11-30', '30 Nov'),
('Franco da Rocha',          'SP', '145k',  'Grande SP (Norte)',      '2026-11-30', '30 Nov'),
('Santa Bárbara d''Oeste',   'SP', '183k',  'Campinas e Região',      '2026-12-04', '04 Dez'),
('Sertãozinho',              'SP', '132k',  'Ribeirão Preto',         '2026-12-05', '05 Dez'),
('Suzano',                   'SP', '320k',  'Grande SP (Leste)',      '2026-12-11', '11 Dez'),
('Ilicínea',                 'MG', '13k',   'Sul de Minas',           '2026-12-12', '12 Dez'),
('Caieiras',                 'SP', '95k',   'Grande SP (Norte)',      '2026-12-14', '14 Dez');
