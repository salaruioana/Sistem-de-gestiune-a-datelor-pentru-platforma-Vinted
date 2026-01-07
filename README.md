# Sistem-de-gestiune-a-datelor-pentru-platforma-Vinted

Acest proiect reprezintă proiectarea și implementarea unei baze de date relaționale (Oracle SQL) pentru o platformă de tip marketplace C2C (Consumer-to-Consumer), similară cu Vinted. Sistemul gestionează utilizatori, produse, negocieri, comenzi și feedback, asigurând integritatea și consistența datelor prin constrângeri complexe și triggere.

---

## 1. Scopul Aplicației

Aplicația facilitează vânzarea și cumpărarea de produse (îmbrăcăminte, deco, electronice mici) cu prețuri de până la 2000 RON. Platforma acționează ca intermediar pentru securizarea tranzacțiilor.

### Funcționalități Cheie:
* **Vânzare/Cumpărare:** Un anunț este unic per produs. Când produsul este vândut, anunțul devine automat inactiv.
* **Negociere:** Posibilitatea de a negocia prețul prin mesaje, cu păstrarea istoricului de prețuri.
* **Reputație:** Sistem de feedback bilateral (0-5 stele) pentru vânzător și cumpărător după finalizarea comenzii.
* **Siguranță:** Restricționarea accesului pentru persoanele sub 18 ani.
* **Flux Comandă:** Plasare -> Confirmare/Expediere -> Livrare -> Finalizare Plată.

### Simplificări Implementate:
* Transport cu preț fix (25 RON național / 50 RON internațional).
* Imaginile nu sunt stocate în baza de date.
* Nu se procesează plăți reale, doar statusul acestora.

---

## 2. Arhitectura Bazei de Date

### Diagrama Entitate-Relație (Simplificată)
Structura este centrată pe utilizator și produs, respectând formele normale 1NF, 2NF și 3NF.

```mermaid
erDiagram
    UTILIZATOR ||--|{ PRODUS : vinde
    UTILIZATOR ||--|{ COMANDA : cumpara
    UTILIZATOR ||--|{ MESAJ : trimite_primeste
    CATEGORIE ||--|{ PRODUS : contine
    CATEGORIE ||--|{ CATEGORIE : subcategorie
    PRODUS ||--|| COMANDA : generat_din
    PRODUS ||--|{ ISTORIC_PRET : are
    COMANDA ||--|{ FEEDBACK : genereaza
