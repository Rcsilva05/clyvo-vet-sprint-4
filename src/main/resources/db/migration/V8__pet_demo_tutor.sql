-- Vincula um pet de demonstração à conta genérica de tutor criada na V4.
-- O tutor de demonstração era criado sem pets, então o formulário de
-- eventos aparecia sem opções ao entrar com tutor.demo@solin.com.
-- A migration é aditiva e preserva todos os dados existentes.
INSERT INTO TB_PET (NM_PET, DS_RACA, DT_NASCIMENTO, VL_PESO_KG, TP_SEXO, ID_TUTOR, ID_ESPECIE)
SELECT 'Luna',
       'Vira-lata',
       DATE '2022-01-01',
       12.0,
       'FEMEA',
       tutor.ID_TUTOR,
       especie.ID_ESPECIE
FROM TB_TUTOR tutor
JOIN TB_ESPECIE especie ON especie.NM_ESPECIE = 'Cachorro'
WHERE tutor.DS_EMAIL = 'tutor.demo@solin.com'
  AND NOT EXISTS (
      SELECT 1
      FROM TB_PET pet
      WHERE pet.ID_TUTOR = tutor.ID_TUTOR
        AND pet.NM_PET = 'Luna'
  );
