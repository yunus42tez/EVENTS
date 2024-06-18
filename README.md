

Selection Screen - Events

   							
	
							
![image](https://github.com/yunus42tez/EVENTS/assets/119634510/e9393fc3-f15b-49a5-8690-3c284b868da6)

 
 
Koşullar
1.	Ödevler için package oluşturup, yine bir ödev requesti içerisine alınacak.
2.	Z'li bir mesaj sınıfı oluşturulacak.
3.	Ekran yürütüldüğünde vbeln boş ise, yeni ekran gelmeden altta mesaj sınıfında tanımlı olan "(Sipariş/Teslimat/Fatura) Numarası Boş  Geçilemez!" hatasını verecek.
4.	Hata mesajında bunlardan (Sipariş/Teslimat/Fatura) 1 tanesi verilecek.
5.	Tüm koşullar sağlandığında da ilgili Belge'nin selecti çalışacak. Ve her belgenin performu ayrı olacak. 
6.	Selectlerden veri gelmezse, "Uygun veri bulunamadı" uyarısı verecek. Bu mesajda text (program içinde) olarak verilecek.
7.	Selectten veri geliyorsa, kaç kayıt geldiğini ekrana yazacak. "Kayıt Sayısı: 12" gibi
 
 
Selectler
1.	Radio-1 Seçilmişse, VBAK tablosuna VBELN ve ERDAT verilecek. Tablodan tüm alanlar alınacak.
2.	Radio-2 Seçilmişse, LIKP tablosuna VBELN, ERDAT ve SPE_LOEKZ verilecek. Tablodan sadece VBELN,  ERDAT,VKORG alanları alınacak.
3.	Radio-3 Seçilmişse, VBRK tablosuna VBELN ve ERDAT verilecek. Tablodan sadece VBELN,  ERDAT,FKART alanları alınacak.
 
 		
