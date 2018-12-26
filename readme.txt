Krótki opis działania: program REPOSITORY na samym początku działania tworzy katalog RePoZyToRiUm w katalogu home. 
Tworzy się on przy pierwszym uruchomieniu programu. W katalogu tym zapisywane są kopie plików oraz katalogów, które
skopiujemy do RePoZyToRiUm. Podczas dodawania kolejnych kopii dodawane są wpisy co pliku config_file.txt, który znaj
duje się w katalogu RePoZyToRiUm. Plik config_file.txt tworzony jest przy pierwszym kopiowaniu jakiegoś pliku katalogu.
Skrypt uruchamiamy przez wpisanie do konsoli ./project.pl. 

Opis funkcji: 

Show - umożliwia nam przeglądanie wszystkich katalogów i zawartości plików w systemie plików. Wpisujemy pełną ścieżką w górnym polu 
tekstowym i wyniki obserwujemy na dolnym polu.

Copy - tworzy kopię plików oraz katalogów. Tworząć kolejną kopię tego samego pliku/katalogu do nazwy kopii dodaje się 
automatycznie(COPY(numer kopii)). Kopie umieszczane są w katalogu RePoZyToRiUm. Za każdym razem tworzony jest wpis w 
config_file.txt o kopii i oryginale. Stworzenie kopii wykonujemy poprzez podanie całej ścieżki do pliku/katalogu razem z rozszerzeniem pliku.

Copy_Restore - przywraca kopię przez podanie całej ścieżki do pliku/katalogu, który znajduje się w RePoZyToRiUm. Informacja
o tym jaki plik/katalog zostaje nadpisany znajduje się w config_file.txt.

History - podaje nam wszelkie możliwe informacje z funkcji stat o pliku/katalogu, który znajduje się w katalogu RePoZyToRiUm.
Podajemy ściężkę do pliku/katalogu, który znajduje się w RePoZyToRiUm.

Erease - usuwa pliki/katalogi z RePoZyToRiUm przez podanie ścieżki z pliku/katalogu w RePoZyToRiUm. Usuwa wpis w config_file.txt

