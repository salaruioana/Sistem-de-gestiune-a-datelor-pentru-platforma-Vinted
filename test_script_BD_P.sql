-- Script de testare - Vinted
-- 1. Vizualizari cu JOIN-uri
-- 2. Validari constrangeri (PK, NN, UK, CK, FK) si Triggere


----1: Vizualizari cu JOIN-uri


-- Afiseaza produsele active cu toate detaliile relevante pentru un cumparator
SELECT 
    p.titlu_produs "Produs",
    p.stare "Stare",
    hp.pret "Pret",
    c.denumire "Categorie",
    u.nume_utilizator "Vandut de"
FROM produs p
JOIN categorie c ON p.id_categorie = c.id_categorie
JOIN utilizator u ON p.id_utilizator_vanzator = u.id_utilizator
JOIN (
    SELECT id_produs, pret
    FROM istoric_pret ip1
    WHERE data_inregistrare = (
        SELECT MAX(data_inregistrare)
        FROM istoric_pret ip2
        WHERE ip2.id_produs = ip1.id_produs
    )
) hp ON p.id_produs = hp.id_produs
WHERE p.status = 'activ'
ORDER BY c.denumire, p.titlu_produs;


-- Afiseaza toate comenzile cu informatii despre produs, vanzator, cumparator si status
SELECT 
    co.id_comanda "Nr. Comanda",
    p.titlu_produs "Produs",
    u_vanzator.nume_utilizator "Vanzator",
    u_cumparator.nume_utilizator "Cumparator",
    co.status "Status Comanda",
    co.status_plata "Status Plata",
    TO_CHAR(co.data_plasarii, 'DD-MON-YYYY') "Data Plasare",
    TO_CHAR(co.data_livrare, 'DD-MON-YYYY') "Data Livrare",
    hp.pret + co.pret_transport "Total"
FROM comanda co
JOIN produs p ON co.id_produs = p.id_produs
JOIN utilizator u_vanzator ON p.id_utilizator_vanzator = u_vanzator.id_utilizator
JOIN utilizator u_cumparator ON co.id_utilizator_cumparator = u_cumparator.id_utilizator
JOIN (
    SELECT id_produs, pret
    FROM istoric_pret ip1
    WHERE data_inregistrare = (
        SELECT MAX(data_inregistrare)
        FROM istoric_pret ip2
        WHERE ip2.id_produs = ip1.id_produs
    )
) hp ON p.id_produs = hp.id_produs
ORDER BY co.data_plasarii DESC;


-- Afiseaza reputatia utilizatorilor bazata pe feedback-urile primite
SELECT 
    u_primitor.nume_utilizator "Utilizator",
    ROUND(AVG(f.nota), 2) "Nota medie",
    COUNT(f.id_feedback) "Numar reviewuri",
    u_primitor.tara "Tara"
FROM feedback f
JOIN utilizator u_primitor ON f.id_utilizator_primitor = u_primitor.id_utilizator
GROUP BY u_primitor.nume_utilizator, u_primitor.tara
ORDER BY AVG(f.nota) DESC;


-- Afiseaza cum s-a negociat pretul unui produs de-a lungul timpului
SELECT 
    p.titlu_produs "Produs",
    u.nume_utilizator "Vanzator",
    TO_CHAR(hp.data_inregistrare, 'DD-MON-YYYY HH24:MI') "Data modificare",
    hp.pret "Pret"
FROM istoric_pret hp
JOIN produs p ON hp.id_produs = p.id_produs
JOIN utilizator u ON p.id_utilizator_vanzator = u.id_utilizator
WHERE p.titlu_produs LIKE '%Tricou Nike%'
ORDER BY hp.data_inregistrare;

-- Afiseaza conversatiile dintre utilizatori
SELECT 
    u_trimite.nume_utilizator "De la",
    u_primeste.nume_utilizator "Catre",
    m.continut "Mesaj",
    TO_CHAR(m.ora, 'DD-MON-YYYY HH24:MI:SS') "Ora"
FROM mesaj m
JOIN utilizator u_trimite ON m.id_utilizator_trimite = u_trimite.id_utilizator
JOIN utilizator u_primeste ON m.id_utilizator_primeste = u_primeste.id_utilizator
ORDER BY m.ora;

