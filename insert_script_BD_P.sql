---- Script de inserare date de test - Vinted

---- 1. Inserare utilizatori 
INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('maria_ionescu', 'romania', 'parola123', TO_DATE('1995-05-15', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('ion_popescu', 'romania', 'securitate456', TO_DATE('1988-11-20', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('ana_marinescu', 'romania', 'password789', TO_DATE('2000-03-08', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('gheorghe_dumitrescu', 'romania', 'gheorghe2024', TO_DATE('1992-07-25', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('elena_radu', 'romania', 'elenasecure', TO_DATE('1998-12-30', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('victor_stan', 'ungaria', 'victorpass', TO_DATE('1990-04-18', 'YYYY-MM-DD'));

INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii) 
    VALUES ('cristina_marin', 'germania', 'cristina999', TO_DATE('1985-09-05', 'YYYY-MM-DD'));


---- 2. Inserare categorii 

-- Categorii principale (ID 1-5)
INSERT INTO categorie (denumire, id_parinte) VALUES ('Imbracaminte', NULL);
INSERT INTO categorie (denumire, id_parinte) VALUES ('Electrocasnice', NULL);
INSERT INTO categorie (denumire, id_parinte) VALUES ('Accesorii', NULL);
INSERT INTO categorie (denumire, id_parinte) VALUES ('Jucarii', NULL);
INSERT INTO categorie (denumire, id_parinte) VALUES ('Decor', NULL);

-- Subcategorii (folosim direct ID-ul parintelui de mai sus)
INSERT INTO categorie (denumire, id_parinte) 
    VALUES ('Tricouri', 1);

INSERT INTO categorie (denumire, id_parinte) 
    VALUES ('Pantaloni', 1);

INSERT INTO categorie (denumire, id_parinte) 
    VALUES ('Genti', 3);

INSERT INTO categorie (denumire, id_parinte) 
    VALUES ('Ceasuri', 3);

INSERT INTO categorie (denumire, id_parinte) 
    VALUES ('Vaze', 5);


---- 3. Inserare produse

-- Tricou (Prod 1) - Categorie 6 (Tricouri), User 1 (Maria)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Tricou Nike Original Marimea M', 'Tricou alb din bumbac, purtat de cateva ori', 'foarte_buna', 'activ', 6, 1);

-- Geanta (Prod 2) - Categorie 8 (Genti), User 2 (Ion)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Geanta de Piele Naturala', 'Geanta maro, stil vintage, are semne uzura', 'acceptabila', 'activ', 8, 2);

-- Ceas (Prod 3) - Categorie 9 (Ceasuri), User 3 (Ana)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Ceas Casio Digital', NULL, 'nou', 'activ', 9, 3);

-- Blugi (Prod 4) - Categorie 7 (Pantaloni), User 4 (Gheorghe)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Blugi Levis 501 Marimea 32', 'Blugi clasici, stati bine pe corp', 'buna', 'activ', 7, 4);

-- Vaza (Prod 5) - Categorie 10 (Vaze), User 5 (Elena)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Vaza Ceramica Handmade', 'Vaza alba cu desene florale, 30cm inaltime', 'foarte_buna', 'activ', 10, 5);

-- Lego (Prod 6) - Categorie 4 (Jucarii), User 6 (Victor)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Jucarie Lego Star Wars Set Complet', 'Set complet cu cutia originala si instructiuni', 'buna', 'activ', 4, 6);

-- Mixer (Prod 7) - Categorie 2 (Electrocasnice), User 7 (Cristina)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Mixer de Bucatarie Philips', 'Folosit doar de cateva ori, functie turbo', 'foarte_buna', 'activ', 2, 7);

-- Rochie (Prod 8) - Categorie 1 (Imbracaminte), User 1 (Maria)
INSERT INTO produs (titlu_produs, descriere, stare, status, id_categorie, id_utilizator_vanzator)
    VALUES ('Rochie de Seara Eleganta', 'Rochie neagra, marimea S, purtata o singura data', 'foarte_buna', 'activ', 1, 1);


---- 4. Inserare preturi

-- Tricou Nike (Prod 1)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 5, 150.00, 1);
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 2, 120.00, 1);

-- Geanta piele (Prod 2)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 7, 300.00, 2);
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 3, 280.00, 2);

-- Ceas Casio (Prod 3)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 10, 250.00, 3);

-- Blugi Levis (Prod 4)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 15, 200.00, 4);
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 12, 180.00, 4);

-- Vaza ceramica (Prod 5)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 8, 100.00, 5);

-- Lego (Prod 6)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 6, 450.00, 6);

