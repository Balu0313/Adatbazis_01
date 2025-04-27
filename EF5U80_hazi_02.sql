-- A maszkolt tábla (webshop adatbázis, UGYFEL tábla alapján):
CREATE TABLE UGYFEL_MASKED (
    LOGIN NVARCHAR(255) NOT NULL,
    -- email maszkolás:
    EMAIL NVARCHAR(255) MASKED WITH (FUNCTION = 'email()') NOT NULL,
    -- partial maszkolás:
    NEV NVARCHAR(255) MASKED WITH (FUNCTION = 'partial(1, "XXXXX", 1)') NOT NULL,
    -- random maszkolás:
    SZULEV NUMERIC(4) MASKED WITH (FUNCTION = 'random(1900, 2020)'),
  	-- default maszkolás:
    NEM NVARCHAR(1) MASKED WITH (FUNCTION = 'default()'),
    CIM NVARCHAR(255)
);

-- 10 adat beszúrása (későbbi tesztelés szempomtjából)
INSERT INTO UGYFEL_MASKED (LOGIN, EMAIL, NEV, SZULEV, NEM, CIM)
VALUES
('adam1',     'ádám.kiss@mail.hu',           'Kiss Ádám',              1991, 'F', '5630 Békés, Szolnoki út 8.'),
('adam3',     'adam3@gmail.com',             'Barkóczi Ádám',          1970, 'F', '3910 Tokaj, Dózsa György utca 37.'),
('adam4',     'ádám.bieniek@mail.hu',        'Bieniek Ádám',           1976, 'F', '8630 Balatonboglár, Juhászfö1di út 1.'),
('agnes',     'agnes@gmail.com',             'Lengyel Ágnes',          1979, 'N', '5200 Törökszentmiklós, Deák Ferenc út 5.'),
('agnes3',    'agnes3@gmail.com',            'Hartyánszky Ágnes',      1967, 'N', '6430 Bácsalmás, Posta köz 2.'),
('AGNESH',    'AGNESH@gmail.com',            'Horváth Ágnes',          1981, 'N', '8200 Veszprém, Rákóczi utca 21.'),
('AGNESK',    'AGNESK@gmail.com',            'Kovács Ágnes',           1988, 'N', '1084 Budapest, Endrődi Sándor utca 47.'),
('akos',      'ákos.bíró@mail.hu',           'Bíró Ákos',              1982, 'F', '9023 Győr, Kossuth Lajos 47/b.'),
('aladar',    'aladár.dunai@mail.hu',        'Dunai Aladár',           1980, 'F', '5931 Nagyszénás, Árpád utca 23.'),
('alexandra', 'alexandra.bagóczki@mail.hu',  'Bagóczki Alexandra',     1992, 'N', '2381 Taborfalva, Petőfi utca 1/2.');

-- Nem maszkolt (rendelkezik megfelelő jogusúltsággal) felhasználók:
CREATE USER AdminUser WITHOUT LOGIN;
GRANT SELECT ON UGYFEL_MASKED TO AdminUser;
GRANT UNMASK TO AdminUser;

-- Maszkolt (nem rendelkezik megfelelő jogusúltsággal) felhasználók:
CREATE USER NormalUser WITHOUT LOGIN;
GRANT SELECT ON UGYFEL_MASKED TO NormalUser;

-- Teszteljük a maszkolást:

-- 1. AdminUser felhasználó:
EXEC AS User = 'AdminUser';
SELECT * FROM UGYFEL_MASKED
REVERT

-- 2. NormalUser felhasználó:
EXEC AS User = 'NormalUser';
SELECT * FROM UGYFEL_MASKED
REVERT