-- Afiseaza structura de categorii si subcategorii
SELECT 
    c_parinte.denumire "Categorie Parinte",
    c_copil.denumire "Subcategorie",
    COUNT(p.id_produs) "Nr. Produse"
FROM categorie c_parinte
LEFT JOIN categorie c_copil ON c_parinte.id_categorie = c_copil.id_parinte
LEFT JOIN produs p ON c_copil.id_categorie = p.id_categorie
WHERE c_parinte.id_parinte IS NULL
GROUP BY c_parinte.denumire, c_copil.denumire
ORDER BY c_parinte.denumire, c_copil.denumire;


-- Afiseaza toate feedback-urile date pentru comenzi finalizate
SELECT 
    p.titlu_produs "Produs",
    u_creator.nume_utilizator "Reviewer",
    u_primitor.nume_utilizator "Reviewed",
    f.nota "Nota",
    f.justificare "Comentariu"
FROM feedback f
JOIN comanda co ON f.id_comanda = co.id_comanda
JOIN produs p ON co.id_produs = p.id_produs
JOIN utilizator u_creator ON f.id_utilizator_creator = u_creator.id_utilizator
JOIN utilizator u_primitor ON f.id_utilizator_primitor = u_primitor.id_utilizator
WHERE co.status = 'livrat'
ORDER BY f.nota DESC;


-- Afiseaza statistici despre vanzatori
SELECT 
    u.nume_utilizator "Vanzator",
    u.tara "Tara",
    COUNT(co.id_comanda) "Produse vandute",
    ROUND(AVG(f.nota), 2) "Rating mediu"
FROM utilizator u
JOIN produs p ON u.id_utilizator = p.id_utilizator_vanzator
JOIN comanda co ON p.id_produs = co.id_produs
LEFT JOIN feedback f ON co.id_comanda = f.id_comanda AND f.id_utilizator_primitor = u.id_utilizator
GROUP BY u.nume_utilizator, u.tara
HAVING COUNT(co.id_comanda) > 0
ORDER BY COUNT(co.id_comanda) DESC;


---- 2. Validari constrangeri (PK, NN, UK, CK, FK, Triggere)


-- Test PK-1: Incercare actualizare utilizator cu id duplicat
/*
UPDATE utilizator
SET id_utilizator = 1
where id_utilizator = 2;
*/

-- Test PK-2: Incercare actualizare produs cu id duplicat
/*
UPDATE produs
SET id_produs = 2
where id_produs = 1;
*/

-- Test PK-3: Incercare actualizare categorie cu id duplicat
/*
UPDATE categorie
SET id_categorie = 1    
where id_categorie =2; 
*/

-- Test NN-1: Incercare actualizare utilizator fara nume_utilizator
/*
UPDATE utilizator
SET nume_utilizator = NULL
where id_utilizator = 1;
*/

-- Test NN-2: Incercare actualizare produs fara titlu
/*
UPDATE produs
SET titlu_produs = NULL
WHERE id_produs =1;
*/

-- Test NN-3: Incercare actualizare comanda fara status
/*
UPDATE comanda
SET status = NULL
where id_produs = 5;
*/

-- Test NN-4: Incercare actualizare feedback fara nota
/*
update feedback
set nota = NULL
where id_feedback = 1;
*/


-- Test UK-1: Incercare actualizare utilizator cu nume_utilizator duplicat
/*
UPDATE utilizator
SET nume_utilizator = 'maria_ionescu'
where id_utilizator=5;
*/

-- Test UK-2: Incercare inserare comanda pentru produs deja comandat (INDEX UNIQUE)
/*
INSERT INTO comanda (status, pret_transport, id_produs, id_utilizator_cumparator)
VALUES ('plasat', 25, 1, 2);
*/


-- Test CK-1: Incercare inserare categorie cu denumire prea scurta
/*
INSERT INTO categorie (denumire)
VALUES ('AB');
*/

-- Test CK-2: Incercare inserare categorie cu caractere invalide (cifre)
/*
INSERT INTO categorie (denumire)
VALUES ('Categorie123');
*/

