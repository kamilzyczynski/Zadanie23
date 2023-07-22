-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). 
--    W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.

CREATE TABLE pracownik(
id INT PRIMARY KEY auto_increment,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
wypłata INT NOT NULL,
data_urodzenia date NOT NULL,
stanowisko VARCHAR(30) NOT NULL
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników

INSERT INTO pracownik (imie, nazwisko, wypłata, data_urodzenia, stanowisko) VALUES 
('Jacek', 'Nowak', 8700,  '1970-07-07', 'Zbrojarz'),
('Antoni', 'Gwint', 6500, '1973-08-12', 'Cieśla'),
('Grzegorz', 'Kasprzak', 6700,  '1985-05-01', 'Murarz'),
('Konrad', 'Konieczny', 7200, '1996-01-02', 'Elektryk'),
('Jarosław', 'Nowak', 5000, '1960-12-07', 'Hydraulik'),
('Henryk', 'Broda', 6000, '1979-02-20', 'Cieśla');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku

SELECT * FROM pracownik ORDER BY nazwisko;

-- 4. Pobiera pracowników na wybranym stanowisku

SELECT * FROM pracownik WHERE stanowisko = 'Cieśla';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat

SELECT * FROM pracownik WHERE DATEDIFF(NOW(), data_urodzenia) >= 365 * 30 + 7;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

UPDATE pracownik SET wypłata = 1.1 * wypłata WHERE stanowisko = 'Cieśla';

-- 7.Pobiera najmłodszego pracowników 
-- (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)

SELECT * FROM pracownik WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik);

-- 8. Usuwa tabelę pracownik

DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)

CREATE TABLE stanowisko(
id INT PRIMARY KEY auto_increment,
nazwa_stanowiska VARCHAR(30) NOT NULL,
opis VARCHAR(200),
wypłata INT NOT NULL
);

-- 10.Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)

CREATE TABLE adres(
id INT PRIMARY KEY auto_increment,
adres_lokalu VARCHAR(100),
kod_pocztowy VARCHAR(6),
miejscowość VARCHAR(30)
);

-- 11.Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres

CREATE TABLE pracownik(
id INT PRIMARY KEY auto_increment,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
adres_id INT,
stanowisko_id INT,
FOREIGN KEY (adres_id) REFERENCES adres (id),
FOREIGN KEY (stanowisko_id) REFERENCES stanowisko (id)
);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO stanowisko (nazwa_stanowiska, opis, wypłata) VALUES 
('Zbrojarz', 'Wykonywanie zbrojenia elementów żelbetowych', 7000),
('Cieśla', 'Wykonywanie szalowania elementów żelbetowych', 8200),
('Murarz', 'Wykonywanie ścian murowanych', 7600),
('Elektryk', 'Wykonywanie instalacji elektrycznych', 6900),
('Hydraulik', 'Wykonywanie instalacji sanitarnych', 6500);

INSERT INTO adres (adres_lokalu, kod_pocztowy, miejscowość) VALUES 
('ul.Długa 20', '80-252', 'Gdańsk'),
('ul.Świętojańska 49', '80-680', 'Gdynia'),
('ul.Monte Cassino 9', '80-900', 'Sopot'),
('ul.Długi Targ 7', '80-252', 'Gdańsk'),
('ul.Władysława IV 5', '80-680', 'Gdynia');

INSERT INTO pracownik (imie, nazwisko, adres_id, stanowisko_id) VALUES 
('Jacek', 'Nowak', 1, 1),
('Antoni', 'Gwint', 2, 2),
('Grzegorz', 'Kasprzak', 3, 3),
('Konrad', 'Konieczny', 4, 4),
('Jarosław', 'Nowak', 1, 5),
('Henryk', 'Broda', 5, 1);

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

SELECT imie, nazwisko, nazwa_stanowiska, adres_lokalu, kod_pocztowy, miejscowość 
FROM pracownik
JOIN stanowisko ON pracownik.stanowisko_id = stanowisko.id
JOIN adres ON pracownik.adres_id = adres.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie

SELECT SUM(wypłata) FROM stanowisko
JOIN pracownik ON stanowisko.id = pracownik.stanowisko_id;

SELECT * FROM pracownik 
JOIN adres ON pracownik.adres_id = adres.id
WHERE adres.kod_pocztowy = '80-680';