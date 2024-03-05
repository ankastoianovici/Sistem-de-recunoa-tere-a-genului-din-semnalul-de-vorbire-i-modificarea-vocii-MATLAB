# Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB

# Cuprins
- [Motivatia](#motivatia)
- [Arhitectura aplicației](#arhitectura)
- [Functionalitate](#functionalitate)
- [Exemple](#exemple)
- [Concluzii](#concluzii)
- [Bibliografie](#bibliografie)
 
# Motivatia <a name="motivatia"></a>
Procesarea semnalului vocal are numeroase aplicații în aproape toate domeniile tehnice. Identificarea de gen este importantă în procesarea vorbirii. Acest proiect descrie o analiză comparativă a semnalelor de vorbire pentru a produce o clasificare automată de gen. Clasificarea de gen în funcție de semnalul de vorbire este o tehnică care analizează diverse caracteristici ale unui eșantion de voce pentru a determina sexul vorbitorului. 
Este prezentată o aplicație pentru codificarea vorbirii, analiză, sinteză și identificare de gen. Un sistem tipic de recunoaștere a genului este împărțit în două părți: sistemul front-end și sistemul back-end. Sarcina sistemului front-end este de a extrage informații de gen dintr-un semnal de vorbire și de a o reprezenta ca un set de cadre. Sarcina sistemului back-end (cunoscut și ca clasificator) în faza de recunoaștere este de a crea un model de gen pentru a recunoaște genul din semnalul de vorbire.


# Arhitectura aplicatiei <a name="arhitectura"></a>
![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/4436ecf5-7c04-43d9-b6e7-074ccd988db1)

# Functionalitate <a name="functionalitate"></a>
Utilizatorul încarcă un fișier audio utilizând butonul SourceButton.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/74c3929a-19eb-4d6e-8450-d6c9602ae09f)

Aplicația afișează numele fișierului și încarcă datele audio.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/675c0cf2-28b1-4d04-98fa-41f40c8db10a)

Utilizatorul poate genera un grafic al semnalului audio, reda sunetul sau să-l oprească folosind butoanele corespunzătoare.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/74329022-9029-47a9-a1a4-6d7074300d8c)

Utilizatorul poate să facă o înregistrare vocală pe care ulterior o poate analiza și realiza diferite calcule și modificări.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/f7fb59c5-a24e-4a0b-9edf-41cce764451e)

Aplicația oferă posibilitatea de a analiza sunetele muzicale dintr-un instrmunetal, iar apoi acesta reconstruiește partea din audio care a fost analizată.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/ac918d93-de55-4fd5-9360-76ece665ca59)

Aplicația poate efectua analiza vocală, determinând frecvența fundamentală, indicii vocali, amplitudinea vocală și estimând genul vocal.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/a57f2cb4-775a-4e3e-86d0-63cd6fdd7bb6)

Alte funcționalități, cum ar fi modificarea vocii sau adăugarea de efecte, sunt disponibile prin butoane suplimentare, unde utilizatorul selectează butonul dorit, este redat sunetul, modificat și afișat graficul respectiv.

![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/9679c31e-8258-4f3a-a533-fd502db07027)



# Exemple <a name="exemple"></a>
![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/ee5d05eb-fb3d-4fc3-b9b9-02c1e5bb9d06)
Utilizatorul este invitat să selecteze un fișier audio cu extensia .mp3 sau .wav. Dacă un fișier valid este selectat, variabila flag devine 1, indicând că fișierul a fost încărcat corect. Datele audio și frecvența de eșantionare sunt citite în variabilele aud_file și aud_fs. Frecvența fundamentală a vocii este ajustată pentru a crea o voce mai înaltă și amuzantă.
Se generează variante ale sunetului original prin:
- Inversarea semnalului (outputAudio1).
- Adăugarea unui efect de ecou (outputAudio2).
- Eliminarea zgomotului utilizând un filtru trece-jos (outputAudio3).

Se afișează graficele pentru sunetul original și variantele manipulate, inclusiv vocea amuzantă, sunetul inversat, sunetul cu ecou și sunetul fără zgomot. Sunetul original și variantele manipulate sunt redate secvențial, cu o pauză de 5 secunde între ele. Dacă utilizatorul selectează un fișier cu o extensie incorectă, se afișează un mesaj de eroare.
![image](https://github.com/ankastoianovici/Sistem-de-recunoa-tere-a-genului-din-semnalul-de-vorbire-i-modificarea-vocii-MATLAB/assets/61665120/baef68ba-514e-4f82-9dcb-6d947443fadc)



Se foloseste un filtru trece-jos Butterworth pentru a elimina frecvențele nedorite din semnalul audio. Se împarte semnalul în cadre (frames) și se calculează frecvența fundamentală pentru fiecare cadru. Acest lucru se face prin analiza autocorelației semnalului. Se calculează media frecvențelor fundamentale obținute pentru fiecare cadru, iar apoi se compară cu un prag (165 Hz în acest caz). Dacă media este mai mare decât pragul, se consideră că vocea este feminină; altfel, este considerată masculină. Se folosește o funcție încorporată (freq) pentru a calcula frecvența medie a semnalului și se compară cu rezultatul obținut prin analiza autocorelației.Se afișează frecvența estimată și se indică genul vocii bazat pe pragul specificat. 

# Concluzii <a name="concluzii"></a>
Aplicația dezvoltată în MATLAB are ca scop analiza semnalelor audio pentru extragerea informațiilor legate de frecvența vocală și estimarea genului vorbitorului. Prin interfața grafică dezvoltată cu App Designer, utilizatorii pot încărca fișiere audio, efectua analize asupra semnalului vocal și aplica diverse modificări asupra acestuia. Algoritmii de autocorelare și filtrare Butterworth sunt implementați pentru evidențierea caracteristicilor semnalelor vocale. Estimarea genului vocal se realizează prin comparația frecvenței medii a semnalului vocal cu intervale prestabilite asociate genurilor masculine și feminine. În plus, aplicația oferă funcționalități precum modificarea înălțimii vocii, redarea sunetului inversa, efectul de ecou și eliminarea zgomotului din fundal. Feedback-ul și rezultatele analizelor sunt comunicate utilizatorilor printr-un câmp de text, iar structura modulară a codului contribuie la claritate și eficiența.

# Bibliografie <a name="bibliografie"></a>
- https://en.wikipedia.org/wiki/Butterworth_filter 
- https://www.mathworks.com/help/matlab/ref/flipud.html
- https://www.mathworks.com/help/audio/ref/pitch.html