-- Test CK-3: Incercare inserare comanda cu status invalid
/*
INSERT INTO comanda (status, pret_transport, id_produs, id_utilizator_cumparator)
VALUES ('status_invalid', 25, 6, 1);
*/

-- Test CK-4: Incercare inserare comanda cu pret_transport invalid
/*
INSERT INTO comanda (status, pret_transport, id_produs, id_utilizator_cumparator)
VALUES ('plasat', 30, 6, 1);
*/

-- Test CK-5: Incercare inserare comanda cu status_plata invalid
/*
INSERT INTO comanda (status, pret_transport, status_plata, id_produs, id_utilizator_cumparator)
VALUES ('plasat', 25, 'pending', 6, 1);
*/

-- Test CK-6: Incercare inserare comanda cu data_livrare inainte de data_plasarii
/*
INSERT INTO comanda (status, pret_transport, data_plasarii, data_livrare, id_produs, id_utilizator_cumparator)
VALUES ('livrat', 25, TO_DATE('2024-10-15', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 7, 1);
*/

-- Test CK-7: Incercare inserare feedback cu nota invalida (mai mare ca 5)
/*
UPDATE feedback
SET nota = 8
where id_feedback = 2;
*/

-- Test CK-8: Incercare inserare feedback cu nota invalida (negativa)
/*
UPDATE feedback
SET nota = -8
where id_feedback = 2;
*/

-- Test CK-9: Incercare inserare istoric_pret cu pret invalid (mai mare ca 2000)
/*
INSERT INTO istoric_pret (pret, id_produs)
VALUES (2500.00, 5);
*/

-- Test CK-10: Incercare inserare istoric_pret cu pret negativ
/*
INSERT INTO istoric_pret (pret, id_produs)
VALUES (-50.00, 5);
*/

-- Test CK-11: Incercare inserare produs cu titlu prea scurt
/*
INSERT INTO produs (titlu_produs, id_categorie, id_utilizator_vanzator)
VALUES ('Test', 1, 1);
*/

-- Test CK-12: Incercare inserare produs cu stare invalida
/*
INSERT INTO produs (titlu_produs, stare, id_categorie, id_utilizator_vanzator)
VALUES ('Produs test cu stare invalida', 'perfecta', 1, 1);
*/

-- Test CK-13: Incercare inserare produs cu status invalid
/*
INSERT INTO produs (titlu_produs, status, id_categorie, id_utilizator_vanzator)
VALUES ('Produs test cu status invalid', 'suspendat', 1, 1);
*/

-- Test CK-14: Incercare actualizare utilizator cu nume prea scurt
/*
UPDATE utilizator
SET nume_utilizator = 'ion popescu'
where id_utilizator =3;
*/

-- Test CK-15: Incercare actualizare utilizator cu spatii in nume
/*
UPDATE utilizator
SET nume_utilizator = 'ion popescu'
where id_utilizator =3;
*/

-- Test CK-16: Incercare inserare utilizator cu tara invalida
/*
UPDATE utilizator
SET tara = 'narnia'
where id_utilizator =3;
*/

-- Test CK-17: Incercare inserare utilizator cu parola prea scurta
/*
UPDATE utilizator
SET parola = 'nu'
where id_utilizator =3;
*/


-- Test FK-1: Incercare actualizare produs cu categorie inexistenta
/*
UPDATE produs
set id_categorie = 30
where id_produs = 1;
*/

-- Test FK-2: Incercare actualizare produs cu vanzator inexistent
/*
UPDATE produs
SET id_utlizator_vanzator = 999
where id_produs = 1;
*/

-- Test FK-3: Incercare inserare categorie cu parinte inexistent
/*
INSERT INTO categorie (denumire, id_parinte)
VALUES ('SubCtest', 30);
*/

-- Test FK-4: Incercare inserare comanda cu produs inexistent
/*
INSERT INTO comanda (status, pret_transport, id_produs, id_utilizator_cumparator)
VALUES ('plasat', 25, 9999, 1);
*/

-- Test FK-5: Incercare inserare comanda cu cumparator inexistent
/*
INSERT INTO comanda (status, pret_transport, id_produs, id_utilizator_cumparator)
VALUES ('plasat', 25, 
        (SELECT id_produs FROM produs WHERE titlu_produs = 'Rochie de Seara Eleganta'), 
        999);
*/

