# 8. gyakorlat

## Előkészületek

### Neo4j
+ Regisztráljunk a Neo4j Sandbox oldalán (https://neo4j.com/sandbox/)
+ Telepítsük Telepítsük fel a Neo4J Desktop programot (szükség lehet rendszergazdai jogosultságra)


A megoldásokat - ahol kódot kell írni - másoljuk be a ```js és a ``` közötti részbe


## Feladatok


1\.	A böngészőben indítsa el a Neo4J Sandbox-ot!

a. A megjelenő abakban lejjebb, a Select a Project részben kattintson a Movies lehetőségre, majd lent a Create gombra!  
b. Az Open gombon lévő nyíl segítségével válassza az Open with Browser lehetőséget  


2\.	A Neo4J Sandbox Movie adatbázisából kérdezze le azon személyek nevét és születési évét, akik 1964-ben vagy 1965-ben születtek!

a. A lekérdezés kódját adja meg válaszként! 

```js
//Feladat02
MATCH(p:Person) // Hivatkozok rá
WHERE p.born = 1964 OR p.born = 1965 // p.born IN [1964, 1965]
Return p.name, p.born
```


3\. A Neo4J Sandbox Movie adatbázisából kérdezze le azon filmek címét és megjelenési évét, amelyek címe A-betűvel kezdődik! (WHERE, STARTS WITH).

a. A listát rendezzük a megjelenési év szerint csökkenő sorrendbe (ORDER BY)!  
b. Az utasítás kódját adjuk meg válaszként!  

```js
// Feladat03
Match(m:Movie)
where m.title starts with 'A'
return m.title, m.released
order by m.released DESC
```

4\.  A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy milyen filmeket készített (:PROCUCED) Joel Silver!

a. Csak a filmek címe jelenjen meg  
b. A lekérdezés kódját adja meg válaszként  

   
```js
// Feladat04
MATCH (p:Person)-[:PRODUCED]->(m:Movie)
where p.name = 'Joel Silver'
RETURN DISTINCT m.title
```

5\. A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy melyik rendező hány filmet rendezett! (:DIRECTED).

a. Csak azokat a rendezőket jelenítsük meg, akik 1-nél több filmet rendeztek! (WHERE)  
b. A lekérdezés kódját adja meg válaszként!  

```js
// Feladat05
match(p:Person)-[:DIRECTED]->(m:Movie)
with p.name as Nev, count(m.title) as Darab // segéd lekérdezés, 'AS'-t használj
where Darab > 1
return Nev, Darab
```


6\. A Neo4J Sandbox Movie adatbázisából jelenítsük meg azokat a személyeket, akik egyszerre voltak szereplők és rendezők is valamely filmben!

a. A lekérdezés kódját adjuk meg válaszként!   

```js
// Feladat06
match(p:Person)-[:ACTED_IN]->(m:Movie)
where exists ((p)-[:DIRECTED]->(m))
return p.name
```

7\. A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy mely filmek hány szereplője van!

a. A lista legyen sorba rendezve a szereplők száma szerint csökkenően, azon belül a film címe szerint növekvően  
b. A listából csak az első 10 jelenjen meg!  
c. A lekérdezés kódját adja meg válaszként  

```js
// Feladat07
match(p:Person)-[:ACTED_IN]->(m:Movie)
return m.title as Cim, count(p.name) as Darab
order by Darab desc, Cim
limit 10
```

8\. A Neo4J Sandbox Movie adatbázisánál készítsen új indexet i_person_born néven!

a. Az indexelés a Person csúcsokra történjen név és születési idő szerint!  
b. Az indexet létrehozó utasítást adja meg válaszként!   

```js
// Feladat08
create index i_person_born
for (p:Person)
on (p.name, p.born)
```

9\.  A Neo4J Sandbox Movie adatbázisánál jelenítse meg a személyek nevét és születési évét!

a. A listát szűrje az 1980 és 2000 között született személyekre!  
b. Az utasítás végrehajtásával együtt jelenjen meg a végrehajtási terv is!  
c. Az utasítást adja meg válaszként!  

```js
// Feladat09
profile // végrehajtási terv
match(p:Person)
where p.born >= 1980 and p.born <= 2000
return p.name, p.born
```

10\.  Indítsa el a Neo4J Desktop programot, majd a New gombnál válassza az Import Sample Project lehetőséget!

a. Az importálásnál válassza a Northwind adatbázis korábbi verzióját, majd adjon meg egy jelszót  
b. A telepítés után kattintson a Northwind adatbázisra, majd nyomja le a Start gombot!  

11\. A Neo4J Desktop-ból indítsa el a Neo4J Browsert!

a. Szükség esetén futtassa le a northwind.cypher script tartalmát!  
b. Jelenítse meg a Category csomópontokat vizuálisan  

12\. A Neo4J Desktop-ban hozzon létre új projektet, majd egy új adatbázist tanulo néven!

a. Nyissa meg a Neo4J Browsert, majd tegye aktívvá az új adatbázist!  
b. Hozzon létre :Tanulo és :Tanar csomópontokat az alábbiak alapján:  
Tanulo(Nev, Eletkor, Atlag) Kiss Béla, 22, 3.5 Nagy Ilona, 23, 4.4  
Tanar(Nev, Szak) Tóth Ottó, matematika Nagy Ivett, informatika  
c. A csomópontok létrehozása után kérdezze le a tanulo adatbázis összes csomópontját!  
d. A lekérdező utasítást  adja meg válaszként.   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható

```js

```


13\. Az előző feladatban létrehozott tanulo adatbázisban hozzon létre két új kapcsolatot :Tanit néven az alábbiak szerint:

a. Tóth Ottó tanítja Kiss Bélát  
b. Nagy Ivett tanítja Nagy Ilonát  
c. A szükséges utasításokat adja meg válaszként!   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható  

```js

```

14\. A 12. feladatban létrehozott tanulo adatbázisban végezze el a következő módosításokat:

a. Nagy Ilona átlaga legyen 5.0  
b. Tóth Ottó szakja legyen Fizika  
c. A szükséges utasításokat adja meg válaszként!   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható

```js

```

15\. A Neo4J Desktop-ban tegye aktívvá a tanulo projektet, majd nyisson új terminált az adatbázis melletti Open gombnál mellett lévő három pont (...) kiválasztásával! Utána lépjen be a bin mappába, majd adja ki a cypher-shell parancsot!

a. Szükség esetén adja meg a felhasználónevet és a jelszót  
b. Csatlakozzon a tanulo adatbázishoz (:use tanulo;)  
c. Kérdezze le az első két csúcsot!  
d. Az utasítást adja meg válaszként  


```js

```

