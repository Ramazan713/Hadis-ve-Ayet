

import 'package:floor/floor.dart';

final migration3To4 = Migration(3,4,(database)async{

  database.transaction((txn)async{
    await txn.execute("""CREATE TABLE "Counters" (
      "id"	INTEGER,
      "name"	TEXT NOT NULL,
      "content"	TEXT,
      "arabicContent"	TEXT,
      "meaning"	TEXT,
      "orderItem"	INTEGER NOT NULL,
      "goal"	INTEGER,
      "type"	INTEGER NOT NULL,
      "lastCounter"	INTEGER NOT NULL DEFAULT 0,
      "isRemovable"	INTEGER NOT NULL DEFAULT 1,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""CREATE TABLE "EsmaulHusna" (
      "id"	INTEGER,
      "orderItem"	INTEGER NOT NULL,
      "name"	TEXT NOT NULL,
      "arabicName"	TEXT NOT NULL,
      "meaning"	TEXT NOT NULL,
      "dhikr"	TEXT NOT NULL,
      "virtue"	TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""CREATE TABLE "IslamicInfoItem" (
      "id"	INTEGER,
      "titleId"	INTEGER NOT NULL,
      "name"	TEXT,
      "description"	TEXT,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""CREATE TABLE "IslamicInfoTitle" (
      "id"	INTEGER,
      "title"	TEXT NOT NULL,
      "description"	TEXT,
      "type"	INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""CREATE TABLE "PrayerQuran" (
      "id"	INTEGER,
      "arabicContent"	TEXT NOT NULL,
      "meaningContent"	TEXT NOT NULL,
      "source"	TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""CREATE TABLE "Prayers" (
      "id"	INTEGER,
      "name"	TEXT NOT NULL,
      "arabicContent"	TEXT NOT NULL,
      "meaningContent"	TEXT NOT NULL,
      "pronunciationContent"	TEXT,
      PRIMARY KEY("id" AUTOINCREMENT)
    )""");
    await txn.execute("""alter table surah add searchName Text""");
    await txn.execute("""INSERT INTO "Counters" ("id","name","content","arabicContent","meaning","orderItem","goal","type","lastCounter","isRemovable") VALUES (1,'Salavatı Fatih','Allahümme Salli ve Sellim ve Bârik Alâ Seyyidinâ Muhammedinil Fâtihi limâ Uğlika vel Hâtimi li mâ Sebeka Nâsırıl Hakkı bîl Hakkı Vel Hâdî ilâ Sıratıkel Müstekıymi ve Alâ Alihi ve Ashâbihi Hakka Kadrihi ve Mikdârihil Aziym','اَللّٰهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلٰى سَــيِّــدِنَا مُحَمَّدِ ۨالْفَاتِحِ لِمَا اُغْلِقَ وَالْخَاتِمِ لِمَا سَبَقَ نَاصِرِ الْحَقِّ بِالْحَـقِّ وَالْهَادِى اِلٰى صِرَاطِكَ الْمُسْتَقِيمِ وَعَلٰى اٰلِه۪ وَاَصْحَابِه۪ حَقَّ قَدْرِه۪ وَمِقْدَارِهِ الْعَظِيمِ','Allahım! Kapalılıkları açan geçmişe son veren hakka hakikatla destek olan mahlukatı senin doğru yoluna ileten Efendimiz Muhammede Onun aline ve ashabına Onun yüce kadrü kıymetince salat eyle selam eyle ve Onu mübarek kıl',1,NULL,1,0,0),
 (2,'Salavat','Âllahümme salli alâ seyyidinâ Muhammedivvealâ âli seyyidinâ muhammed','اللَّهُمَّ صَلِّ عَلَى سيّدنا مُحَمَّدٍ، وَعَلَى آلِ سيّدنا مُحَمَّدٍ','Allah’ım! Efendimiz, büyüğümüz Muhammed’e ve Muhammed’in ümmetine rahmet eyle.',2,NULL,1,0,0),
 (3,'Sübhanallah','Sübhanallah','سبحان الله','Allah noksanlardan münezzehtir',3,NULL,1,0,0),
 (4,'Elhamdülillah','Elhamdülillah','الحَمْد لله‎‎','Şükür Allah’adır, Allah’a şükürler olsun, hamd Allah’adır',4,NULL,1,0,0),
 (5,'Allahu ekber','Allahu ekber','الله أكبر','Allah en büyüktür.',5,NULL,1,0,0),
 (6,'Kelime-i Tevhid','Lâ ilahe illallah Muhammedün Resulullah','لَا اِلَهَ اِلَّا اللهْ مُحَمَّدُ الرَّسُولُ اللهْ','Allah’tan başka ilah yoktur. Hz. Muhammed (aleyhissalatü vesselam) da Onun Resulüdür',6,NULL,1,0,0),
 (7,'Subhânallâhi velhamdulillâhi ve lâ ilâhe illallâhu vallâhu ekber, Ve lâ havle ve lâ guvvete illâ billâhil aliyyil azîm','Subhânallâhi velhamdulillâhi ve lâ ilâhe illallâhu vallâhu ekber, Ve lâ havle ve lâ guvvete illâ billâhil aliyyil azîm','سُبْحَانَ اللهِ وَالْحَمْدُ للهِ وَلاَ إِلَهَ إِلاَّ اللهُ وَاللهُ أَكْبَر وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللهِ الْعَلِيِّ الْعَظِيمِ','Allah bütün noksan sıfatlardan münezzehtir, bütün hamdler ona mahsustur. Allah''tan başka ilah yoktur, Allah en büyüktür.Azamet sahibi Yüce Allah''tan başkasında güç kuvvet ve kudret yoktur',7,NULL,1,0,0),
 (8,'Subhanallahi ve Bihamdihi Subhanallahil Azim','Subhanallahi ve Bihamdihi Subhanallahil Azim','سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ العَظِيمِ','Allâh’ı hamd ile tüm eksikliklerden tenzih ederek tesbih ederim',8,NULL,1,0,0),
 (9,'Lâ ilâhe illallâhu vahdehu lâ şerike leh, lehü’l-mülkü ve lehü’l-hâmdü yuhyi ve yumit ve hüve hayyun lâ yemût biyedihi’l-hayr ve hüve alâ külli şey’in kadir','Lâ ilâhe illallâhu vahdehu lâ şerike leh, lehü’l-mülkü ve lehü’l-hâmdü yuhyi ve yumit ve hüve hayyun lâ yemût biyedihi’l-hayr ve hüve alâ külli şey’in kadir','لاَ اِلٰهَ اِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِى وَيُمِيتُ وَهُوَ حَىٌّ لاَ يَمُوتُ بِيَدِهِ الْخَيْرُ وَهُوَ عَلٰى كُلِّ شَىْءٍ قَدِيرٌ وَاِلَيْهِ الْمَصِيرُ','Allah’tan başka ibadete lâyık hiçbir ilâh yoktur. O birdir; Onun hiçbir şeriki yoktur. Mülk Ona ait, hamd Ona mahsustur. Hayatı veren de O’dur, ölümü veren de O’dur. O, kendisine asla ölüm ârız olmayan Hayy-ı Ezelîdir. Bütün hayır Onun elindedir. O her şeye hakkıyla kâdirdir. Her şeyin ve herkesin dönüşü de O’nadır',9,NULL,1,0,0),
 (10,'Lâ havle ve lâ kuvvete illâ billâh','Lâ havle ve lâ kuvvete illâ billâh','لا حول ولا قوّة إلاّ بالله','Günahlardan korunmaya güç yetirmek ve taatle kuvvet bulmak ancak Allah’ın tevfik ve yardımıyladır',10,NULL,1,0,0),
 (11,'La ilahe illa ente sübhaneke innî küntü minez-zalimîn','La ilahe illa ente sübhaneke innî küntü minez-zalimîn','لآ إِلَهَ إِلاَّ أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ','Senden başka İlâh yoktur. Sen, Sübhân’sın (her şeyden münezzehsin). Muhakkak ki ben, zâlimlerden oldum',11,NULL,1,0,0),
 (12,'Hasbünallâhü ve nîmel vekiyl','Hasbünallâhü ve nîmel vekiyl','حَسْبُنَا اللّٰهُ وَنِعْمَ الْوَك۪يلُ','Allah bize yeter, O ne güzel vekildir.',12,NULL,1,0,0),
 (13,'Lâ ilâhe illellâhül melikül hakkul mübîn Muhammedün rasûlüllâhi sâdikul va’dil emîn','Lâ ilâhe illellâhül melikül hakkul mübîn Muhammedün rasûlüllâhi sâdikul va’dil emîn','ااِلٰهَ اِلاَّالله ُ اَلْمَلِكُ الْحَقُّ الْمُبِينُ ﴿﴾ مُحَمَّدٌ رَسُولُ اللهِ صَادِقُ الْوَعْدِ اْلاَمِين','Apaçık gerçeğin sahibi Allah’tan başka ilah yoktur. Emin ve sözünün eri olan Muhammed Allah’ın Rasulüdür',13,NULL,1,0,0),
 (14,'Lâ ilâhe illallâhu vahdehû lâ şerîke leh, lehül-mülkü ve lehül-hamdü ve hüve alâ külli şey’in kadîr','Lâ ilâhe illallâhu vahdehû lâ şerîke leh, lehül-mülkü ve lehül-hamdü ve hüve alâ külli şey’in kadîr','لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ','Allah’tan başka hiçbir ilâh yoktur; o tektir, ortağı yoktur. Mülk onundur, hamd ona mahsustur ve o her şeye kàdirdir',14,NULL,1,0,0),
 (15,'Lâ havle ve lâ kuvvete illâ billâhil aliyyil azîm','Lâ havle ve lâ kuvvete illâ billâhil aliyyil azîm','لاَ حَوْلَ وَلاَ قُوَّةَ اِلاَّ بِاللهِ الْعَلِىِّ الْعَظِيمِ','Allah’ın kudret ve gücünden başka kudret ve güç yoktur, sadece Yüce ve Büyük olan Allah’ın yardımıyla elde edilir.',15,NULL,1,0,0);""");
    await txn.execute("""INSERT INTO "EsmaulHusna" ("id","orderItem","name","arabicName","meaning","dhikr","virtue") VALUES (1,0,'Allah','اللَّهُ','Her ismin vasfını ihtiva eden öz adı. Kendinden başka ilah bulunmayan tek Allah.

Bu ism-i şerif, Cenâb-ı Hakk''ın has ismidir. Bu itibarla diğer isimlerin ifade ettiği bütün güzel vasıfları ve İlâhî sıfatları içine alır. Diğer isimler ise, yalnız kendi mânalarına delâlet ederler. Bu bakımdan Allah isminin yerini hiçbir isim tutamaz. Bu isim, Allah''tan başkasına mecazen de verilemez.','66','Her türlü istek, tüm duaların kabul olması için'),
 (2,1,'Er-Rahmân','الرَّحْمَنُ','Dünyada bütün mahlûkata merhamet eden, şefkat gösteren, ihsan eden.','298','Dünyada ve ahirette Allah’ın sevgisini kazanmak için'),
 (3,2,'Er-Rahîm','الرَّحِيمُ','Ahirette, sadece müminlere acıyan, merhamet eden.','258','Maddî ve manevî rızka nail olmak için'),
 (4,3,'El-Melik','الْمَلِكُ','Mülkün, kâinatın sahibi, mülk ve saltanatı devamlı olan.','90','Maddî ve manevî güçlü olmak, insanlara sözlerini anlatıp dinletebilmek, emir sahibi olmak için'),
 (5,4,'El-Kuddûs','الْقُدُّوسُ','Her noksanlıktan uzak ve her türlü takdîse lâyık olan.','170','Maddî ve manevî her türlü temizlik, kalp temizliği, ruhî hastalıklardan iyileşmek için.'),
 (6,5,'Es-Selâm','السَّلاَمُ','Her türlü tehlikelerden selamete çıkaran. Cennetteki bahtiyar kullarına selâm eden.','131','Korkulan her şeyden emin olmak ve esenliğe çıkmak için'),
 (7,6,'El-Mü’min','الْمُؤْمِنُ','Güven veren, emin kılan, koruyan, iman nurunu veren.','137','Güvende olma, güvenilir insan olmak, kötü hastalıklara düşmemek için'),
 (8,7,'El-Muheymin','الْمُهَيْمِنُ','Her şeyi görüp gözeten, her varlığın yaptıklarından haberdar olan.','145','İnsanlardan korunmak ve onların düşüncelerine akıl erdirebilmek için'),
 (9,8,'El-Aziz','الْعَزِيزُ','İzzet sahibi, her şeye galip olan, karşı gelinemeyen.','94','Düşmanlara galip gelmek için'),
 (10,9,'El-Cebbâr','الْجَبَّارُ','Azamet ve kudret sahibi. Dilediğini yapan ve yaptıran. Hükmüne karşı gelinemeyen.','206','İstek ve arzuların olması, insanların ve cinlerin şerrinden emin olmak için'),
 (11,10,'El-Mütekebbir','الْمُتَكَبِّرُ','Büyüklükte eşi, benzeri yok.','662','İzzet, refah ve gerçek büyüklüğe erişmek, halk tarafından sevilmek için'),
 (12,11,'El-Hâlık','الْخَالِقُ','Yaratan, yoktan var eden. Varlıkların geçireceği halleri takdir eden.','731','İşlerde üzüntü ve sıkıntıdan kurtulmak, başarılı olmak için'),
 (13,12,'El-Bâri','الْبَارِئُ','Her şeyi kusursuz ve mütenasip yaratan.','214','İşte başarılı olmak, maddî ve manevî sıkıntılardan kurtulmak için'),
 (14,13,'El-Musavvir','الْمُصَوِّرُ','Varlıklara şekil veren ve onları birbirinden farklı özellikte yaratan.','336','Maksat ve meramına ulaşmak ve ifade etmek, en zor işleri başarmak ve bir işte uzmanlaşmak için'),
 (15,14,'El-Gaffâr','الْغَفَّارُ','Günahları örten ve çok mağfiret eden. Dilediğini günah işlemekten koruyan.','1.281','Bağışlanmak ve günahlardan korunmak için'),
 (16,15,'El-Kahhâr','الْقَهَّارُ','Her istediğini yapacak güçte olan, galip ve hâkim.','306','Zalimlerin ve din düşmanlarının kahrından kurtulmak için'),
 (17,16,'El-Vehhâb','الْوَهَّابُ','Karşılıksız nimetler veren, çok fazla ihsan eden.','14','Sıkıntısız ve maddî açıdan rahat bir hayat sürmek için'),
 (18,17,'Er-Rezzâk','الرَّزَّاقُ','Her varlığın rızkını veren ve ihtiyacını karşılayan.','308','Bol rızıklı bir ömür geçirmek için'),
 (19,18,'El-Fettâh','الْفَتَّاحُ','Her türlü sıkıntıları gideren.','489','Maddî ve manevî hayır kapılarının açılması, ticarette başarıya ulaşmak için'),
 (20,19,'El-Alim','اَلْعَلِيْمُ','Gizli açık, geçmiş, gelecek, her şeyi, ezeli ve ebedi ilmi ile en mükemmel bilen.','150','İlim zenginliği için'),
 (21,20,'El-Kâbid','الْقَابِضُ','Dilediğinin rızkını daraltan, ruhları alan.','903','Zalimin zulmünden kurtulmak için'),
 (22,21,'El-Bâsit','الْبَاسِطُ','Dilediğinin rızkını genişleten, ruhları veren.','72','Rızkının genişlemesi ve bereketin artması için'),
 (23,22,'El-Hafid','الْخَافِضُ','Kâfir ve facirleri alçaltan.','1.481','Kötüden, kötülerden ve belalardan korunmak için'),
 (24,23,'Er-Rafi’','الرَّافِعُ','Şeref verip yükselten.','351','İnsanlar içinde ve işinde yükselmek, tevazu sahibi olmak için'),
 (25,24,'El-Muiz','الْمُعِزُّ','Dilediğini aziz eden.','117','Fakir ve zelillikten kurtulmak.'),
 (26,25,'El-Muzil','المُذِلُّ','Dilediğini zillete düşüren, hor ve hakir eden.','770','Düşmanları zelil etmek için'),
 (27,26,'Es-Semi’','السَّمِيعُ','Her şeyi en iyi işiten, duaları kabul eden.','180','Duaların kabul olması için'),
 (28,27,'El-Basir','الْبَصِيرُ','Gizli açık, her şeyi en iyi gören.','302-112','Acziyetin kalkması, basiretli olmak için'),
 (29,28,'El-Hakem','الْحَكَمُ','Mutlak hakim, hakkı bâtıldan ayıran. Hikmet sahibi.','68','Haklı davasını kazanmak, insanlar arasında hak ile hüküm vermek için'),
 (30,29,'El-Adl','الْعَدْلُ','Mutlak adil, yerli yerinde yapan.','104','Adaletli olmak, haklı davayı kazanmak.'),
 (31,30,'El-Latîf','اللَّطِيفُ','Her şeye vakıf, lütuf ve ihsan sahibi olan.','129','Dileklerin olması, kısmet ve rızkın artması için'),
 (32,31,'El-Habîr','الْخَبِيرُ','Her şeyden haberdar. Her şeyin gizli taraflarından haberi olan.','812','Hafıza ve idrakin genişlemesi için'),
 (33,32,'El-Halîm','الْحَلِيمُ','Cezada, acele etmeyen, yumuşak davranan, hilm sahibi.','88','Ahlâk güzelliği ve yumuşak huylu olmak, hiddet ve sinirin gitmesi için'),
 (34,33,'El-Azîm','الْعَظِيمُ','Büyüklükte benzeri yok. Pek yüce.','1.020','Sözünün tesirli olması ve sözü dinlenir olmak için'),
 (35,34,'El-Gafûr','الْغَفُورُ','Affı, mağfireti bol.','1.286','Günahların affı ve kötü ahlâktan korunmak için'),
 (36,35,'Eş-Şekûr','الشَّكُورُ','Az amele, çok sevap veren.','526','Kendine verilen nimetlerin şükrünü eda etmek, talihin açıklığı, bol rızık için'),
 (37,36,'El-Aliyy','الْعَلِيُّ','Yüceler yücesi, çok yüce.','110','Zilletten kurtulmak, ilim derecelerin artması için'),
 (38,37,'El-Kebîr','الْكَبِيرُ','Büyüklükte benzeri yok, pek büyük.','232','Maddî ve manevî büyüklük, hürmet sahibi olmak için'),
 (39,38,'El-Hafîz','الْحَفِيظُ','Her şeyi koruyucu olan.','998','Nefsinin ve malının korunması için'),
 (40,39,'El-Mukît','المُقيِت','Rızıkları yaratan.','550','Muhtaç olunan şeyi kazanmak ve rızık için'),
 (41,40,'El-Hasîb','الْحسِيبُ','Kulların hesabını en iyi gören.','80','Herkese karşı açık alınlı olmak.'),
 (42,41,'El-Celîl','الْجَلِيلُ','Celal ve azamet sahibi olan.','73-5.329','Gerçek yüceliğe erişmek, zalim ve zorbayı zelil etmek için'),
 (43,42,'El-Kerîm','الْكَرِيمُ','Keremi, lütuf ve ihsânı bol, karşılıksız veren, çok ikram eden.','270','Bol rızık sahibi olmak, cömert olmak ve kolaylıklara nail olmak için'),
 (44,43,'Er-Rakîb','الرَّقِيبُ','Her varlığı, her işi her an gözeten. Bütün işleri murakabesi altında bulunduran.','312','Her işte Allah’ın koruması altında olmak, bunu hissetmek, hafızasının kuvvetlenmesi için'),
 (45,44,'El-Mücîb','الْمُجِيبُ','Duaları, istekleri kabul eden.','55-3.025','Duaların kabul olunması için'),
 (46,45,'El-Vâsi’','الْوَاسِعُ','Rahmet ve kudret sahibi, ilmi ile her şeyi ihata eden.','137','Ömür uzunluğu, sıhhat ve rızık genişliği için.'),
 (47,46,'El-Hakîm','الْحَكِيمُ','Her işi hikmetli, her şeyi hikmetle yaratan.','78-6.084','İlim ve hikmet sahibi olmak, uzağı görmek, hikmetli iş yapmak için'),
 (48,47,'El-Vedûd','الْوَدُودُ','İyiliği seven, iyilik edene ihsan eden. Sevgiye layık olan.','20-400','İnsanların sevgisini kazanmak için'),
 (49,48,'El-Mecîd','الْمَجِيدُ','Nimeti, ihsanı sonsuz, şerefi çok üstün, her türlü övgüye layık bulunan.','57-3.249','İzzet ve şerefin artması için'),
 (50,49,'El-Bâis','الْبَاعِثُ','Mahşerde ölüleri dirilten, Peygamber gönderen.','573','Kuvvetli irade ve alacaklarını almak için'),
 (51,50,'Eş-Şehîd','الشَّهِيدُ','Zamansız, mekansız hiçbir yerde olmayarak her zaman her yerde hazır ve nazır olan.','319','Şehid olmak, heybetli olmak, halk arasında sevilmek için'),
 (52,51,'El-Hakk','الْحَقُّ','Varlığı hiç değişmeden duran. Var olan, hakkı ortaya çıkaran.','108','Sağlam bir imana ve doğru bir ibadet hayatına sahip olmak, başladığı işin sonunun gelmesi için'),
 (53,52,'El-Vekîl','الْوَكِيلُ','Kulların işlerini bitiren. Kendisine tevekkül edenlerin işlerini en iyi neticeye ulaştıran.','66','Allah’tan her türlü yardım görmek için'),
 (54,53,'El-Kavî','الْقَوِيُّ','Kudreti en üstün ve hiç azalmaz.','116','Kansızlık ve vücudun güçlü olması, zor işleri kolaylıkla halletmek için'),
 (55,54,'El-Metîn','الْمَتِينُ','Kuvvet ve kudret menbaı, pek güçlü.','500','Maddî ve manevî dayanıklı, sağlam ve iradeli olmak, hastalıklardan kurtulmak için'),
 (56,55,'El-Veliyy','الْوَلِيُّ','Müslümanların dostu, onları sevip yardım eden.','46-2.116','Her işte Allah’ın yardımını istemek için'),
 (57,56,'El-Hamîd','الْحَمِيدُ','Her türlü hamd ve senaya layık olan.','62-3.844','Kazancın genişlemesi, Allah’ı çokça hamd etmek için yardım istemek için'),
 (58,57,'El-Muhsî','الْمُحْصِي','Yarattığı ve yaratacağı bütün varlıkların sayısını bilen.','148','Zekânın kuvvetli olması için'),
 (59,58,'El-Mübdi','الْمُبْدِئُ','Maddesiz, örneksiz yaratan.','57','Her işte muvaffak olmak, ummadığı yerden yardım gelmesi'),
 (60,59,'El-Muîd','الْمُعِيدُ','Yarattıklarını yok edip, sonra tekrar diriltecek olan.','124','Elden kaçanı geri kazanmak, Allah’ın ahirette yeniden dirilme hakikatini ruhlarımıza duyurması için'),
 (61,60,'El-Muhyî','الْمُحْيِي','İhya eden, yarattıklarına can veren.','68','İşlerin başarılı olması, hastalıklardan kurtulmak için'),
 (62,61,'El-Mumît','اَلْمُمِيتُ','Her canlıya ölümü tattıran.','490','Harama bakmamak, kötülüklerden vazgeçmek, devamlı ahireti hatırlamak için'),
 (63,62,'El-Hay','الْحَيُّ','Ezeli ve ebedi bir hayat ile diri olan.','18-324','Sözün tesirli olması, sözü dinlenir olmak için'),
 (64,63,'El-Kayyûm','الْقَيُّومُ','Mahlukları varlıkta durduran, zatı ile kaim olan.','156','Bütün işlerde yardımı Allah’tan beklemek, isteklere nail olmak, rızkın devamlı olması için'),
 (65,64,'El-Vâcid','الْوَاجِدُ','Kendisinden hiçbir şey gizli kalmayan, hiçbir şeye muhtaç olmayan.','14-196','Aradığını ve kaybettiğini bulmak.'),
 (66,65,'El-Mâcid','الْمَاجِدُ','Kadri ve şânı büyük, keremi, ihsanı bol olan.','48','Kazancın bolluğu ve şerefli bir hayat sahibi olmak için'),
 (67,66,'El-Vâhid','اَلاَحَدُ','Zat, sıfat ve fiillerinde benzeri ve ortağı olmayan, tek olan.','19-3.669','Kalbin uyanıklığı, isteklerin olması için'),
 (68,67,'El-Ehad','الْواحِدُ','Zat, sıfat ve fiillerinde benzeri ve ortağı olmayan, tek olan.','19-3.669','Kalbin uyanıklığı, isteklerin olması için'),
 (69,68,'Es-Samed','الصَّمَدُ','Hiçbir şeye ihtiyacı olmayan, herkesin muhtaç olduğu merci.','134','Hiç kimseye muhtaç olmamak için'),
 (70,69,'El-Kâdir','الْقَادِرُ','Dilediğini dilediği gibi yaratmaya muktedir olan.','305','İstediğini yapmaya güç yetirmek için'),
 (71,70,'El-Muktedir','الْمُقْتَدِرُ','Dilediği gibi tasarruf eden, her şeyi kolayca yaratan kudret sahibi.','744','Her işte başarılı olmak için'),
 (72,71,'El-Mukaddim','الْمُقَدِّمُ','Dilediğini yükselten, öne geçiren, öne alan.','184','Daima yükselmek için'),
 (73,72,'El-Muahhir','الْمُؤَخِّرُ','Dilediğini alçaltan, sona, geriye bırakan.','847','Kötü ve belalı birinin veya bir işin kendinden uzaklaşması için'),
 (74,73,'El-Evvel','الأوَّلُ','Ezeli olan, varlığının başlangıcı olmayan.','37','Her hayır işinde birinci olmak için'),
 (75,74,'El-Âhir','الآخِرُ','Ebedi olan, varlığının sonu olmayan.','801','Ömrün uzun olması için'),
 (76,75,'Ez Zâhir','الظَّاهِرُ','Yarattıkları ile varlığı açık, aşikâr olan, kesin delillerle bilinen.','1.106','Her meselenin zuhuru, açıklığı, gizli olmaması için'),
 (77,76,'El-Bâtın','الْبَاطِنُ','Aklın tasavvurundan gizli olan.','62','Nefsi mutmain ve kalbi geniş olmak, iç rahatlığının artması için'),
 (78,77,'El-Vâlî','الْوَالِي','Bütün kâinatı idare eden, onların işlerini yoluna koyan.','47','Sözünün tesirli olması, insanların kendini sevmesi için'),
 (79,78,'El-Müteâlî','الْمُتَعَالِي','Son derece yüce olan.','551','İstediği makama gelmek ve yüceliğe ermek için'),
 (80,79,'El-Berr','الْبَرُّ','İyilik ve ihsanı bol olan.','202','Her halukarda iyilik bulmak için'),
 (81,80,'Et-Tevvâb','التَّوَابُ','Tevbeleri kabul edip, günahları bağışlayan.','409','Tövbelerin kabul olması için'),
 (82,81,'El-Müntekım','الْمُنْتَقِمُ','Asilerin, zalimlerin cezasını veren.','630','Zulüm ve fenalıklardan korunmak için'),
 (83,82,'El-Afuvv','العَفُوُّ','Affı çok olan, günahları mağfiret eden.','156','Rızık bolluğu, kalp huzuru, affedilmek için'),
 (84,83,'Er-Raûf','الرَّؤُوفُ','Çok merhametli, pek şefkatli.','287','Merhametinin artması, hiçbir varlıktan zarar görmemek için'),
 (85,84,'Mâlikü’l-Mülk','مَالِكُ الْمُلْكِ','Mülkün, her varlığın sahibi.','212','Mal ve kazanca zarar gelmemesi, maddî ve manevî derecelerin artması için'),
 (86,85,'Zü’l-Celâli ve’l-İkrâm','ذُوالْجَلاَلِ وَالإكْرَامِ','Celal, azamet, şeref, kemal ve ikram sahibi.','1.100','İşlerin kolay ve âsân olması, insanların kendini sevmesi için'),
 (87,86,'El-Muksit','الْمُقْسِطُ','Mazlumların hakkını alan, adaletle hükmeden, her işi birbirine uygun yapan.','209','Eşlerin arasını düzeltmek ve adaletli olmak için'),
 (88,87,'El-Câmi','الْجَامِعُ','İki zıttı bir arada bulunduran. Kıyamette her mahlûkatı bir araya toplayan.','114','Küsleri barıştırmak ve hayırların birleşip toplanması için'),
 (89,88,'El-Ganî','الْغَنِيُّ','İhtiyaçsız, muhtaç olmayan, her şey Ona muhtaç olan.','1.060','Gerçek zenginlik, servet ve geniş rızık, insanlar tarafından sevilmek.'),
 (90,89,'El-Muğnî','الْمُغْنِي','Müstağni kılan. İhtiyaç gideren, zengin eden.','1.100','Geçim genişliği, bol rızık ve zenginlik için'),
 (91,90,'El-Mâni’','اَلْمَانِعُ','Dilemediği şeye mani olan, engelleyen.','161','Kaza ve belalardan emin olmak için'),
 (92,91,'Ed-Dârr','الضَّارَّ','Elem, zarar verenleri yaratan.','1.001','Zararlı kişilerden emin olmak ve onları Allah’a havale etmek için'),
 (93,92,'En-Nâfi’','النَّافِعُ','Fayda veren şeyleri yaratan.','201','Hastalıklardan korunmak, şifa bulmak, zararlardan uzak durmak için'),
 (94,93,'En-Nûr','النُّورُ','Âlemleri nurlandıran, dilediğine nur veren.','256','Doğruyu ve yanlışı görüp kalp nuruna sahip olmak için'),
 (95,94,'El-Hâdî','الْهَادِي','Hidayet veren.','20-400','Doğru yolu bulmak ve çocuklarının serkeş olmaması için'),
 (96,95,'El-Bedî’','الْبَدِيعُ','Misalsiz, örneksiz harikalar yaratan. (Eşi ve benzeri olmayan).','86','Allah’ın yardımına nail olmak, maddî ve manevî güzellik için için'),
 (97,96,'El-Bâkî','اَلْبَاقِي','Varlığının sonu olmayan, ebedi olan.','113','Ömrün uzunluğu ve sağlıklı olmak için'),
 (98,97,'El-Vâris','الْوَارِثُ','Her şeyin asıl sahibi olan.','707','Uzun ömür, bol mal, şeref ve rızık sahibi olmak için'),
 (99,98,'Er-Reşîd','الرَّشِيدُ','İrşada muhtaç olmayan, doğru yolu gösteren.','514','Güzel ahlâk sahibi olmak, kötü alışkanlıklardan korunmak için'),
 (100,99,'Es-Sabûr','الصَّبُورُ','Ceza vermede, acele etmeyen.','298','Başladığı işi kolay bitirmek, sinirini yenmek ve sabırlı olmak için');""");
    await txn.execute("""INSERT INTO "IslamicInfoTitle" ("id","title","description","type") VALUES (1,'Sıfat-ı zatiyye','Allahü teâlânın zatına mahsus olan sıfatlardır. Bu sıfatlar, mahlûkların hiçbirinde yoktur. Bunların mahlûklara, hiçbir şekilde bağlantıları da yoktur.',1),
 (2,'Sıfat-ı sübûtiyye','Mahlûklarla bağlantılı olan sıfatlardır. Bunlardan, yaratmak sıfatı hariç, diğerlerinden kullarına da sınırlı olarak ihsan etmiştir. Bu sıfatlarında da, hiç değişiklik olmaz. Bunlar da, zati sıfatlar gibi kadim yani ezelidirler. Mahlûklar sonradan yaratıldığı için, mahlûklara olan bağlantıları ise hâdistir, yani ezeli değildir. Onun diri olması, bilmesi, işitmesi, görmesi, kudreti, dilemesi ve söylemesi kullarınkine hiç benzemez, bunların sadece isimleri benzer. Onun zatını ve sıfatlarının hakikatini anlamak mümkün değildir.',1),
 (3,'İmanın şartları',NULL,2),
 (4,'İslamın şartları',NULL,2),
 (5,'Namazın farzları',NULL,2),
 (6,'Abdestin farzları',NULL,2),
 (7,'Guslün farzları',NULL,2),
 (8,'Teyemmümün farzları',NULL,2),
 (9,'54 farz',NULL,3),
 (10,'Ef’âl-i mükellefîn','Müslümanın yapması ve sakınması gereken, İslam dininin bildirdiği emir ve yasakların hepsine Ef’âl-i mükellefîn denir. Buna İslamî hükümler de denir.',4);""");
    await txn.execute("""
INSERT INTO "IslamicInfoItem" ("id","titleId","name","description") VALUES (1,1,'Vücûd','Allahü teâlâ vardır. Varlığı ezelidir. Vacib-ül vücûddür, yani varlığı lazımdır.'),
 (2,1,'Kıdem',' Allahü teâlânın varlığının evveli, başlangıcı yoktur.'),
 (3,1,'Bekâ','Allahü teâlânın varlığının âhiri, sonu yoktur. Hiç yok olmaz. Ortağı olmak muhal olduğu gibi, zat ve sıfatları için de yokluk muhaldir'),
 (4,1,'Vahdaniyyet','Allahü teâlânın zatında, sıfatlarında ve işlerinde ortağı, benzeri yoktur'),
 (5,1,'Muhalefetün-lilhavadis','Allahü teâlâ, zatında ve sıfatlarında hiçbir mahlûkun zat ve sıfatlarına benzemez'),
 (6,1,'Kıyâm bi-nefsihi','Allahü teâlâ zatı ile kâimdir. Mekana muhtaç değildir. Madde ve mekan yok iken O var idi. Zira her ihtiyaçtan münezzehtir. Bu kâinatı yokluktan varlığa getirmeden önce, zatı nasıl idi ise, sonsuz olarak, hep öyledir.'),
 (7,2,'Hayat','Allahü teâlâ diridir. Hayatı, mahlûkların hayatına benzemeyip, zatına layık ve mahsus olan hayat, ezeli ve ebedidir.'),
 (8,2,'İlm','Allahü teâlâ her şeyi bilir. Bilmesi mahlûkatın bilmesi gibi değildir. Karanlık gecede, karıncanın, kara taş üzerinde yürüdüğünü görür ve bilir. İnsanların kalbinden geçen düşüncelerini, niyetlerini bilir. Bilmesinde değişiklik olmaz. Ezeli ve ebedidir'),
 (9,2,'Sem’','Allahü teâlâ işitir. Vasıtasız, cihetsiz işitir. İşitmesi, kulların işitmesine benzemez. Bu sıfatı da, her sıfatı gibi ezeli ve ebedidir.'),
 (10,2,'Basar','Allahü teâlâ görür. Âletsiz ve şartsız görür. Görmesi göz ile değildir.'),
 (11,2,'İrade','Allahü teâlânın dilemesi vardır. Dilediğini yaratır. Her şey Onun dilemesi ile var olur. İradesine engel olacak hiçbir kuvvet yoktur.'),
 (12,2,'Kudret','Allahü teâlâ, her şeye gücü yeticidir. Hiçbir şey Ona güç gelmez.'),
 (13,2,'Kelam','Allahü teâlâ söyleyicidir. Söylemesi alet, harfler, sesler ve dil ile değildir.'),
 (14,2,'Tekvîn','Allahü teâlâ yaratıcıdır. Ondan başka yaratıcı yoktur. Her şeyi O yaratır. Allahü teâlâdan başkası için yaratıcı dememelidir.'),
 (15,3,'1','Allahü teâlânın varlığına ve birliğine inanmak'),
 (16,3,'2','Meleklerine inanmak'),
 (17,3,'3','Allahü teâlânın indirdiği Kitaplarına inanmak'),
 (18,3,'4','Allahü teâlânın Peygamberlerine inanmak'),
 (19,3,'5','Ahiret gününe inanmak'),
 (20,3,'6','Kadere, yani hayır ve şerlerin (iyilik ve kötülüklerin) Allahü teâlâdan olduğuna inanmak'),
 (21,4,'7','Kelime-i şehadet getirmek'),
 (22,4,'8','Her gün beş kere vakti gelince namaz kılmak'),
 (23,4,'9','Malın zekatını vermek'),
 (24,4,'10','Ramazan ayında her gün oruç tutmak'),
 (25,4,'11','Gücü yetenin ömründe bir kere hac etmesidir'),
 (26,5,'12','Hadesten taharet'),
 (27,5,'13','Necasetten taharet'),
 (28,5,'14','Setr-i avret'),
 (29,5,'15','İstikbal-i Kıble'),
 (30,5,'16','Vakit'),
 (31,5,'17','Niyet'),
 (32,5,'18','İftitah veya Tahrime tekbiri'),
 (33,5,'19','Kıyam'),
 (34,5,'20','Kıraat'),
 (35,5,'21','Rüku'),
 (36,5,'22','Secde'),
 (37,5,'23','Ka’de-i ahire'),
 (38,6,'24','Abdest alırken yüzü yıkamak'),
 (39,6,'25','Elleri dirsekleri ile birlikte yıkamak'),
 (40,6,'26','Başın dörtte birini mesh etmek'),
 (41,6,'27',' Ayakları topukları ile birlikte yıkamak'),
 (42,7,'28','Ağzı yıkamak'),
 (43,7,'29','Burnu yıkamak'),
 (44,7,'30','Bütün bedeni yıkamak'),
 (45,8,'31','Niyet etmek'),
 (46,8,'32','İki elin içini temiz toprağa sürüp, yüzün tamamını mesh etmek.

Tekrar elleri temiz toprağa vurup, önce sağ ve sonra sol kolu mesh etmek.

Teyemmümün farzı üçtür diyenlere göre, bu son ikisi, iki ayrı farz olarak söylenir.'),
 (47,9,'1','Allahü teâlâyı bir bilip, Onu hiç unutmamak'),
 (48,9,'2','Helalinden yiyip içmek'),
 (49,9,'3','Abdest almak'),
 (50,9,'4','Her gün vakti gelince, Beş vakit namaz kılmak'),
 (51,9,'5','Hayzdan, nifastan ve cünüplükten gusletmek'),
 (52,9,'6','Kişinin rızkına, Allahü teâlânın kefil olduğuna inanmak'),
 (53,9,'7','Helalinden temiz elbise giymek'),
 (54,9,'8','Hakka tevekkül ederek çalışmak'),
 (55,9,'9','Kanaat etmek'),
 (56,9,'10','Nimetleri için, Allahü teâlâya şükretmek [nimetlerini emrolunan yerlerde kullanmak]'),
 (57,9,'11','Kaza ve kadere razı olmak'),
 (58,9,'12','Belalara sabretmek [isyan etmemek]'),
 (59,9,'13','Günahlardan tevbe etmek'),
 (60,9,'14','İhlasla ibadet etmek'),
 (61,9,'15','İslam düşmanlarını düşman bilmek'),
 (62,9,'16','Kur''an-ı kerimi dört delilden biri bilmek'),
 (63,9,'17','Ölüme hazırlanmak yani farzları yapıp haramlardan kaçarak imanla ölmeye çalışmak'),
 (64,9,'18','Allahü teâlânın sevdiğini sevip, sevmediğini sevmemek ve bundan kaçmak'),
 (65,9,'19','Ana babaya iyilik etmek'),
 (66,9,'20','Gücü yetenlerin, imkanı nispetinde dinin emirlerini yaymaya çalışması'),
 (67,9,'21','Mahrem olan salih akrabayı ziyaret etmek'),
 (68,9,'22','Emanete hıyanet etmemek'),
 (69,9,'23','Daima, Allah’tan korkarak, haramlardan sakınmak'),
 (70,9,'24','Allah’a ve Resulüne itaat etmek'),
 (71,9,'25','Günahtan kaçıp, ibadet ile meşgul olmak'),
 (72,9,'26','Hükümdara karşı gelmemek'),
 (73,9,'27','Âleme ibretle bakmak'),
 (74,9,'28','Allahü teâlânın varlığını tefekkür etmek'),
 (75,9,'29','Dilini haram, fuhuş olan sözlerden korumak'),
 (76,9,'30','Kalbini dünyanın faydasız şeylerinden, zararlı isteklerinden temizlemek'),
 (77,9,'31','Hiç kimseyi alay etmemek'),
 (78,9,'32','Harama bakmamak'),
 (79,9,'33','Hep sözüne sadık olmak'),
 (80,9,'34','Kulağını fuhuş söz ve çalgıdan korumak'),
 (81,9,'35','Farzları ve haramları öğrenmek'),
 (82,9,'36','Tartı, ölçü aletlerini, doğru olarak kullanmak'),
 (83,9,'37','Allahü teâlânın azabından emin olmayıp daima korkmak'),
 (84,9,'38','Allahü teâlânın rahmetinden, ümidini kesmemek'),
 (85,9,'39','Müslüman fakirlerine zekat vermek ve yardım etmek'),
 (86,9,'40','Nefsin haram olan isteklerine uymamak'),
 (87,9,'41','Aç olanı Allah rızası için doyurmak'),
 (88,9,'42','Yetecek kadar rızık [yiyecek, giyecek ve ev] için çalışmak'),
 (89,9,'43','Malının zekatını, ürünlerinin uşrunu vermek'),
 (90,9,'44','Âdetli ve lohusa halinde bulunan hanımı ile ilişkide bulunmamak'),
 (91,9,'45','Kalbini günahlardan temizlemek'),
 (92,9,'46','Kibirli olmaktan sakınmak'),
 (93,9,'47','Yetim çocuğun malını korumak'),
 (94,9,'48','Genç oğlanlara, şehvete sebep olacak durum ve hareketlerden uzak durmak'),
 (95,9,'49','Günlük vakit namazlarını kazaya bırakmamak'),
 (96,9,'50','Şirk koşmamak'),
 (97,9,'51','Zinadan kaçınmak'),
 (98,9,'52','Alkollü içki içmemek'),
 (99,9,'53','Boş yere yemin etmemek'),
 (100,9,'54','Haksız yere, zulümle yani gayrimeşru olarak başkasının malını almamak. Kul hakkından korkmak'),
 (101,10,'FARZ','Yapılması açıkça ve kesin olarak bildirilen dinin emirlerine farz denir. Farzları terk etmek haramdır, yani büyük günahtır.

Farz iki çeşittir:

Farzı Ayn: Her Müslümanın bizzat kendisinin yapması lazım olan farzdır. Mesela, iman etmek, beş vakit namaz kılmak, Ramazan ayında oruç tutmak, zengin ise zekat vermek ve hacca gitmek, farzı ayndır. [32 farz ve 54 farz meşhurdur.]

Farzı Kifaye: Bir veya birkaç Müslümanın yapması ile diğerlerinin sorumluluktan kurtulduğu farzlardır. Verilen selamı almak, cenazeyi yıkamak, cenaze namazı kılmak, sanatına, ticaretine lazım olandan fazla din ve fen bilgilerini öğrenmek gibi farzlar böyledir'),
 (102,10,'VACİP','Yapılması farz gibi kesin olan emirlere denir. Bunların delilleri farz gibi açık ve kesin değildir. Vitir namazını ve Bayram namazlarını kılmak, zengin olunca kurban kesmek, sadaka-i fıtr vermek vaciptir. Vacibin hükmü farz gibidir. Vacibi terk etmek, tahrimen mekruhtur. Vacip olduğuna inanmayan kâfir olmaz. Fakat, yapmayan azaba layık olur.'),
 (103,10,'SÜNNET','Peygamber efendimizin yapılmasını övdüğü, yahut devam üzere kendisinin yaptığı veyahut yapılırken görüp de mani olmadığı şeylere “Sünnet” denir. Sünneti beğenmemek küfürdür. Beğenip de yapmayana azap olmaz.

Sünnet iki çeşittir:

Sünnet-i Müekkede: Peygamber efendimizin devamlı yaptıkları, pek az terk ettikleri kuvvetli sünnetlerdir. Sabah namazının sünneti, öğlenin ilk ve son sünnetleri, akşam namazının sünneti, yatsı namazının son iki rekat sünneti böyledir. Bu sünnetler, asla özürsüz terk olunmaz.

Sünnet-i gayri müekkede: Peygamber efendimizin, ibadet maksadı ile ara sıra yaptıklarıdır. İkindi ve yatsı namazlarının dört rekatlık ilk sünnetleri böyledir. Bunlar çok kere terk olunursa, bir şey lazım gelmez. Beş-on kimseden biri işlese, diğer Müslümanlardan sakıt olan sünnetlere de “Sünnet-i alel-kifaye” denir. Selam vermek, ezan okumak gibi.'),
 (104,10,'MÜSTEHAP','Peygamber efendimizin sevdiği, beğendiği hususlardır. Doğan çocuk için akika hayvanı kesmek, güzel giyinmek, güzel koku sürünmek müstehaptır. Bunları yapana sevap verilir, yapmayan günaha girmez.'),
 (105,10,'MUBAH','Yapılması emir olunmayan ve yasak da edilmeyen şeylere mubah denir. İyi niyetle işlenmesinde sevap, kötü niyetle işlenmesinde azap vardır. Uyumak, helalinden çeşitli şeyler yiyip içmek, helalinden çeşitli elbiseler giyinmek gibi işler, mubahtır. Bunlar, İslamiyet''e uymak, emirlere sarılmak niyetiyle yapılırsa sevap olur. Sıhhatli olup, ibadet yapmaya niyet ederek, yemek içmek böyledir.'),
 (106,10,'HARAM','Dinimizde “yapmayınız” diye açıkça yasak edilen şeylerdir. Haramların yapılması ve kullanılması kesinlikle yasaklanmıştır. Haram olan şeyleri terk etmek, onlardan sakınmak farzdır ve çok sevaptır.

Haram iki çeşittir:

Haram li-aynihi: Adam öldürmek, kumar oynamak, şarap ve her türlü alkollü içki içmek, yalan söylemek, hırsızlık yapmak, domuz eti, kan ve leş yemek gibi şeyler haram olup, büyük günahtır.
Haram li-gayrihi: Bunlar asılları itibariyle helal olup, başkasının haklarından dolayı haram olan şeylerdir. Mesela bir kişinin bağına girip, sahibinin izni yok iken meyvesini koparıp yemek, ev eşyasını ve parasını çalıp kullanmak, emanete hıyanet etmek, rüşvet, faiz ve kumar ile mal, para kazanmak gibi. Haramlardan kaçınmak, ibadet yapmaktan daha çok sevaptır. Onun için haramları öğrenip, kaçınmak lazımdır.'),
 (107,10,'MEKRUH','İbadetlerin sevabını gideren şeylere mekruh denir.

Mekruh iki çeşittir:

Tahrimen mekruh: Vacibin terkidir. Harama yakın olan mekruhlardır. Bunları yapmak azabı gerektirir. Güneş doğarken, tam tepede iken ve batarken namaz kılmak gibi. Bunları kasıtla işleyen asi ve günahkâr olur. Cehennem azabına layık olur. Namazda vacipleri terk edenin, tahrimen mekruhları işleyenin, o namazı iade etmesi vaciptir. Eğer unutarak işlerse, secde-i sehv, yani unutma secdesi gerekir.

Tenzihen mekruh: Mubah, yani helal olan işlere yakın olan, yahut, yapılmaması yapılmasından daha iyi olan işlerdir. Gayri müekked sünnetleri veya müstehapları yapmamak gibi.'),
 (108,10,'MÜFSİD','Dinimizde, meşru olan bir işi veya başlanmış olan bir ibadeti bozan şeylerdir. İmanı ve namazı, nikahı ve haccı, zekatı, alış ve satışı bozmak gibi. Mesela, dine imana sövmek küfür olup, imanı bozar. Namazda gülmek, abdesti ve namazı bozar. Oruçlu iken bilerek yemek, içmek orucu bozar.

Farzları, vacipleri ve sünnetleri yapana ve haramdan, mekruhtan sakınana sevap verilir. Haramları, mekruhları yapan ve farzları, vacipleri yapmayana günah yazılır. Bir haramdan sakınmanın sevabı, bir farzı yapmanın sevabından kat kat çoktur. Bir farzın sevabı, bir mekruhtan sakınmanın sevabından çoktur. Mekruhtan sakınmanın sevabı da, sünnetin sevabından çoktur.')""");
    await txn.execute("""INSERT INTO "PrayerQuran" ("id","arabicContent","meaningContent","source") VALUES (1,'اَلْحَمْدُ لِلّٰهِ رَبِّ الْـعَالَمٖينَۙ ﴿﴾ اَلرَّحْمٰنِ الرَّحٖيمِۙ ﴿﴾ مَالِكِ يَوْمِ الدّٖينِؕ ﴿﴾ اِيَّاكَ نَعْبُدُ وَاِيَّاكَ نَسْتَعٖينُؕ ﴿﴾ اِهْدِنَا الصِّرَاطَ الْمُسْتَقٖيمَۙ ﴿﴾ صِرَاطَ الَّذٖينَ اَنْعَمْتَ عَلَيْهِمْۙ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّٓالّٖينَ','Hamd, Âlemlerin Rabbi, Rahmân, Rahîm, hesap ve ceza gününün (ahiret gününün) maliki Allah''a mahsustur.. (Allahım!) Yalnız sana ibadet ederiz ve yalnız senden yardım dileriz.. Bizi doğru yola, kendilerine nimet verdiklerinin yoluna ilet; gazaba uğrayanlarınkine ve sapıklarınkine değil.','Fâtiha 2-7'),
 (2,'قَالُوا سُبْحَانَكَ لَا عِلْمَ لَنَٓا اِلَّا مَا عَلَّمْتَنَاؕ اِنَّكَ اَنْتَ الْعَلٖيمُ الْحَكٖيمُ','Melekler, "Seni bütün eksikliklerden uzak tutarız. Senin bize öğrettiklerinden başka bizim hiçbir bilgimiz yoktur. Şüphesiz her şeyi hakkıyla bilen, her şeyi hikmetle yapan sensin" dediler.','Bakara 32'),
 (3,'وَاِذْ يَرْفَعُ اِبْرٰهٖيمُ الْقَوَاعِدَ مِنَ الْبَيْتِ وَاِسْمٰعٖيلُؕ رَبَّنَا تَقَبَّلْ مِنَّاؕ اِنَّكَ اَنْتَ السَّمٖيعُ الْعَلٖيمُ ﴿﴾ رَبَّنَا وَاجْعَلْنَا مُسْلِمَيْنِ لَكَ وَمِنْ ذُرِّيَّتِنَٓا اُمَّةً مُسْلِمَةً لَكَࣕ وَاَرِنَا مَنَاسِكَنَا وَتُبْ عَلَيْنَاۚ اِنَّكَ اَنْتَ التَّوَّابُ الرَّحٖيمُ','Hani İbrahim, İsmail ile birlikte evin (Kâbe''nin) temellerini yükseltiyor, "Ey Rabbimiz! Bizden kabul buyur! Şüphesiz sen hakkıyla işitensin, hakkıyla bilensin" diyorlardı.. "Rabbimiz! Bizi sana teslim olmuş kimseler kıl. Soyumuzdan da sana teslim olmuş bir ümmet kıl. Bize ibadet yerlerini ve ilkelerini göster. Tövbemizi kabul et. Çünkü sen, tövbeleri çok kabul edensin, çok merhametli olansın."','Bakara 127-128'),
 (4,'وَمِنْهُمْ مَنْ يَقُولُ رَبَّنَٓا اٰتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْاٰخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ','Onlardan, "Rabbimiz! Bize dünyada da iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru" diyenler de vardır.','Bakara 201'),
 (5,'وَلَا تَنْكِحُوا الْمُشْرِكَاتِ حَتّٰى يُؤْمِنَّؕ وَلَاَمَةٌ مُؤْمِنَةٌ خَيْرٌ مِنْ مُشْرِكَةٍ وَلَوْ اَعْجَبَتْكُمْۚ وَلَا تُنْكِحُوا الْمُشْرِكٖينَ حَتّٰى يُؤْمِنُواؕ وَلَعَبْدٌ مُؤْمِنٌ خَيْرٌ مِنْ مُشْرِكٍ وَلَوْ اَعْجَبَكُمْؕ اُو۬لٰٓئِكَ يَدْعُونَ اِلَى النَّارِۚ وَاللّٰهُ يَدْعُٓوا اِلَى الْجَنَّةِ وَالْمَغْفِرَةِ بِاِذْنِهٖۚ وَيُبَيِّنُ اٰيَاتِهٖ لِلنَّاسِ لَعَلَّهُمْ يَتَذَكَّرُونَࣖ','İman etmedikleri sürece Allah''a ortak koşan kadınlarla evlenmeyin. Allah''a ortak koşan kadın hoşunuza gitse de, mü''min bir cariye Allah''a ortak koşan bir kadından daha hayırlıdır.  İman etmedikleri sürece Allah''a ortak koşan erkeklerle, kadınlarınızı evlendirmeyin. Allah''a ortak koşan hür erkek hoşunuza gitse de, iman eden bir köle, Allah''a ortak koşan bir erkekten daha hayırlıdır. Onlar ateşe çağırırlar, Allah ise izniyle, cennete ve bağışlanmaya çağırır. O, insanlara âyetlerini açıklar ki, öğüt alıp düşünsünler.','Bakara 221'),
 (6,'وَلَمَّا بَرَزُوا لِجَالُوتَ وَجُنُودِهٖ قَالُوا رَبَّنَٓا اَفْرِ غْ عَلَيْنَا صَبْراً وَثَبِّتْ اَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرٖينَؕ','(Tâlût''un askerleri) Câlût ve askerleriyle karşı karşıya gelince şöyle dediler: "Ey Rabbimiz! Üzerimize sabır yağdır, ayaklarımızı sağlam bastır ve şu kâfir kavme karşı bize yardım et."','Bakara 250'),
 (7,'اٰمَنَ الرَّسُولُ بِمَٓا اُنْزِلَ اِلَيْهِ مِنْ رَبِّهٖ وَالْمُؤْمِنُونَؕ كُلٌّ اٰمَنَ بِاللّٰهِ وَمَلٰٓئِكَتِهٖ وَكُتُبِهٖ وَرُسُلِهٖؕ لَا نُفَرِّقُ بَيْنَ اَحَدٍ مِنْ رُسُلِهٖࣞ  وَقَالُوا سَمِعْنَا وَاَطَعْنَا غُفْرَانَكَ رَبَّنَا وَاِلَيْكَ الْمَصٖيرُ ﴿﴾ لَا يُكَلِّفُ اللّٰهُ نَفْساً اِلَّا وُسْعَهَاؕ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْؕ رَبَّنَا لَا تُؤَاخِذْنَٓا اِنْ نَسٖينَٓا اَوْ اَخْطَأْنَاۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَٓا اِصْراً كَمَا حَمَلْتَهُ عَلَى الَّذٖينَ مِنْ قَبْلِنَاۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهٖۚ وَاعْفُ عَنَّاࣞ وَاغْفِرْ لَنَاࣞ وَارْحَمْنَاࣞ اَنْتَ مَوْلٰينَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرٖينَ','Peygamber, Rabbinden kendisine indirilene iman etti, mü''minler de (iman ettiler). Her biri; Allah''a, meleklerine, kitaplarına ve peygamberlerine iman ettiler ve şöyle dediler: "Onun peygamberlerinden hiçbirini (diğerinden) ayırt etmeyiz." Şöyle de dediler: "İşittik ve itaat ettik. Ey Rabbimiz! Senden bağışlama dileriz. Sonunda dönüş yalnız sanadır.". Allah bir kimseyi ancak gücünün yettiği şeyle yükümlü kılar. Onun kazandığı iyilik kendi yararına, kötülük de kendi zararınadır. (Şöyle diyerek dua ediniz): "Ey Rabbimiz! Unutur, ya da yanılırsak bizi sorumlu tutma! Ey Rabbimiz! Bize, bizden öncekilere yüklediğin gibi ağır yük yükleme. Ey Rabbimiz! Bize gücümüzün yetmediği şeyleri yükleme! Bizi affet, bizi bağışla, bize acı! Sen bizim Mevlâmızsın. Kâfirler topluluğuna karşı bize yardım et."','Bakara 285-286'),
 (8,'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ اِذْ هَدَيْتَنَا وَهَبْ لَنَا مِنْ لَدُنْكَ رَحْمَةًۚ اِنَّكَ اَنْتَ الْوَهَّابُ ﴿﴾ رَبَّنَٓا اِنَّكَ جَامِعُ النَّاسِ لِيَوْمٍ لَا رَيْبَ فٖيهِؕ اِنَّ اللّٰهَ لَا يُخْلِفُ الْمٖيعَادَࣖ','(Onlar şöyle yakarırlar): "Rabbimiz! Bizi hidayete erdirdikten sonra kalplerimizi eğriltme. Bize katından bir rahmet bahşet. Şüphesiz sen çok bahşedensin.". "Rabbimiz! Şüphesiz sen, hakkında şüphe olmayan bir günde insanları toplayacaksın. Şüphesiz Allah va''dinden dönmez.','Âl-i İmrân 8-9'),
 (9,'اَلَّذٖينَ يَقُولُونَ رَبَّنَٓا اِنَّـنَٓا اٰمَنَّا فَاغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ النَّارِۚ ﴿﴾ اَلصَّابِرٖينَ وَالصَّادِقٖينَ وَالْقَانِتٖينَ وَالْمُنْفِقٖينَ وَالْمُسْتَغْفِرٖينَ بِالْاَسْحَارِ','(Bunlar), "Rabbimiz, biz iman ettik. Bizim günahlarımızı bağışla. Bizi ateş azabından koru" diyenler,Sabredenler, doğru olanlar, huzurunda gönülden boyun büküp divan duranlar, Allah yolunda harcayanlar ve seherlerde (Allah''tan) bağışlanma dileyenlerdir.','Âl-i İmrân 16-17'),
 (10,'قُلِ اللّٰهُمَّ مَالِكَ الْمُلْكِ تُؤْتِي الْمُلْكَ مَنْ تَشَٓاءُ وَتَنْزِعُ الْمُلْكَ مِمَّنْ تَشَٓاءُؗ وَتُعِزُّ مَنْ تَشَٓاءُ وَتُذِلُّ مَنْ تَشَٓاءُؕ بِيَدِكَ الْخَيْرُؕ اِنَّكَ عَلٰى كُلِّ شَيْءٍ قَدٖيرٌ','De ki: "Ey mülkün sahibi olan Allah''ım! Sen mülkü dilediğine verirsin. Dilediğinden de mülkü çeker alırsın. Dilediğini aziz edersin, dilediğini zelil edersin. Hayır senin elindedir. Şüphesiz sen her şeye hakkıyla gücü yetensin."','Âl-i İmrân 26'),
 (11,'هُنَالِكَ دَعَا زَكَرِيَّا رَبَّهُۚ قَالَ رَبِّ هَبْ لٖي مِنْ لَدُنْكَ ذُرِّيَّةً طَيِّبَةًۚ اِنَّكَ سَمٖيعُ الدُّعَٓاءِ','Orada Zekeriya Rabbine dua etti: "Rabbim! Bana katından temiz bir nesil bahşet. Şüphesiz sen duayı hakkıyla işitensin" dedi.','Âl-i İmrân 38'),
 (12,'رَبَّنَٓا اٰمَنَّا بِمَٓا اَنْزَلْتَ وَاتَّبَعْنَا الرَّسُولَ فَاكْتُبْنَا مَعَ الشَّاهِدٖينَ','"Rabbimiz! Senin indirdiğine iman ettik ve Peygamber''e uyduk.Artık bizi (hakikate) şahitlik edenlerle beraber yaz."','Âl-i İmrân 53'),
 (13,'وَمَا كَانَ قَوْلَهُمْ اِلَّٓا اَنْ قَالُوا رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَاِسْرَافَنَا فٖٓي اَمْرِنَا وَثَبِّتْ اَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرٖينَ','Onların sözleri ancak, "Rabbimiz! Bizim günahlarımızı ve işimizdeki taşkınlıklarımızı bağışla ve (yolunda) ayaklarımızı sağlam tut. Kâfir topluma karşı bize yardım et" demekten ibaretti.','Âl-i İmrân 147'),
 (14,'اَلَّذٖينَ يَذْكُرُونَ اللّٰهَ قِيَاماً وَقُعُوداً وَعَلٰى جُنُوبِهِمْ وَيَتَفَكَّرُونَ فٖي خَلْقِ السَّمٰوَاتِ وَالْاَرْضِۚ رَبَّنَا مَا خَلَقْتَ هٰذَا بَاطِلاًۚ سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ ﴿﴾ رَبَّنَٓا اِنَّكَ مَنْ تُدْخِلِ النَّارَ فَقَدْ اَخْزَيْتَهُؕ وَمَا لِلظَّالِمٖينَ مِنْ اَنْصَارٍ ﴿﴾ رَبَّنَٓا اِنَّـنَا سَمِعْنَا مُنَادِياً يُنَادٖي لِلْاٖيمَانِ اَنْ اٰمِنُوا بِرَبِّكُمْ فَاٰمَنَّاࣗ رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّـَٔاتِنَا وَتَوَفَّـنَا مَعَ الْاَبْرَارِۚ ﴿﴾ رَبَّنَا وَاٰتِنَا مَا وَعَدْتَنَا عَلٰى رُسُلِكَ وَلَا تُخْزِنَا يَوْمَ الْقِيٰمَةِؕ اِنَّكَ لَا تُخْلِفُ الْمٖيعَادَ','Onlar ayaktayken, otururken ve yanları üzerine yatarken Allah''ı anarlar. Göklerin ve yerin yaratılışı üzerinde düşünürler. "Rabbimiz! Bunu boş yere yaratmadın, seni eksikliklerden uzak tutarız. Bizi ateş azabından koru" derler.. "Rabbimiz! Sen kimi cehennem ateşine sokarsan onu rezil etmişsindir. Zalimlerin hiç yardımcıları yoktur.". "Rabbimiz! Biz, ‘Rabbinize iman edin'' diye imana çağıran bir davetçi işittik, hemen iman ettik. Rabbimiz! Günahlarımızı bağışla. Kötülüklerimizi ört. Canımızı iyilerle beraber al.". "Rabbimiz! Peygamberlerin aracılığı ile bize vadettiklerini ver bize. Kıyamet günü bizi rezil etme. Şüphesiz sen, vadinden dönmezsin."','Âl-i İmrân 191-194'),
 (15,'قَالَ عٖيسَى ابْنُ مَرْيَمَ اللّٰهُمَّ رَبَّنَٓا اَنْزِلْ عَلَيْنَا مَٓائِدَةً مِنَ السَّمَٓاءِ تَكُونُ لَنَا عٖيداً لِاَوَّلِنَا وَاٰخِرِنَا وَاٰيَةً مِنْكَۚ وَارْزُقْنَا وَاَنْتَ خَيْرُ الرَّازِقٖينَ','Meryem oğlu İsa, "Ey Allahım! Ey Rabbimiz! Bize gökten bir sofra indir ki; önce gelenlerimize (zamanımızdaki dindaşlarımıza) ve sonradan geleceklerimize bir bayram ve senden (gelen) bir mucize olsun. Bizi rızıklandır. Sen rızıklandıranların en hayırlısısın" dedi.','Mâide 114'),
 (16,'قَالَا رَبَّـنَا ظَلَمْنَٓا اَنْفُسَنَا وَاِنْ لَمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرٖينَ','Dediler ki: "Rabbimiz! Biz kendimize zulüm ettik. Eğer bizi bağışlamaz ve bize acımazsan mutlaka ziyan edenlerden oluruz."','A''râf 23'),
 (17,'وَاِذَا صُرِفَتْ اَبْصَارُهُمْ تِلْقَٓاءَ اَصْحَابِ النَّارِۙ قَالُوا رَبَّـنَا لَا تَجْعَلْنَا مَعَ الْقَوْمِ الظَّالِمٖينَࣖ','Gözleri cehennemlikler tarafına çevrildiği zaman, "Ey Rabbimiz! Bizi zalim toplumla beraber kılma" derler.','A''râf 47'),
 (18,'اُدْعُوا رَبَّكُمْ تَضَرُّعاً وَخُفْيَةًؕ اِنَّهُ لَا يُحِبُّ الْمُعْتَدٖينَۚ','Rabbinize alçak gönüllüce ve için için dua edin. Çünkü O, haddi aşanları sevmez.','A''râf 55'),
 (19,'وَمَا تَنْقِمُ مِنَّٓا اِلَّٓا اَنْ اٰمَنَّا بِاٰيَاتِ رَبِّنَا لَمَّا جَٓاءَتْنَاؕ رَبَّـنَٓا اَفْرِغْ عَلَيْنَا صَبْراً وَتَوَفَّـنَا مُسْلِمٖينَࣖ','"Sen sırf, Rabbimizin âyetleri bize geldiğinde iman ettiğimiz için bize hınç duyuyorsun. Ey Rabbimiz! Üzerimize sabır yağdır ve müslüman olarak bizim canımızı al."','A''râf 126'),
 (20,'قَالَ رَبِّ اغْفِرْ لٖي وَلِاَخٖي وَاَدْخِلْنَا فٖي رَحْمَتِكَؗ وَاَنْتَ اَرْحَمُ الرَّاحِمٖينَࣖ','(Mûsâ), "Ey Rabbim! Beni ve kardeşimi bağışla. Bizi kendi rahmetine sok. Sen merhametlilerin en merhametlisisin" dedi.','A''râf 151'),
 (21,'وَاخْتَارَ مُوسٰى قَوْمَهُ سَبْعٖينَ رَجُلاً لِمٖيقَاتِنَاۚ فَلَمَّٓا اَخَذَتْهُمُ الرَّجْفَةُ قَالَ رَبِّ لَوْ شِئْتَ اَهْلَكْتَهُمْ مِنْ قَبْلُ وَاِيَّايَؕ اَتُهْلِكُنَا بِمَا فَعَلَ السُّفَـهَٓاءُ مِنَّاۚ اِنْ هِيَ اِلَّا فِتْنَتُكَؕ تُضِلُّ بِهَا مَنْ تَشَٓاءُ وَتَهْدٖي مَنْ تَشَٓاءُؕ اَنْتَ وَلِيُّنَا فَاغْفِرْ لَنَا وَارْحَمْنَا وَاَنْتَ خَيْرُ الْغَافِرٖينَ ﴿﴾ وَاكْتُبْ لَنَا فٖي هٰذِهِ الدُّنْيَا حَسَنَةً وَفِي الْاٰخِرَةِ اِنَّا هُدْنَٓا اِلَيْكَؕ قَالَ عَذَابٖٓي اُصٖيبُ بِهٖ مَنْ اَشَٓاءُۚ وَرَحْمَتٖي وَسِعَتْ كُلَّ شَيْءٍؕ فَسَاَكْتُبُهَا لِلَّذٖينَ يَتَّقُونَ وَيُؤْتُونَ الزَّكٰوةَ وَالَّذٖينَ هُمْ بِاٰيَاتِنَا يُؤْمِنُونَۚ','Mûsâ, kavminden, belirlediğimiz yere gitmek için yetmiş adam seçti. Onları sarsıntı yakalayınca (bayıldılar). Mûsâ, "Ey Rabbim! Dileseydin onları da beni de bundan önce helak ederdin. Şimdi içimizden bir takım beyinsizlerin işledikleri günah sebebiyle bizi helak mı edeceksin? Bu sırf senin bir imtihanındır. Onunla dilediğin kimseyi saptırırsın, dilediğini de doğruya iletirsin. Sen bizim velimizsin. Artık bizi bağışla ve bize acı. Sen bağışlayanların en hayırlısısın" dedi.. "Bizim için bu dünyada da bir iyilik yaz, ahirette de. Çünkü biz sana varan doğru yola yöneldik." Allah şöyle dedi: "Azabım var ya, dilediğim kimseyi ona uğratırım. Rahmetim ise her şeyi kapsamıştır. Onu, bana karşı gelmekten sakınanlara, zekatı verenlere ve âyetlerimize inananlara yazacağım."','A''râf 155-156'),
 (22,'وَلِلّٰهِ الْاَسْمَٓاءُ الْحُسْنٰى فَادْعُوهُ بِهَاࣕ وَذَرُوا الَّذٖينَ يُلْحِدُونَ فٖٓي اَسْمَٓائِهٖؕ سَيُجْزَوْنَ مَا كَانُوا يَعْمَلُونَ','En güzel isimler Allah''ındır. O''na o güzel isimleriyle dua edin ve O''nun isimleri hakkında gerçeği çarpıtanları bırakın. Onlar yaptıklarının cezasına çarptırılacaklardır.','A''râf 180'),
 (23,'فَاِنْ تَوَلَّوْا فَقُلْ حَسْبِيَ اللّٰهُؗ لَٓا اِلٰهَ اِلَّا هُوَؕ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظٖيمِ','Eğer yüz çevirirlerse de ki: "Bana Allah yeter. O''ndan başka hiçbir ilah yoktur. Ben ancak O''na tevekkül ettim. O, yüce Arşın sahibidir."','Tevbe 129'),
 (24,'فَقَالُوا عَلَى اللّٰهِ تَوَكَّلْنَاۚ رَبَّـنَا لَا تَجْعَلْنَا فِتْنَةً لِلْقَوْمِ الظَّالِمٖينَۙ ﴿﴾ وَنَجِّنَا بِرَحْمَتِكَ مِنَ الْقَوْمِ الْكَافِرٖينَ','Onlar da şöyle dediler: "Biz yalnız Allah''a tevekkül ettik. Ey Rabbimiz, bizi zalimler topluluğunun baskı ve şiddetine maruz bırakma!". Bizi rahmetinle o kâfirler topluluğundan kurtar.','Yûnus 85-86'),
 (25,'وَقَالَ ارْكَبُوا فٖيهَا بِسْمِ اللّٰهِ مَجْرٰۭۙيهَا وَمُرْسٰيهَاؕ اِنَّ رَبّٖي لَغَفُورٌ رَحٖيمٌ','(Nûh), "Binin ona. Onun yüzüp gitmesi de durması da Allah''ın adıyladır. Şüphesiz Rabbim çok bağışlayandır, çok merhamet edendir." dedi.','Hûd 41'),
 (26,'قَالَ رَبِّ اِنّٖٓي اَعُوذُ بِكَ اَنْ اَسْـَٔلَكَ مَا لَيْسَ لٖي بِهٖ عِلْمٌؕ وَاِلَّا تَغْفِرْ لٖي وَتَرْحَمْنٖٓي اَكُنْ مِنَ الْخَاسِرٖينَ','Nûh, "Rabbim! Şüphesiz ben senden hakkında bilgim olmayan şeyi istemekten sana sığınırım. Eğer beni bağışlamaz ve bana acımazsan, şüphesiz ziyana uğrayanlardan olurum" dedi.','Hûd 47'),
 (27,'قَالَ يَا قَوْمِ اَرَاَيْتُمْ اِنْ كُنْتُ عَلٰى بَيِّنَةٍ مِنْ رَبّٖي وَرَزَقَنٖي مِنْهُ رِزْقاً حَسَناًؕ وَمَٓا اُرٖيدُ اَنْ اُخَالِفَكُمْ اِلٰى مَٓا اَنْهٰيكُمْ عَنْهُؕ اِنْ اُرٖيدُ اِلَّا الْاِصْلَاحَ مَا اسْتَطَعْتُؕ وَمَا تَوْفٖيقٖٓي اِلَّا بِاللّٰهِؕ عَلَيْهِ تَوَكَّلْتُ وَاِلَيْهِ اُنٖيبُ','Şu''ayb şöyle dedi: "Ey kavmim! Söyleyin bakayım, ya ben Rabbimden gelen açık bir delil üzere isem ve katından bana güzel bir rızık vermişse!... Ben size yasakladığımı kendim yapmak istemiyorum. Ben sadece gücüm yettiğince (sizi) düzeltmek istiyorum. Başarım ancak Allah''ın yardımı iledir. Ben sadece ona tevekkül ettim ve sadece ona yöneliyorum."','Hûd 88'),
 (28,'رَبِّ قَدْ اٰتَيْتَنٖي مِنَ الْمُلْكِ وَعَلَّمْتَنٖي مِنْ تَأْوٖيلِ الْاَحَادٖيثِۚ فَاطِرَ السَّمٰوَاتِ وَالْاَرْضِ اَنْتَ وَلِيّٖ فِي الدُّنْيَا وَالْاٰخِرَةِۚ تَوَفَّنٖي مُسْلِماً وَاَلْحِقْنٖي بِالصَّالِحٖينَ','"Rabbim! Gerçekten bana mülk verdin ve bana sözlerin yorumunu öğrettin. Ey gökleri ve yeri yaratan! Dünyada ve ahirette sen benim velimsin. Benim canımı müslüman olarak al ve beni iyilere kat."','Yûsuf 101'),
 (29,'وَاِذْ قَالَ اِبْرٰهٖيمُ رَبِّ اجْعَلْ هٰذَا الْبَلَدَ اٰمِناً وَاجْنُبْنٖي وَبَنِيَّ اَنْ نَعْبُدَ الْاَصْنَامَؕ','Hani İbrahim demişti ki: "Rabbim! Bu şehri güvenli kıl, beni ve oğullarımı putlara tapmaktan uzak tut."','İbrâhîm 35'),
 (30,'رَبِّ اجْعَلْنٖي مُقٖيمَ الصَّلٰوةِ وَمِنْ ذُرِّيَّتٖيࣗ رَبَّـنَا وَتَقَبَّلْ دُعَٓاءِ ﴿﴾ رَبَّـنَا اغْفِرْ لٖي وَلِوَالِدَيَّ وَلِلْمُؤْمِنٖينَ يَوْمَ يَقُومُ الْحِسَابُࣖ','"Rabbim! Beni namaza devam eden bir kimse eyle. Soyumdan da böyle kimseler yarat. Rabbimiz! Duamı kabul eyle.". "Rabbimiz! Hesap görülecek günde, beni, ana-babamı ve inananları bağışla."','İbrâhîm 40-41'),
 (31,'وَاخْفِضْ لَهُمَا جَنَاحَ الذُّلِّ مِنَ الرَّحْمَةِ وَقُلْ رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانٖي صَغٖيراًؕ','Onlara merhamet ederek tevazu kanadını indir ve de ki: "Rabbim!, Tıpkı beni küçükken koruyup yetiştirdikleri gibi sen de onlara acı."','İsrâ 24'),
 (32,'وَقُلْ رَبِّ اَدْخِلْنٖي مُدْخَلَ صِدْقٍ وَاَخْرِجْنٖي مُخْرَجَ صِدْقٍ وَاجْعَلْ لٖي مِنْ لَدُنْكَ سُلْطَاناً نَصٖيراً','Deki: "Rabbim! (Gireceğim yere) doğruluk ve esenlik içinde girmemi sağla.  (Çıkacağım yerden de) beni doğruluk ve esenlik içinde çıkar. Katından bana yardımcı bir kuvvet ver."','İsrâ 80'),
 (33,'اِذْ اَوَى الْفِتْيَةُ اِلَى الْكَهْفِ فَقَالُوا رَبَّنَٓا اٰتِنَا مِنْ لَدُنْكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ اَمْرِنَا رَشَداً','Hani o gençler mağaraya sığınmışlardı da, "Ey Rabbimiz! Bize katından bir rahmet ver ve içinde bulunduğumuz şu durumda bize kurtuluş ve doğruluğa ulaşmayı kolaylaştır" demişlerdi.','Kehf 10'),
 (34,'قَالَ رَبِّ اشْرَحْ لٖي صَدْرٖيۙ ﴿﴾ وَيَسِّرْ لٖٓي اَمْرٖيۙ ﴿﴾ وَاحْلُلْ عُقْدَةً مِنْ لِسَانٖيۙ ﴿﴾ يَفْقَهُوا قَوْلٖيࣕ','Mûsâ dedi ki: "Rabbim! Gönlüme ferahlık ver.". "İşimi bana kolaylaştır.". "Dilimdeki tutukluğu çöz ki sözümü anlasınlar."','Tâhâ 25-28'),
 (35,'فَتَعَالَى اللّٰهُ الْمَلِكُ الْحَقُّۚ وَلَا تَعْجَلْ بِالْقُرْاٰنِ مِنْ قَبْلِ اَنْ يُقْضٰٓى اِلَيْكَ وَحْيُهُؗ وَقُلْ رَبِّ زِدْنٖي عِلْماً','Gerçek hükümdar olan Allah yücedir. Sana vahyedilmesi tamamlanmadan önce Kur''an''ı okumakta acele etme. "Rabbim! İlmimi arttır" de.','Tâhâ 114'),
 (36,'وَاَيُّوبَ اِذْ نَادٰى رَبَّهُٓ اَنّٖي مَسَّنِيَ الضُّرُّ وَاَنْتَ اَرْحَمُ الرَّاحِمٖينَۚ','Eyyûb''u da hatırla. Hani o Rabbine, "Şüphesiz ki ben derde uğradım, sen ise merhametlilerin en merhametlisisin" diye niyaz etmişti.','Enbiyâ 83'),
 (37,'وَذَا النُّونِ اِذْ ذَهَبَ مُغَاضِباً فَظَنَّ اَنْ لَنْ نَقْدِرَ عَلَيْهِ فَنَادٰى فِي الظُّلُمَاتِ اَنْ لَٓا اِلٰهَ اِلَّٓا اَنْتَ سُبْحَانَكَࣗ اِنّٖي كُنْتُ مِنَ الظَّالِمٖينَۚ','Zünnûn''u da hatırla. Hani öfkelenerek (halkından ayrılıp) gitmişti de kendisini asla sıkıştırmayacağımızı sanmıştı. Derken karanlıklar içinde, "Senden başka hiçbir ilah yoktur. Seni eksikliklerden uzak tutarım. Ben gerçekten (nefsine) zulmedenlerden oldum" diye dua etti.','Enbiyâ 87'),
 (38,'وَزَكَرِيَّٓا اِذْ نَادٰى رَبَّهُ رَبِّ لَا تَذَرْنٖي فَرْداً وَاَنْتَ خَيْرُ الْوَارِثٖينَۚ','Zekeriya''yı da hatırla. Hani o, Rabbine, "Rabbim! Beni tek başıma bırakma. Sen varislerin en hayırlısısın" diye dua etmişti.','Enbiyâ 89'),
 (39,'قَالَ رَبِّ انْصُرْنٖي بِمَا كَذَّبُونِ','(Nûh), "Rabbim! Beni yalanlamalarına karşı bana yardım et!" dedi.','Mü''minûn 26'),
 (40,'فَاِذَا اسْتَوَيْتَ اَنْتَ وَمَنْ مَعَكَ عَلَى الْفُلْكِ فَقُلِ الْحَمْدُ لِلّٰهِ الَّذٖي نَجّٰينَا مِنَ الْقَوْمِ الظَّالِمٖينَ ﴿﴾ وَقُلْ رَبِّ اَنْزِلْنٖي مُنْزَلاً مُبَارَكاً وَاَنْتَ خَيْرُ الْمُنْزِلٖينَ','Sen ve beraberindeki kimseler gemiye bindiğiniz zaman: "Bizi zalim kavmin elinden kurtaran Allah''a hamd olsun" de.. Yine de ki: "Ey Rabbim! Beni bereketli bir yere kondur. Sen konuk edenlerin en hayırlısısın."','Mü''minûn 28-29'),
 (41,'قُلْ رَبِّ اِمَّا تُرِيَنّٖي مَا يُوعَدُونَۙ ﴿﴾ رَبِّ فَلَا تَجْعَلْنٖي فِي الْقَوْمِ الظَّالِمٖينَ','De ki: "Ey Rabbim! Onlara yöneltilen tehditleri bana mutlaka göstereceksen, beni o zalim milletin içinde bulundurma."','Mü''minûn 93-94'),
 (42,'وَقُلْ رَبِّ اَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطٖينِۙ ﴿﴾ وَاَعُوذُ بِكَ رَبِّ اَنْ يَحْضُرُونِ','De ki: "Ey Rabbim! Şeytanların vesveselerinden sana sığınırım.". "Ey Rabbim! Onların benim yanımda bulunmalarından da sana sığınırım."','Mü''minûn 97-98'),
 (43,'اِنَّهُ كَانَ فَرٖيقٌ مِنْ عِبَادٖي يَقُولُونَ رَبَّـنَٓا اٰمَنَّا فَاغْفِرْ لَنَا وَارْحَمْنَا وَاَنْتَ خَيْرُ الرَّاحِمٖينَۚ','Kullarımdan, "Ey Rabbimiz! Biz inandık, bizi bağışla, bize merhamet et, sen merhamet edenlerin en hayırlısısın" diyen bir grup var idi.','Mü''minûn 109'),
 (44,'وَالَّذٖينَ يَقُولُونَ رَبَّـنَا اصْرِفْ عَنَّا عَذَابَ جَهَنَّمَࣗ اِنَّ عَذَابَهَا كَانَ غَرَاماًࣗ ﴿﴾ اِنَّهَا سَٓاءَتْ مُسْتَقَراًّ وَمُقَاماً','Onlar, şöyle diyenlerdir: "Ey Rabbimiz! Bizden cehennem azabını uzaklaştır, gerçekten onun azabı sürekli bir helaktir!". "Şüphesiz, ne kötü bir durak ve ne kötü bir konaktır orası."','Furkân 65-66'),
 (45,'وَالَّذٖينَ يَقُولُونَ رَبَّـنَا هَبْ لَنَا مِنْ اَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ اَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقٖينَ اِمَاماً','Onlar, "Ey Rabbimiz! Eşlerimizi ve çocuklarımızı bize göz aydınlığı kıl ve bizi Allah''a karşı gelmekten sakınanlara önder eyle" diyenlerdir.','Furkân 74'),
 (46,'رَبِّ هَبْ لٖي حُكْماً وَاَلْحِقْنٖي بِالصَّالِحٖينَۙ ﴿﴾ وَاجْعَلْ لٖي لِسَانَ صِدْقٍ فِي الْاٰخِرٖينَۙ ﴿﴾ وَاجْعَلْنٖي مِنْ وَرَثَةِ جَنَّةِ النَّعٖيمِۙ','"Ey Rabbim! Bana bir hikmet bahşet ve beni salih kimseler arasına kat.". "Sonra gelecekler arasında beni doğrulukla anılanlardan kıl.". "Beni Naîm cennetinin varislerinden eyle."','Şuarâ 83-85'),
 (47,'وَلَا تُخْزِنٖي يَوْمَ يُبْعَثُونَۙ ﴿﴾ يَوْمَ لَا يَنْفَعُ مَالٌ وَلَا بَنُونَۙ ﴿﴾ اِلَّا مَنْ اَتَى اللّٰهَ بِقَلْبٍ سَلٖيمٍؕ','"(Kulların) diriltilecekleri gün beni utandırma!". "O gün ki ne mal fayda verir ne oğullar!". "Allah''a arınmış bir kalp ile gelen başka."','Şuarâ 87-89'),
 (48,'يَوْمَ لَا يَنْفَعُ مَالٌ وَلَا بَنُونَۙ ﴿﴾ اِلَّا مَنْ اَتَى اللّٰهَ بِقَلْبٍ سَلٖيمٍؕ','"O gün ki ne mal fayda verir ne oğullar!". "Allah''a arınmış bir kalp ile gelen başka."','Şuarâ 88-89'),
 (49,'فَافْتَحْ بَيْنٖي وَبَيْنَهُمْ فَتْحاً وَنَجِّنٖي وَمَنْ مَعِيَ مِنَ الْمُؤْمِنٖينَ','"Artık onlarla benim aramda sen hükmet. Beni ve benimle birlikte olan mü''minleri kurtar."','Şuarâ 118'),
 (50,'رَبِّ نَجِّنٖي وَاَهْلٖي مِمَّا يَعْمَلُونَ','"Ey Rabbim! Beni ve ailemi onların yaptıkları çirkin işten kurtar."','Şuarâ 169'),
 (51,'فَتَبَسَّمَ ضَاحِكاً مِنْ قَوْلِهَا وَقَالَ رَبِّ اَوْزِعْنٖٓي اَنْ اَشْكُرَ نِعْمَتَكَ الَّتٖٓي اَنْعَمْتَ عَلَيَّ وَعَلٰى وَالِدَيَّ وَاَنْ اَعْمَلَ صَالِحاً تَرْضٰيهُ وَاَدْخِلْنٖي بِرَحْمَتِكَ فٖي عِبَادِكَ الصَّالِحٖينَ','Süleyman, onun bu sözüne tebessüm ile gülerek dedi ki: "Ey Rabbim! Beni; bana ve ana-babama verdiğin nimetlere şükretmeye ve razı olacağın salih ameller işlemeye sevk et ve beni  rahmetinle salih kullarının arasına kat!"','Neml 19'),
 (52,'قَالَ رَبِّ اِنّٖي ظَلَمْتُ نَفْسٖي فَاغْفِرْ لٖي فَغَفَرَ لَهُؕ اِنَّهُ هُوَ الْغَفُورُ الرَّحٖيمُ ﴿﴾ قَالَ رَبِّ بِمَٓا اَنْعَمْتَ عَلَيَّ فَلَنْ اَكُونَ ظَهٖيراً لِلْمُجْرِمٖينَ','Mûsâ, "Rabbim! Şüphesiz ben nefsime zulmettim. Beni affet" dedi. Allah da onu affetti. Şüphesiz o, çok bağışlayandır, çok merhamet edendir.. "Rabbim! Bana verdiğin nimetle asla suçlulara arka çıkmayacağım" dedi.','Kasas 16-17'),
 (53,'فَسَقٰى لَهُمَا ثُمَّ تَوَلّٰٓى اِلَى الظِّلِّ فَقَالَ رَبِّ اِنّٖي لِمَٓا اَنْزَلْتَ اِلَيَّ مِنْ خَيْرٍ فَقٖيرٌ','Bunun üzerine Mûsâ onların koyunlarını suladı. Sonra gölgeye çekilip, "Rabbim! Bana göndereceğin her hayra muhtacım" dedi.','Kasas 24'),
 (54,'قَالَ رَبِّ انْصُرْنٖي عَلَى الْقَوْمِ الْمُفْسِدٖينَࣖ','(Lût) "Ey Rabbim! Şu bozguncu kavme karşı bana yardım et" dedi.','Ankebût 30'),
 (55,'رَبِّ هَبْ لٖي مِنَ الصَّالِحٖينَ','"Ey Rabbim! Bana salihlerden olacak bir çocuk bağışla."','Sâffât 100'),
 (56,'اَلَّذٖينَ يَحْمِلُونَ الْعَرْشَ وَمَنْ حَوْلَهُ يُسَبِّحُونَ بِحَمْدِ رَبِّهِمْ وَيُؤْمِنُونَ بِهٖ وَيَسْتَغْفِرُونَ لِلَّذٖينَ اٰمَنُواۚ رَبَّـنَا وَسِعْتَ كُلَّ شَيْءٍ رَحْمَةً وَعِلْماً فَاغْفِرْ لِلَّذٖينَ تَابُوا وَاتَّبَعُوا سَبٖيلَكَ وَقِهِمْ عَذَابَ الْجَحٖيمِ ﴿﴾ رَبَّنَا وَاَدْخِلْهُمْ جَنَّاتِ عَدْنٍۨ الَّتٖي وَعَدْتَهُمْ وَمَنْ صَلَحَ مِنْ اٰبَٓائِهِمْ وَاَزْوَاجِهِمْ وَذُرِّيَّاتِهِمْؕ اِنَّكَ اَنْتَ الْعَزٖيزُ الْحَكٖيمُۚ ﴿﴾ وَقِهِمُ السَّيِّـَٔاتِؕ وَمَنْ تَقِ السَّيِّـَٔاتِ يَوْمَئِذٍ فَقَدْ رَحِمْتَهُؕ وَذٰلِكَ هُوَ الْفَوْزُ الْعَظٖيمُࣖ','Arş''ı taşıyanlar ve onun çevresinde bulunanlar (melekler) Rablerini hamd ederek tespih ederler, O''na inanırlar ve inananlar için (şöyle diyerek) bağışlanma dilerler: "Ey Rabbimiz! Senin rahmetin ve ilmin her şeyi kuşatmıştır. O halde tövbe eden ve senin yoluna uyanları bağışla ve onları cehennem azâbından koru.". "Ey Rabbimiz! Onları da, onların babalarından, eşlerinden ve soylarından iyi olanları da, kendilerine vaad ettiğin Adn cennetlerine koy. Şüphesiz sen mutlak güç sahibisin, hüküm ve hikmet sahibisin.". "Onları kötülüklerden koru. Sen o gün kimi kötülüklerden korursan, ona rahmet etmiş olursun. İşte bu büyük başarıdır."','Mü''min 7-9'),
 (57,'وَالَّذٖي خَلَقَ الْاَزْوَاجَ كُلَّهَا وَجَعَلَ لَكُمْ مِنَ الْفُلْكِ وَالْاَنْعَامِ مَا تَرْكَبُونَۙ ﴿﴾ لِتَسْتَوُ۫ا عَلٰى ظُهُورِهٖ ثُمَّ تَذْكُرُوا نِعْمَةَ رَبِّكُمْ اِذَا اسْتَوَيْتُمْ عَلَيْهِ وَتَقُولُوا سُبْحَانَ الَّذٖي سَخَّرَ لَنَا هٰذَا وَمَا كُنَّا لَهُ مُقْرِنٖينَۙ ﴿﴾ وَاِنَّٓا اِلٰى رَبِّنَا لَمُنْقَلِبُونَ','O bütün çiftleri yaratan, üzerlerine kurulasınız, sonra da, kurulduğunuzda, Rabbinizin nimetini hatırlayasınız ve "Bunu hizmetimize veren Allah''ın şanı yücedir. Bunlara bizim gücümüz yetmezdi. Şüphesiz biz Rabbimize döneceğiz" diyesiniz diye sizin için bindiğiniz gemileri ve hayvanları yaratandır.','Zuhruf 12-14'),
 (58,'وَوَصَّيْنَا الْاِنْسَانَ بِوَالِدَيْهِ اِحْسَاناًؕ حَمَلَتْهُ اُمُّهُ كُرْهاً وَوَضَعَتْهُ كُرْهاًؕ وَحَمْلُهُ وَفِصَالُهُ ثَلٰثُونَ شَهْراًؕ حَتّٰٓى اِذَا بَلَغَ اَشُدَّهُ وَبَلَغَ اَرْبَعٖينَ سَنَةًۙ قَالَ رَبِّ اَوْزِعْنٖٓي اَنْ اَشْكُرَ نِعْمَتَكَ الَّتٖٓي اَنْعَمْتَ عَلَيَّ وَعَلٰى وَالِدَيَّ وَاَنْ اَعْمَلَ صَالِحاً تَرْضٰيهُ وَاَصْلِحْ لٖي فٖي ذُرِّيَّتٖيۚ اِنّٖي تُبْتُ اِلَيْكَ وَاِنّٖي مِنَ الْمُسْلِمٖينَ','Biz insana anne babasına iyi davranmayı emrettik. Annesi onu ne zahmetle karnında taşıdı ve ne zahmetle doğurdu! Onun (anne karnında) taşınması ve sütten kesilme süresi (toplam olarak) otuz aydır. Nihayet olgunluk çağına gelip, kırk yaşına varınca şöyle der: "Bana ve anne babama verdiğin nimetlere şükretmemi, senin razı olacağın salih amel işlememi bana ilham et. Neslimi de salih kimseler yap. Şüphesiz ben sana döndüm. Muhakkak ki ben sana teslim olanlardanım."','Ahkâf 15'),
 (59,'وَالَّذٖينَ جَٓاؤُ۫ مِنْ بَعْدِهِمْ يَقُولُونَ رَبَّـنَا اغْفِرْ لَنَا وَلِاِخْوَانِنَا الَّذٖينَ سَبَقُونَا بِالْاٖيمَانِ وَلَا تَجْعَلْ فٖي قُلُوبِنَا غِلاًّ لِلَّذٖينَ اٰمَنُوا رَبَّـنَٓا اِنَّكَ رَؤُ۫فٌ رَحٖيمٌࣖ','Onlardan sonra gelenler ise şöyle derler: "Ey Rabbimiz! Bizi ve bizden önce iman etmiş olan kardeşlerimizi bağışla. Kalplerimizde, iman edenlere karşı hiçbir kin tutturma! Ey Rabbimiz! Şüphesiz sen çok esirgeyicisin, çok merhametlisin."','Haşr 10'),
 (60,'قَدْ كَانَتْ لَكُمْ اُسْوَةٌ حَسَنَةٌ فٖٓي اِبْرٰهٖيمَ وَالَّذٖينَ مَعَهُۚ اِذْ قَالُوا لِقَوْمِهِمْ اِنَّا بُرَءٰٓؤُ۬ا مِنْكُمْ وَمِمَّا تَعْبُدُونَ مِنْ دُونِ اللّٰهِؗ كَفَرْنَا بِكُمْ وَبَدَا بَيْنَنَا وَبَيْنَكُمُ الْعَدَاوَةُ وَالْبَغْضَٓاءُ اَبَداً حَتّٰى تُؤْمِنُوا بِاللّٰهِ وَحْدَهُٓ اِلَّا قَوْلَ اِبْرٰهٖيمَ لِاَبٖيهِ لَاَسْتَغْفِرَنَّ لَكَ وَمَٓا اَمْلِكُ لَكَ مِنَ اللّٰهِ مِنْ شَيْءٍؕ رَبَّـنَا عَلَيْكَ تَوَكَّلْنَا وَاِلَيْكَ اَنَبْنَا وَاِلَيْكَ الْمَصٖيرُ ﴿﴾ رَبَّنَا لَا تَجْعَلْنَا فِتْنَةً لِلَّذٖينَ كَفَرُوا وَاغْفِرْ لَنَا رَبَّنَاۚ اِنَّكَ اَنْتَ الْعَزٖيزُ الْحَكٖيمُ','İbrahim''de ve onunla birlikte bulunanlarda sizin için güzel bir örnek vardır. Hani onlar kavimlerine, "Biz sizden ve Allah''ı bırakıp taptıklarınızdan uzağız. Sizi tanımıyoruz. Siz bir tek Allah''a inanıncaya kadar, sizinle bizim aramızda sürekli bir düşmanlık ve nefret belirmiştir" demişlerdi. Yalnız İbrahim''in, babasına, "Senin için mutlaka bağışlama dileyeceğim. Fakat Allah''tan sana gelecek herhangi bir şeyi önlemeye gücüm yetmez" sözü başka. Onlar şöyle dediler: "Ey Rabbimiz! Ancak sana dayandık, içtenlikle yalnız sana yöneldik. Dönüş de ancak sanadır.". "Ey Rabbimiz! Bizi, inkar edenlerin zulmüne uğratma. Bizi bağışla. Ey Rabbimiz! Şüphesiz sen mutlak güç sahibisin, hüküm ve hikmet sahibisin."','Mümtehine 4-5'),
 (61,'يَٓا اَيُّهَا الَّذٖينَ اٰمَنُوا تُوبُٓوا اِلَى اللّٰهِ تَوْبَةً نَصُوحاًؕ عَسٰى رَبُّكُمْ اَنْ يُكَفِّرَ عَنْكُمْ سَيِّـَٔاتِكُمْ وَيُدْخِلَكُمْ جَنَّاتٍ تَجْرٖي مِنْ تَحْتِهَا الْاَنْهَارُۙ يَوْمَ لَا يُخْزِي اللّٰهُ النَّبِيَّ وَالَّذٖينَ اٰمَنُوا مَعَهُۚ نُورُهُمْ يَسْعٰى بَيْنَ اَيْدٖيهِمْ وَبِاَيْمَانِهِمْ يَقُولُونَ رَبَّـنَٓا اَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَاۚ اِنَّكَ عَلٰى كُلِّ شَيْءٍ قَدٖيرٌ','Ey iman edenler!  Allah''a içtenlikle tövbe  edin. Belki Rabbiniz sizin kötülüklerinizi örter ve peygamberi ve onunla birlikte iman edenleri utandırmayacağı günde Allah sizi, içlerinden ırmaklar akan cennetlere sokar. Onların nurları önlerinden ve sağlarından aydınlatır, gider. "Ey Rabbimiz! nûrumuzu bizim için tamamla, bizi bağışla; çünkü senin her şeye hakkıyla gücün yeter" derler.','Tahrîm 8'),
 (62,'وَضَرَبَ اللّٰهُ مَثَلاً لِلَّذٖينَ اٰمَنُوا امْرَاَتَ فِرْعَوْنَۘ اِذْ قَالَتْ رَبِّ ابْنِ لٖي عِنْدَكَ بَيْتاً فِي الْجَنَّةِ وَنَجِّنٖي مِنْ فِرْعَوْنَ وَعَمَلِهٖ وَنَجِّنٖي مِنَ الْقَوْمِ الظَّالِمٖينَۙ','Allah, iman edenlere ise, Firavun''un karısını örnek gösterdi. Hani o, "Rabbim! Bana katında, cennette bir ev yap. Beni Firavun''dan ve onun yaptığı işlerden koru ve beni zalimler topluluğundan kurtar!" demişti.','Tahrîm 11'),
 (63,'رَبِّ اغْفِرْ لٖي وَلِوَالِدَيَّ وَلِمَنْ دَخَلَ بَيْتِيَ مُؤْمِناً وَلِلْمُؤْمِنٖينَ وَالْمُؤْمِنَاتِؕ وَلَا تَزِدِ الظَّالِمٖينَ اِلَّا تَبَاراً','"Rabbim! Beni, ana babamı, iman etmiş olarak evime girenleri, iman eden erkekleri ve iman eden kadınları bağışla. Zalimlerin de ancak helâkini arttır."','Nûh 28');""");
    await txn.execute("""INSERT INTO "Prayers" ("id","name","arabicContent","meaningContent","pronunciationContent") VALUES (1,'Sübhaneke Duası','سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ ﴿﴾ وَتَبَارَكَ اسْمُكَ ﴿﴾ وَتَعَالَى جَدُّكَ ﴿﴾ وَلاَ إِلَهَ غَيْرُكَ','Allah''ım! Sen eksik sıfatlardan pak ve uzaksın. Seni daima böyle tenzih eder ve överim. Senin adın mübarektir. Varlığın her şeyden üstündür. Senden başka ilah yoktur.','Subhânekellâhumme ve bi hamdik ve tebârakesmuk ve teâlâ cedduk (ve celle senâuk*) ve lâ ilâhe ğayruk.

* (vecelle senâuk kısmı sadece cenaze namazında okunur.)'),
 (2,'Ettehiyyâtu Duası','التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ ﴿﴾ السَّلامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ ﴿﴾ السَّلامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ ﴿﴾ أَشْهَدُ أَنْ لا إِلَهَ إِلا اللَّهُ ﴿﴾ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ','Dil ile, beden ve mal ile yapılan bütün ibadetler Allah''a dır. Ey Peygamber! Allah''ın selamı, rahmet ve bereketleri senin üzerine olsun. Selam bizim üzerimize ve Allah''ın bütün iyi kulları üzerine olsun. Şahitlik ederim ki, Allah''tan başka ilah yoktur. Yine şahitlik ederim ki, Muhammed, O''nun kulu ve elçisidir.','Ettehiyyâtu lillâhi vessalevâtu vettayibât. Esselâmu aleyke eyyuhen-Nebiyyu ve rahmetullahi ve berakâtuhu. Esselâmu aleynâ ve alâ ibâdillâhis-Sâlihîn. Eşhedu en lâ ilâhe illallâh ve eşhedu enne Muhammeden abduhû ve Rasuluh.'),
 (3,'Allâhumme Salli Duası','اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ ﴿﴾ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيم ﴿﴾ إِنَّكَ حَمِيدٌ مَجِيدٌ','Allah''ım! Muhammed''e ve Muhammed''in ümmetine rahmet eyle; şerefini yücelt. İbrahim''e ve İbrahim''in ümmetine rahmet ettiğin gibi. Şüphesiz övülmeye layık yalnız sensin, şan ve şeref sahibi de sensin.','Allâhumme salli alâ Muhammedin ve alâ âli Muhammed. Kemâ salleyte alâ İbrahime ve alâ âli İbrahim. İnneke hamidun mecîd.'),
 (4,'Allâhumme Barik Duası','اللَّهُمَّ بَارِكَ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ ﴿﴾ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيم ﴿﴾ إِنَّكَ حَمِيدٌ مَجِيدٌ','Allah''ım! Muhammed''e ve Muhammed''in ümmetine hayır ve bereket ver. İbrahim''e ve İbrahim''in ümmetine verdiğin gibi. Şüphesiz övülmeye layık yalnız sensin, şan ve şeref sahibi de sensin.','Allâhumme barik alâ Muhammedin ve alâ âli Muhammed. Kemâ barekte alâ İbrahîme ve alâ âli İbrahim. İnneke hamidun mecîd'),
 (5,'Rabbenâ âtina Duası','رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ','Allah’ım! Bize dünyada iyilik, güzellik ve nimet ver, ahirette de iyilik, güzellik ve nimet ver. Bizi ateş azabından koru',NULL),
 (6,'Rabbenâğfirlî Duası','رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ','Rabbimiz! Beni, anamı, babamı ve bütün mü’minleri hesap gününde (herkesin sorguya çekileceği günde) bağışla.',NULL),
 (7,'Kunut Duaları 1','اَللَّهُمَّ إِنَّا نَسْتَعِينُكَ وَ نَسْتَغْفِرُكَ وَ نَسْتَهْدِيكَ ﴿﴾ وَ نُؤْمِنُ بِكَ وَ نَتُوبُ اِلَيْكَ ﴿﴾ وَ نَتَوَكَّلُ عَلَيْكَ وَنُثْنِى عَلَيْك اْلخَيْرَ كُلَّهُ نَشْكُرُكَ وَ لاَ نَكْفُرُكَ ﴿﴾ وَ نَخْلَعُ وَ نَتْرُكُ مَنْ يَفْجُرُكَ','Allahım! Senden yardım isteriz, günahlarımızı bağışlamanı isteriz, razı olduğun şeylere hidayet etmeni isteriz. Sana inanırız, sana tevbe ederiz. Sana güveniriz. Bize verdiğin bütün nimetleri bilerek seni hayır ile överiz. Sana şükrederiz. Hiçbir nimetini inkar etmez ve onları başkasından bilmeyiz. Nimetlerini inkar eden ve sana karşı geleni bırakırız. ','Allâhumme innâ nesteînuke ve nestağfiruke ve nestehdik. Ve nu''minu bike ve netûbu ileyk. Ve netevekkelu aleyke ve nusni aleykel-hayra kullehu neşkuruke ve lâ nekfuruke ve nahleu ve netruku men yefcuruk'),
 (8,'Kunut Duaları 2','اَللَّهُمَّ اِيَّاكَ نَعْبُدُ وَ لَكَ نُصَلِّى وَ نَسْجُدُ ﴿﴾ وَ اِلَيْكَ نَسعْىَ وَ نَحْفِدُ ﴿﴾ نَرْجُو رَحْمَتَكَ وَ نَخْشَى عَذَابَك ﴿﴾ اِنَّ عَذَابَكَ بِاْلكُفَّارِ مُلْحِقٌ','Allahım! Biz yalnız sana kulluk ederiz. Namazı yalnız senin için kılarız, ancak sana secde ederiz. Yalnız sana koşar ve sana yaklaştıracak şeyleri kazanmaya çalışırız. İbadetlerini sevinçle yaparız. Rahmetinin devamını ve çoğalmasını dileriz. Azabından korkarız, şüphesiz senin azabın kafirlere ve inançsızlara ulaşır.','Allâhumme iyyâke na''budu ve leke nusalli ve nescudu ve ileyke nes''a ve nahfidu nercû rahmeteke ve nahşâ azâbeke inne azâbeke bilkuffâri mulhık'),
 (9,'Amenerrasulü ','اٰمَنَ الرَّسُولُ بِمَٓا اُنْزِلَ اِلَيْهِ مِنْ رَبِّهٖ وَالْمُؤْمِنُونَؕ كُلٌّ اٰمَنَ بِاللّٰهِ وَمَلٰٓئِكَتِهٖ وَكُتُبِهٖ وَرُسُلِهٖؕ لَا نُفَرِّقُ بَيْنَ اَحَدٍ مِنْ رُسُلِهٖࣞ  وَقَالُوا سَمِعْنَا وَاَطَعْنَا غُفْرَانَكَ رَبَّنَا وَاِلَيْكَ الْمَصٖيرُ ﴿﴾ لَا يُكَلِّفُ اللّٰهُ نَفْساً اِلَّا وُسْعَهَاؕ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْؕ رَبَّنَا لَا تُؤَاخِذْنَٓا اِنْ نَسٖينَٓا اَوْ اَخْطَأْنَاۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَٓا اِصْراً كَمَا حَمَلْتَهُ عَلَى الَّذٖينَ مِنْ قَبْلِنَاۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهٖۚ وَاعْفُ عَنَّاࣞ وَاغْفِرْ لَنَاࣞ وَارْحَمْنَاࣞ اَنْتَ مَوْلٰينَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرٖينَ','Peygamber, Rabbinden kendisine indirilene iman etti, mü''minler de (iman ettiler). Her biri; Allah''a, meleklerine, kitaplarına ve peygamberlerine iman ettiler ve şöyle dediler: "Onun peygamberlerinden hiçbirini (diğerinden) ayırt etmeyiz." Şöyle de dediler: "İşittik ve itaat ettik. Ey Rabbimiz! Senden bağışlama dileriz. Sonunda dönüş yalnız sanadır." Allah bir kimseyi ancak gücünün yettiği şeyle yükümlü kılar. Onun kazandığı iyilik kendi yararına, kötülük de kendi zararınadır. (Şöyle diyerek dua ediniz): "Ey Rabbimiz! Unutur, ya da yanılırsak bizi sorumlu tutma! Ey Rabbimiz! Bize, bizden öncekilere yüklediğin gibi ağır yük yükleme. Ey Rabbimiz! Bize gücümüzün yetmediği şeyleri yükleme! Bizi affet, bizi bağışla, bize acı! Sen bizim Mevlâmızsın. Kâfirler topluluğuna karşı bize yardım et."',NULL),
 (10,'Ayetel Kürsi','اَللّٰهُ لَٓا اِلٰهَ اِلَّا هُوَۚ اَلْحَيُّ الْقَيُّومُۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌؕ لَهُ مَا فِي السَّمٰوَاتِ وَمَا فِي الْاَرْضِؕ مَنْ ذَا الَّذٖي يَشْفَعُ عِنْدَهُٓ اِلَّا بِاِذْنِهٖؕ يَعْلَمُ مَا بَيْنَ اَيْدٖيهِمْ وَمَا خَلْفَهُمْۚ وَلَا يُحٖيطُونَ بِشَيْءٍ مِنْ عِلْمِهٖٓ اِلَّا بِمَا شَٓاءَۚ وَسِعَ كُرْسِيُّهُ السَّمٰوَاتِ وَالْاَرْضَۚ وَلَا يَؤُ۫دُهُ حِفْظُهُمَاۚ وَهُوَ الْعَلِيُّ الْعَظٖيمُ','Allah kendisinden başka hiçbir ilah olmayandır. Diridir, kayyumdur. Onu ne bir uyuklama tutabilir, ne de bir uyku. Göklerdeki her şey, yerdeki her şey onundur. İzni olmaksızın onun katında şefaatte bulunacak kimdir? O, kulların önlerindekileri ve arkalarındakileri (yaptıklarını ve yapacaklarını) bilir. Onlar onun ilminden, kendisinin dilediği kadarından başka bir şey kavrayamazlar. Onun kürsüsü bütün gökleri ve yeri kaplayıp kuşatmıştır. (O, göklere, yere, bütün evrene hükmetmektedir.) Gökleri ve yeri koruyup gözetmek ona güç gelmez. O, yücedir, büyüktür.',NULL),
 (11,'Hatim Duası','أَلْحَمْدُ لِلَّٰهِ رَبِّ الْعَالَم۪ينَ ﴿﴾ وَالْعَاقِـبَـةُ لِلْمُـتَّـق۪ينَ ﴿﴾ وَلَا عُدْوَانَ إِلَّا عَلَي الظَّالِم۪ينَ ﴿﴾ وَالصَّلٰاةُ وَالسَّلٰامُ عَلٰى رَسُولِـنَا مُحَمَّدٍ وَأٰلِه۪ وَصَحْبِه۪ٓ أَجْمَع۪ينَ ﴿﴾ أَللَّٰـهُمَّ رَبَّـنَا يَا رَبَّـنَا تَـقَـبَّـلْ مِنَّا إِنَّكَ أَنْتَ السَّم۪يعُ الْعَل۪يمُ ﴿﴾ وَتُبْ عَلَيْنَا يَا مَوْلٰــنَآ إِنَّكَ أَنْتَ التَّــوَّابُ الرَّح۪يمُ ﴿﴾ وَاهْدِنَا وَوَفِّقْـنَآ إِلَى الْحَقِّ وَإِلٰى طَر۪يقٍ مُسْتَـق۪يمٍ ﴿﴾ بِـبَـرَكَـةِ الْقُرْأٰنِ الْعَظ۪يمِ ﴿﴾ وَبِحُرْمَـةِ مَنْ أَرْسَلْـتَـهُ رَحْمَةً لِلْعَالَم۪ينَ ﴿﴾ وَاعْفُ عَـنَّا يَا كَر۪يمُ ﴿﴾ وَاعْفُ عَـنَّا يَا رَح۪يمُ ﴿﴾ وَاغْفِرْ لَـنَا ذُنُـوبَـنَا بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآأَكْرَمَ الْاَكْرَم۪ينَ ﴿﴾ أَللَّٰـهُمَّ زَيِّـنَّا بِز۪يـنَـةِ الْقُرْأٰنِ ﴿﴾ وَأَكْرِمْنَا بِكَرَامَةِ الْقُرْأٰنِ ﴿﴾ وَشَرِّفْـنَا بِشَرَافَةِ الْقُرْأٰنِ ﴿﴾ وَأَلْبِسْنَا بِـخِلْعَةِ الْقُرْأٰنِ ﴿﴾ وَأَدْخِـلْـنَا الْجَـنَّـةَ بِشَفَاعَةِ الْقُرْأٰنِ ﴿﴾ وَعَافِـنَا مِنْ كُلِّ بَلٰٓاءِ الدُّنْـيَا وَعَذَابِ الْاٰخِرَةِ بِحُرْمَةِ الْقُرْأٰنِ ﴿﴾ وَارْحَمْ جَم۪يعَ أُمَّـةِ مُحَمَّدٍ يَا رَح۪يمُ يَا رَحْمٰنُ ﴿﴾ أَللَّٰـهُمَّ اجْعَلِ الْقُرْأٰنَ لَـنَا فِي الدُّنْـيَا قَر۪ينًا ﴿﴾ وَفِي الْقَـبْـرِ مُونِسًا ﴿﴾ وَفِي الْقِيَامَـةِ شَف۪يعًا ﴿﴾ وَعَلَى الصِّرَاطِ نُـورًا ﴿﴾ وَفِي الْجَـنَّـةِ رَف۪يقًا ﴿﴾ وَمِنَ النَّارِ سِتْـرًا وَحِجَابًا ﴿﴾ وَإِلىَ الْخَـيْـرَاتِ كُـلِّـهَا دَل۪يلًا وَإِمَامًا ﴿﴾ بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآ أَكْرَمَ الْاَكْرَم۪ينَ وَيَآ أَرْحَمَ الرَّاحِم۪ينَ. أَللَّٰـهُمَّ اهْدِنَا بِـهِدَايَـةِ الْقُرْأٰنِ ﴿﴾ وَنَـجِّـنَا مِنَ النّ۪ـيرَانِ بِكَرَامَةِ الْقُرْأٰنِ ﴿﴾ وَارْفَعْ دَرَجَاتِـنَا بِفَض۪يلَـةِ الْقُرْأٰنِ ﴿﴾ وَكَفِّرْ عَـنَّا سَيِّأٰتِـنَا بِـتِـلٰاوَةِ الْقُرْأٰنِ ﴿﴾ يَا ذَا الْفَضْلِ وَالْاِحْسَانِ ﴿﴾ أَللَّٰـهُمَّ طَهِّرْ قُـلوُبَـنَا ﴿﴾ وَاسْتُرْ عُيوُبَـنَا ﴿﴾ وَاشْفِ مَرْضَانَا ﴿﴾ وَاقْضِ دُيُـونَـنَا ﴿﴾ وَارْفَعْ دَرَجَاتِـنَا ﴿﴾ وَارْحَمْ أٰبَآءَنَا ﴿﴾ وَاغْفِرْ أُمَّـهَاتِـنَا ﴿﴾ وَأَصْلِحْ د۪يـنَـنَا وَدُنْـيَانَا ﴿﴾ وَشَتِّتْ شَمْلَ أَعْدَآئِـنَا ﴿﴾ وَاحْفَظْ أَهْلَـنَا وَأَمْوَالَـنَا وَبِلَادَنَا مِنْ جِم۪يعِ الْاٰفَاتِ وَالْاَمْرَاضِ وَالْـبَـلٰايَا ﴿﴾ وَثَـبِّتْ أَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِر۪ينَ ﴿﴾ بِحُرْمَةِ الْقُرْأٰنِ الْعَظ۪يمِ ﴿﴾

أَللَّٰـهُمَّ بَـلِّـغْ ثَــوَابَ مَا قَرَأْنَاهُ ، وَنُـورَ مَا تَـلَوْنَاهُ ، إِلٰى رُوحِ سَيِّـدِنَا وَنَـبِـيِّـنَا مُحَمَّدٍ صَلَّى اللّٰهُ تَـعَالٰى عَلَـيْـهِ وَسَلَّمَ ﴿﴾ وَإِلٰٓى أَرْوَاحِ جَم۪يعِ الْاَنْبِـيَـآءِ وَالْمُرْسَل۪ينَ ، صَلَوَاتُ اللّٰهِ وَسَلٰامُهُ عَلَـيْهِمْ أَجْمَع۪ينَ ﴿﴾وَإِلٰٓى أَرْوَاحِ أٰلِه۪، وَأَوْلٰادِه۪ ، وَأَزْوَاجِه۪، وَأَصْحَابِـه۪، أَتْـبَاعِه۪، وَجَم۪يعِ ذُرِّيَّاتِـه۪ رِضْوَانُ اللّٰهِ تَعَالٰى عَلَـيْـهِمْ أَجْمَع۪ينَ ﴿﴾ وَإِلٰٓى أَرْوَاحِ أٰ بَآئِـنَا، وَأُمَّـهَاتِـنَا، وَإِخْوَانِـنَا وَأَخَوَاتِـنَا، وَأَوْلَادِنَا، وَأَقْرِبَآئِـنَا، وَأَحِبَّآئِـنَا، وَأَصْدِقَآئِـنَا، وَأَسَات۪يذِنَا، وَمَشَايِـخِـنَا، وَلِمَنْ كَانَ لَهُ حَقٌّ عَلَـيْـنَا ﴿﴾ وَإِلٰي أَرْوَاحِ جَم۪يعِ الْمُؤْمِن۪ينَ وَالْمُؤْمِنَاتِ، وَالْمُسْلِم۪ينَ وَالْمُسْلِمَاتِ، أَلْاَحْـيَآءِ مِـنْـهُمْ وَالْاَمْوَاتِ ﴿﴾ يَا قَاضِيَ الْحَاجَاتِ وَيَا مُج۪يبَ الدَّعَـوَاتِ ﴿﴾ رَبَّـنَآ أٰتِـنَا فِي الدُّنْـيَا حَسَنَةً وَفِي الْاٰخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ ﴿﴾ أَللَّٰـهُمَّ رَبَّـنَا اغْفِرْ ل۪ي وَلِـوَالِدَيَّ وَلِلْمُؤْمِن۪ينَ يَوْمَ يَقُومُ الْحِسَابُ','Âlemlerin Rabbi olan Allah’a hamd olsun. İyi sonuç müttakilerindir. Düşmanlık ancak zalimler içindir. Peygamberimiz
Hz. Muhammed (a.s)’e, onun bütün ehl-i beytine ve ashâbına salât ve selâm olsun.
Ey Rabbimiz! Bizden ibadetlerimizi kabul buyur! Şüphesiz ki sen her şeyi işiten ve her şeyi bilensin.
Ey Mevlamız! Bizim tövbelerimizi kabul eyle!. Şüphesiz ki sen tövbeleri çok çok kabul eden ve merhametli olansın. Bize hidâyet ver! Hak yola ve sırat-ı müstakime ulaşmayı bizi muvaffak eyle!. Yüce Kur’ân’ın hürmetine, âlemlere rahmet olarak gönderdiğin Peygamber hürmetine.
Ey Kerim olan Allah! Bizi bağışla. Ey Rahim olan Allah! Bizi bağışla. Ey ikram edenlerin en keremlisi olan Allah! Lütfunla ve ihsanınla bizim günahlarımızı bağışla.
Allah’ım! Bizi Kur’ân süsü ile süsle. Kur’ân ile bize lütfet! Kur’ân ile bizi şereflendir. Kur’ân elbisesini bize giydir. Kur’ân hürmetine bizi cennetine koy. Kur’ân hürmetine dünyadaki belalardan ve âhiret azabından bizi koru. Ey Rahim, Ey Rahman! Ümmet-i Muhammed’in tamamına merhamet et.
Allah’ım! Kur’ân’ı bize dünyada yoldaş eyle. O’nu bize kabirde dost eyle. Kıyamet günü onu bize şefaatçi kıl, sırat köprüsü üzerinde onu bize nur eyle. Cennette onu bize yoldaş eyle. Cehennem ateşine karşı onu bize perde ve engel kıl. İhsanın, cömertliğin ve keremin ile tüm hayırlı yollar için onu bize önder kıl.
Kur’ân hidâyeti ile bizi hidâyete eriştir. Kur’ân’ın hürmetine bizi ateşten koru. Kur’ân hürmetine bizim derecemizi yükselt. Okunan Kur’ân hürmetine günahlarımızı bağışla. Ey Lütuf ve ihsan sahibi!.
Allah’ım! Kalplerimizi temizle. Kusurlarımızı ört. Hastalarımıza şifa ver. Borçlarımızı ödemeye yardım et. Yüzümüzü aydınlat. Derecemizi yükselt. Babalarımıza merhamet et. Annelerimizi bağışla. Din ve dünya işlerimizi islâh et. Düşmanlarımızın bize saldırısını bertaraf eyle. Ailemizi, mallarımızı, memleketimizi her türlü afetlerden, hastalıklardan ve belalardan koru. Ayaklarımızı sabit eyle, kâfir toplumlara karşı bize yardım et. Yüce Kur’ân hürmetine.
Allah’ım! Okuduğumuz ve tilavet ettiğimiz Kur’ân’ın sevabını ve nurunu Efendimiz Hz. Muhammed (a.s)’in ruhuna ulaştır. Ve onun kardeşleri olan tüm peygamberlerin (a.s) ruhlarına ulaştır. Ve Peygamberimiz (a.s)’in ehlinin, çocuklarının, hanımlarının, ashabının, tabiinin ve bütün zürriyetinin ruhlarına ulaştır.
Hayatta olan veya vefat etmiş olan babalarımızın, annelerimizin, kardeşlerimizin, evladımızın, akrabalarımızın, sevdiklerimizin, dostlarımızın, hocalarımızın, üzerimizde hakkı olan herkesin ve Müslüman olan bütün kadın ve erkeğin ruhlarına ulaştır.
Ey ihtiyaçları gideren Allah! Ey dualara icabet eden Allah! Ey merhametlilerin en merhametlisi! Dualarımızı kabul et. Tüm peygamberlere salât ve selam olsun.
Senin Rabbin; kudret ve şeref sahibi olan Rab, onların nitelendirdiği şeylerden uzaktır, yücedir. Peygamberlere selam olsun. alemlerin Rabbi olan Allah’a hamdolsun. 
Fatiha denir ve Kur’an’ın birinci suresi (Fatiha) okunur.',NULL);""");
    await txn.execute("update surah set searchName= '1 Fatiha' where id=1");
    await txn.execute("update surah set searchName= '2 Bakara' where id=2");
    await txn.execute("update surah set searchName= '3 Ali İmran' where id=3");
    await txn.execute("update surah set searchName= '4 Nisa' where id=4");
    await txn.execute("update surah set searchName= '5 Maide' where id=5");
    await txn.execute("update surah set searchName= '6 Enam' where id=6");
    await txn.execute("update surah set searchName= '7 Araf' where id=7");
    await txn.execute("update surah set searchName= '8 Enfal' where id=8");
    await txn.execute("update surah set searchName= '9 Tevbe' where id=9");
    await txn.execute("update surah set searchName= '10 Yunus' where id=10");
    await txn.execute("update surah set searchName= '11 Hud' where id=11");
    await txn.execute("update surah set searchName= '12 Yusuf' where id=12");
    await txn.execute("update surah set searchName= '13 Rad' where id=13");
    await txn.execute("update surah set searchName= '14 İbrahim' where id=14");
    await txn.execute("update surah set searchName= '15 Hicr' where id=15");
    await txn.execute("update surah set searchName= '16 Nahl' where id=16");
    await txn.execute("update surah set searchName= '17 İsra' where id=17");
    await txn.execute("update surah set searchName= '18 Kehf' where id=18");
    await txn.execute("update surah set searchName= '19 Meryem' where id=19");
    await txn.execute("update surah set searchName= '20 Taha' where id=20");
    await txn.execute("update surah set searchName= '21 Enbiya' where id=21");
    await txn.execute("update surah set searchName= '22 Hac' where id=22");
    await txn.execute("update surah set searchName= '23 Müminun' where id=23");
    await txn.execute("update surah set searchName= '24 Nur' where id=24");
    await txn.execute("update surah set searchName= '25 Furkan' where id=25");
    await txn.execute("update surah set searchName= '26 Şuara' where id=26");
    await txn.execute("update surah set searchName= '27 Neml' where id=27");
    await txn.execute("update surah set searchName= '28 Kasas' where id=28");
    await txn.execute("update surah set searchName= '29 Ankebut' where id=29");
    await txn.execute("update surah set searchName= '30 Rum' where id=30");
    await txn.execute("update surah set searchName= '31 Lokman' where id=31");
    await txn.execute("update surah set searchName= '32 Secde' where id=32");
    await txn.execute("update surah set searchName= '33 Ahzab' where id=33");
    await txn.execute("update surah set searchName= '34 Sebe' where id=34");
    await txn.execute("update surah set searchName= '35 Fatır' where id=35");
    await txn.execute("update surah set searchName= '36 Yasin' where id=36");
    await txn.execute("update surah set searchName= '37 Saffat' where id=37");
    await txn.execute("update surah set searchName= '38 Sad' where id=38");
    await txn.execute("update surah set searchName= '39 Zümer' where id=39");
    await txn.execute("update surah set searchName= '40 Mümin' where id=40");
    await txn.execute("update surah set searchName= '41 Fussilet' where id=41");
    await txn.execute("update surah set searchName= '42 Şura' where id=42");
    await txn.execute("update surah set searchName= '43 Zuhruf' where id=43");
    await txn.execute("update surah set searchName= '44 Duhan' where id=44");
    await txn.execute("update surah set searchName= '45 Casiye' where id=45");
    await txn.execute("update surah set searchName= '46 Ahkaf' where id=46");
    await txn.execute("update surah set searchName= '47 Muhammed' where id=47");
    await txn.execute("update surah set searchName= '48 Fetih' where id=48");
    await txn.execute("update surah set searchName= '49 Hucurat' where id=49");
    await txn.execute("update surah set searchName= '50 Kaf' where id=50");
    await txn.execute("update surah set searchName= '51 Zariyat' where id=51");
    await txn.execute("update surah set searchName= '52 Tur' where id=52");
    await txn.execute("update surah set searchName= '53 Necm' where id=53");
    await txn.execute("update surah set searchName= '54 Kamer' where id=54");
    await txn.execute("update surah set searchName= '55 Rahman' where id=55");
    await txn.execute("update surah set searchName= '56 Vakıa' where id=56");
    await txn.execute("update surah set searchName= '57 Hadid' where id=57");
    await txn.execute("update surah set searchName= '58 Mücadele' where id=58");
    await txn.execute("update surah set searchName= '59 Haşr' where id=59");
    await txn.execute("update surah set searchName= '60 Mümtehine' where id=60");
    await txn.execute("update surah set searchName= '61 Saff' where id=61");
    await txn.execute("update surah set searchName= '62 Cuma' where id=62");
    await txn.execute("update surah set searchName= '63 Münafikun' where id=63");
    await txn.execute("update surah set searchName= '64 Tegabün' where id=64");
    await txn.execute("update surah set searchName= '65 Talak' where id=65");
    await txn.execute("update surah set searchName= '66 Tahrim' where id=66");
    await txn.execute("update surah set searchName= '67 Mülk' where id=67");
    await txn.execute("update surah set searchName= '68 Kalem' where id=68");
    await txn.execute("update surah set searchName= '69 Hakka' where id=69");
    await txn.execute("update surah set searchName= '70 Mearic' where id=70");
    await txn.execute("update surah set searchName= '71 Nuh' where id=71");
    await txn.execute("update surah set searchName= '72 Cin' where id=72");
    await txn.execute("update surah set searchName= '73 Müzzemmil' where id=73");
    await txn.execute("update surah set searchName= '74 Müddessir' where id=74");
    await txn.execute("update surah set searchName= '75 Kıyamet' where id=75");
    await txn.execute("update surah set searchName= '76 İnsan' where id=76");
    await txn.execute("update surah set searchName= '77 Mürselat' where id=77");
    await txn.execute("update surah set searchName= '78 Nebe' where id=78");
    await txn.execute("update surah set searchName= '79 Naziat' where id=79");
    await txn.execute("update surah set searchName= '80 Abese' where id=80");
    await txn.execute("update surah set searchName= '81 Tekvir' where id=81");
    await txn.execute("update surah set searchName= '82 İnfitar' where id=82");
    await txn.execute("update surah set searchName= '83 Mutaffifin' where id=83");
    await txn.execute("update surah set searchName= '84 İnşikak' where id=84");
    await txn.execute("update surah set searchName= '85 Buruc' where id=85");
    await txn.execute("update surah set searchName= '86 Tarık' where id=86");
    await txn.execute("update surah set searchName= '87 Ala' where id=87");
    await txn.execute("update surah set searchName= '88 Gaşiye' where id=88");
    await txn.execute("update surah set searchName= '89 Fecr' where id=89");
    await txn.execute("update surah set searchName= '90 Beled' where id=90");
    await txn.execute("update surah set searchName= '91 Şems' where id=91");
    await txn.execute("update surah set searchName= '92 Leyl' where id=92");
    await txn.execute("update surah set searchName= '93 Duha' where id=93");
    await txn.execute("update surah set searchName= '94 İnşirah' where id=94");
    await txn.execute("update surah set searchName= '95 Tin' where id=95");
    await txn.execute("update surah set searchName= '96 Alak' where id=96");
    await txn.execute("update surah set searchName= '97 Kadir' where id=97");
    await txn.execute("update surah set searchName= '98 Beyyine' where id=98");
    await txn.execute("update surah set searchName= '99 Zilzal' where id=99");
    await txn.execute("update surah set searchName= '100 Adiyat' where id=100");
    await txn.execute("update surah set searchName= '101 Karia' where id=101");
    await txn.execute("update surah set searchName= '102 Tekasür' where id=102");
    await txn.execute("update surah set searchName= '103 Asr' where id=103");
    await txn.execute("update surah set searchName= '104 Hümeze' where id=104");
    await txn.execute("update surah set searchName= '105 Fil' where id=105");
    await txn.execute("update surah set searchName= '106 Kureyş' where id=106");
    await txn.execute("update surah set searchName= '107 Maun' where id=107");
    await txn.execute("update surah set searchName= '108 Kevser' where id=108");
    await txn.execute("update surah set searchName= '109 Kafirun' where id=109");
    await txn.execute("update surah set searchName= '110 Nasr' where id=110");
    await txn.execute("update surah set searchName= '111 Tebbet' where id=111");
    await txn.execute("update surah set searchName= '112 İhlas' where id=112");
    await txn.execute("update surah set searchName= '113 Felak' where id=113");
    await txn.execute("update surah set searchName= '114 Nas' where id=114");
  });
});