-- Test FK-6: Incercare inserare feedback cu comanda inexistenta
/*
INSERT INTO feedback (nota, id_comanda, id_utilizator_creator, id_utilizator_primitor)
VALUES (5.0, 999, 1, 2);
*/

-- Test FK-7: Incercare inserare feedback cu creator inexistent
/*
INSERT INTO feedback (nota, id_comanda, id_utilizator_creator, id_utilizator_primitor)
VALUES (5.0, 1, 999, 2);
*/

-- Test FK-8: Incercare inserare feedback cu primitor inexistent
/*
INSERT INTO feedback (nota, id_comanda, id_utilizator_creator, id_utilizator_primitor)
VALUES (5.0, 1, 1, 999);
*/

-- Test FK-9: Incercare inserare istoric_pret cu produs inexistent
/*
INSERT INTO istoric_pret (pret, id_produs)
VALUES (100.00, 9999);
*/

-- Test FK-10: Incercare inserare mesaj cu expeditor inexistent
/*
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
VALUES ('Test mesaj', 999, 1);
*/

-- Test FK-11: Incercare inserare mesaj cu destinatar inexistent
/*
INSERT INTO mesaj (continut, id_utilizator_trimite, id_utilizator_primeste)
VALUES ('Test mesaj', 1, 999);
*/

-- Test FK-12: Incercare stergere utilizator care are produse
/*
DELETE FROM utilizator WHERE nume_utilizator = 'maria_ionescu';
*/

-- Test FK-13: Incercare stergere produs care are comenzi
/*
DELETE FROM produs WHERE titlu_produs = 'Tricou Nike Original Marimea M';
*/

-- Test FK-14: Incercare stergere categorie care are produse
/*
DELETE FROM categorie WHERE denumire = 'Tricouri';
*/


-- Test TRIGGER-1: Incercare modificare data_plasarii comenzii (trigger comanda_data_plasarii_no_update_trg)
/*
UPDATE comanda 
SET data_plasarii = SYSDATE 
WHERE id_comanda = 1;
*/

-- Test TRIGGER-2: Incercare modificare data_inregistrare istoric pret (trigger istoric_pret_data_inregistrare_no_update_trg)
/*
UPDATE istoric_pret 
SET data_inregistrare = SYSDATE 
WHERE id_produs = 1 AND data_inregistrare = (SELECT MIN(data_inregistrare) FROM istoric_pret WHERE id_produs = 1);
*/

-- Test TRIGGER-3: Incercare modificare ora mesaj (trigger mesaj_ora_no_update_trg)
/*
UPDATE mesaj 
SET ora = SYSDATE 
WHERE id_mesaj = 1;
*/

-- Test TRIGGER-4: Incercare modificare data_creare_cont utilizator (trigger utilizator_data_creare_no_update_trg)
/*
UPDATE utilizator 
SET data_creare_cont = SYSDATE 
WHERE id_utilizator = 1;
*/

-- Test TRIGGER-5: Incercare inserare utilizator cu varsta sub 18 ani (trigger trg_utilizator_data_nasterii_trg)
/*
INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii)
VALUES ('user_minor', 'romania', 'parola123', TO_DATE('2015-01-01', 'YYYY-MM-DD'));
*/

-- Test TRIGGER-6: Incercare inserare utilizator cu varsta peste 100 ani (trigger trg_utilizator_data_nasterii_trg)
/*
INSERT INTO utilizator (nume_utilizator, tara, parola, data_nasterii)
VALUES ('user_batran', 'romania', 'parola123', TO_DATE('1900-01-01', 'YYYY-MM-DD'));
*/

-- Test TRIGGER-7: Verificare ca produsul devine inactiv dupa comanda (trigger produs_inactiv_dupa_comanda_trg)
SELECT 
    p.titlu_produs "Produs",
    p.status "Status"
FROM produs p
WHERE p.titlu_produs IN ('Tricou Nike Original Marimea M', 'Geanta de Piele Naturala', 'Jucarie Lego Star Wars Set Complet');
