%== Dynamic clause management ===============================================

:- dynamic(propOwner/2).
:- dynamic(propType/2).
:- dynamic(propPrice/2).
:- dynamic(propRent/2).
:- dynamic(displayProp/3).

%== Facts ===================================================================

propTypeField(-1, 'Belum diakuisisi').
propTypeField(0, 'Tanah').
propTypeField(1, 'Bangunan 1').
propTypeField(2, 'Bangunan 2').
propTypeField(3, 'Bangunan 3').
propTypeField(4, 'Landmark').

locField(0, go, 'GO', 'GO', 'Mendapatkan 2000 sebagai gaji.').
locField(1, a1, 'A1', 'Cikarang', 'Desa di Kecamatan Cisewu.').
locField(3, a2, 'A2', 'Cimaskara', 'Desa di Provinsi Jawa Barat.').
locField(5, b1, 'B1', 'Cisewu', 'Kecamatan di Kabupaten Garut.').
locField(6, b2, 'B2', 'Cibeureum', 'kecamatan di Kota Cimahi.').
locField(7, b3, 'B3', 'Cikadu', 'Desa di Kecamatan Cikalong.').
locField(9, c1, 'C1', 'Ciwaringin', 'kecamatan di Kabupaten Cirebon .').
locField(10, c2, 'C2', 'Cikole', 'Kecamatan di Kabupaten Sukabumi.').
locField(11, c3, 'C3', 'Cibinong', 'Kecamatan di Kabupaten Cianjur.').
locField(13, d1, 'D1', 'Cikeruh', 'Desa di Kecamatan Jatinangor.').
locField(14, d2, 'D2', 'Cibiru', 'Kecamatan di Kota Bandung.').
locField(15, d3, 'D3', 'Cipadung', 'Desa di Kecamatan Cibiru.').
locField(17, e1, 'E1', 'Cileunyi', 'Kecamatan di Kabupaten Bandung.').
locField(18, e2, 'E2', 'Cinunuk', 'Desa di Kecamatan Cileunyi.').
locField(19, e3, 'E3', 'Cipeundeuy', 'Kecamatan di Kabupaten Bandung Barat.').
locField(21, f1, 'F1', 'Ciroyom', 'Desa di Kecamatan Cipeundeuy.').
locField(22, f2, 'F2', 'Jakarta', 'Ibu Kota Indonesia.').
locField(23, f3, 'F3', 'Cikalong', 'Kecamatan di Kabupaten Tasikmalaya.').
locField(25, g1, 'G1', 'Cimahi', 'Kota otonom di Provinsi Jawa Barat.').
locField(26, g2, 'G2', 'Cianjur', 'Kabupaten di Provinsi Jawa Barat.').
locField(27, g3, 'G3', 'Cirebon', 'Kota di Provinsi Jawa Barat.').
locField(30, h1, 'H1', 'Bandung', 'Ibu Kota Provinsi Jawa Barat.').
locField(31, h2, 'H2', 'Jatinangor', 'Kecamatan di Kabupaten Sumedang.').
locField(2, bg, 'BG', 'Bonus Game', 'Dapat bermain Bonus Game.').
locField(4, cc1, 'CC', 'Chance Card', 'Mendapatkan kartu secara acak.').
locField(20, cc2, 'CC', 'Chance Card', 'Mendapatkan kartu secara acak.').
locField(29, cc3, 'CC', 'Chance Card', 'Mendapatkan kartu secara acak.').
locField(12, tx, 'TX', 'Tax', 'Membayar pajak sebesar 10 persen dari total aset.').
locField(28, tx, 'TX', 'Tax', 'Membayar pajak sebesar 10 persen dari total aset.').
locField(16, fp, 'FP', 'Free Parking', 'Parkir gratis.').
locField(24, wt, 'WT', 'World Tour', 'Berjalan ke lokasi yang pemain inginkan.').
locField(8, jl, 'JL', 'Jail', 'terjebak dalam penjara selama 3 giliran.').