-- Mixer (Prod 7)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 4, 180.00, 7);

-- Rochie (Prod 8)
INSERT INTO istoric_pret (data_inregistrare, pret, id_produs)
    VALUES (SYSDATE - 1, 350.00, 8);


---- 5. INSERARE MESAJE 

-- Conversatie Tricou: Ana(3) <-> Maria(1)
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Buna ziua! Sunt interesata de tricou. Acceptati 100 lei?', 3, 1);

INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Buna! Pretul minim este 120 lei. Ce spuneti?', 1, 3);

-- Conversatie Geanta: Gheorghe(4) <-> Ion(2)
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Buna! Geanta este din piele naturala 100%?', 4, 2);

INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Da, este piele naturala. Am cumparat-o din Italia.', 2, 4);

-- Conversatie Blugi: Elena(5) <-> Gheorghe(4)
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Buna! Oferta 160 lei pentru blugi. Urgent mi-i trebuie!', 5, 4);

INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Imi pare rau, pretul este fix 180 lei.', 4, 5);

-- Conversatie Mixer: Maria(1) <-> Cristina(7)
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Se poate livra in Romania? Sunt din Iasi.', 1, 7);

INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
    VALUES ('Desigur! Livrez in toata Romania prin curier.', 7, 1);


---- 6. Inserare comenzi

-- Comanda 1 - Tricou (Prod 1) - Cumparator Ana (3)
INSERT INTO comanda (status, pret_transport, status_plata, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
    VALUES ('livrat', 25, 'finalizat', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-05', 'YYYY-MM-DD'), 1, 3);

-- Comanda 2 - Geanta (Prod 2) - Cumparator Gheorghe (4)
INSERT INTO comanda (status, pret_transport, status_plata, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
    VALUES ('expediat', 25, 'efectuat', TO_DATE('2024-10-15', 'YYYY-MM-DD'), NULL, 2, 4);

-- Comanda 3 - Ceas (Prod 3) - Cumparator Victor (6)
INSERT INTO comanda (status, pret_transport, status_plata, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
    VALUES ('confirmat', 25, 'efectuat', TO_DATE('2024-11-01', 'YYYY-MM-DD'), NULL, 3, 6);

-- Comanda 4 - Blugi (Prod 4) - Cumparator Elena (5)
INSERT INTO comanda (status, pret_transport, status_plata, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
    VALUES ('livrat', 25, 'finalizat', TO_DATE('2024-09-20', 'YYYY-MM-DD'), TO_DATE('2024-09-24', 'YYYY-MM-DD'), 4, 5);

-- Comanda 5 - Vaza (Prod 5) - Cumparator Ion (2)
INSERT INTO comanda (status, pret_transport, status_plata, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
    VALUES ('livrat', 25, 'finalizat', TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-10-14', 'YYYY-MM-DD'), 5, 2);


---- 7. Inserare feedback

-- Feedback comanda Tricou (Comanda 1)
INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (5.0, 'Produs exact ca in descriere! Livrare rapida. Recomand!', 1, 3, 1);

INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (4.5, 'Cumparator serios, plata prompta. Multumesc!', 1, 1, 3);

-- Feedback comanda Blugi (Comanda 4)
INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (4.0, 'Blugii sunt ok, dar aveau o mica pata care nu era mentionata.', 4, 5, 4);

INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (5.0, 'Cumparator foarte amabil! Recomand cu incredere.', 4, 4, 5);

-- Feedback comanda Vaza (Comanda 5)
INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (5.0, 'Vaza superba! Exact cat de frumoasa arata in poze. Multumesc!', 5, 2, 5);

INSERT INTO feedback (nota, justificare, id_comanda, id_utilizator_creator, id_utilizator_primitor)
    VALUES (4.5, 'Totul perfect! Comunicare excelenta.', 5, 5, 2);