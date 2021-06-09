namaProvider = {'Indihome' 'Biznet' 'Citranet' 'MyRepublic' 'FirstMedia'};

data = [ 375 10 100
         350 75 50
         200 25 70
         425 50 60
         470 100 90];

maxHargaLangganan = 500;
maxKecepatanInternet = 100;
maxJangkauan = 100;

data(:,1) = data(:,1) / maxHargaLangganan;
data(:,2) = data(:,2) / maxKecepatanInternet;
data(:,3) = data(:,3) / maxJangkauan;

relasiAntarKriteria = [ 1     2     2
                        0     1     4
                        0     0     1];
 
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};                    
                    
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)
if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Provider, Skor Akhir, Kesimpulan')
end

    for i = 1:size(ahp, 1)
        if ahp(i) < 0.5
            status = 'Kurang';
        elseif ahp(i) < 0.75
            status = 'Cukup';
        elseif ahp(i) >= 0.75
            status = 'Baik';
        end
        
        disp([char(namaProvider(i)), blanks(13 - cellfun('length',namaProvider(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
    end
    