propAcqui(a1, 200,50,150,250,250).
propAcqui(a2, 200,50,150,250,250).
propAcqui(b1, 240,100,300,500,500).
propAcqui(b2, 240,100,300,500,500).
propAcqui(b3, 240,100,300,500,500).
propAcqui(c1, 360,150,450,750,750).
propAcqui(c2, 360,150,450,750,750).
propAcqui(c3, 360,150,450,750,750).
propAcqui(d1, 470,200,600,1000,1000).
propAcqui(d2, 470,200,600,1000,1000).
propAcqui(d3, 470,200,600,1000,1000).
propAcqui(e1, 600,250,750,1250,1250).
propAcqui(e2, 600,250,750,1250,1250).
propAcqui(e3, 600,250,750,1250,1250).
propAcqui(f1, 750,300,900,1500,1500).
propAcqui(f2, 750,300,900,1500,1500).
propAcqui(f3,750,300,900,1500,1500).
propAcqui(g1, 850,350,1050,1750,1750).
propAcqui(g2, 850,350,1050,1750,1750).
propAcqui(g3, 850,350,1050,1750,1750).
propAcqui(h1, 1000,400,1200,2000,2000).
propAcqui(h2,1000,400,1200,2000,2000).

propRent(a1, 100,150,300,500,750).
propRent(a2, 100,150,300,500,750).
propRent(b1, 120,220,500,800,1200).
propRent(b2, 120,220,500,800,1200).
propRent(b3, 120,220,500,800,1200).
propRent(c1, 180,300,750,1500,1950).
propRent(c2, 180,300,750,1500,1950).
propRent(c3, 180,300,750,1500,1950).
propRent(d1, 240,350,900,1800,2500).
propRent(d2, 240,350,900,1800,2500).
propRent(d3, 240,350,900,1800,2500).
propRent(e1, 300,500,1100,1800,2700).
propRent(e2, 300,500,1100,1800,2700).
propRent(e3, 300,500,1100,1800,2700).
propRent(f1, 350,650,1400,2300,3000).
propRent(f2, 350,650,1400,2300,3000).
propRent(f3, 350,650,1400,2300,3000).
propRent(g1, 400,750,1700,2500,3300).
propRent(g2, 400,750,1700,2500,3300).
propRent(g3, 400,750,1700,2500,3300).
propRent(h1,500,900,1900,2700,3600).
propRent(h2,500,900,1900,2700,3600).

%== States ==================================================================

propOwner(a1, null).
propOwner(a2, null).
propOwner(b2, null).
propOwner(b1, null).
propOwner(b3, null).
propOwner(c1, null).
propOwner(c2, null).
propOwner(c3, null).
propOwner(d1, null).
propOwner(d2, null).
propOwner(d3, null).
propOwner(e1, null).
propOwner(e2, null).
propOwner(e3, null).
propOwner(f1, null).
propOwner(f2, null).
propOwner(f3, null).
propOwner(g1, null).
propOwner(g2, null).
propOwner(g3, null).
propOwner(h1, null).
propOwner(h2, null).

propType(a1, -1).
propType(a2, -1).
propType(b1, -1).
propType(b2, -1).
propType(b3, -1).
propType(c1, -1).
propType(c2, -1).
propType(c3, -1).
propType(d1, -1).
propType(d2, -1).
propType(d3, -1).
propType(e1, -1).
propType(e2, -1).
propType(e3, -1).
propType(f1, -1).
propType(f2, -1).
propType(f3, -1).
propType(g1, -1).
propType(g2, -1).
propType(g3, -1).
propType(h1, -1).
propType(h2, -1).

propPrice(a1, 0). 
propPrice(a2, 0).
propPrice(b1, 0).
propPrice(b2, 0).
propPrice(b3, 0).
propPrice(c1, 0).
propPrice(c2, 0).
propPrice(c3, 0).
propPrice(d1, 0).
propPrice(d2, 0).
propPrice(d3, 0).
propPrice(e1, 0).
propPrice(e2, 0).
propPrice(e3, 0).
propPrice(f1, 0).
propPrice(f2, 0).
propPrice(f3, 0).
propPrice(g1, 0).
propPrice(g2, 0).
propPrice(g3, 0).
propPrice(h1, 0).
propPrice(h2, 0).

propRent(a1, 0).
propRent(a2, 0).
propRent(b1, 0).
propRent(b2, 0).
propRent(b3, 0).
propRent(c1, 0).
propRent(c2, 0).
propRent(c3, 0).
propRent(d1, 0).
propRent(d2, 0).
propRent(d3, 0).
propRent(e1, 0).
propRent(e2, 0).
propRent(e3, 0).
propRent(f1, 0).
propRent(f2, 0).
propRent(f3, 0).
propRent(g1, 0).
propRent(g2, 0).
propRent(g3, 0).
propRent(h1, 0).
propRent(h2, 0).