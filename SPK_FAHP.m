mataPelajaran = {'Matematika' 'Fisika' 'Kimia' 'Biologi'};
data = [ 180 65 50
         150 65 45
         150 75 65
         140 80 70];

%batas kriteria
maksWaktuPengerjaan = 200;
maksJumlahSoal = 100;
maksJawabanBenar = 100;

data(:,1) = data(:,1) / maksWaktuPengerjaan;
data(:,2) = data(:,2) / maksJumlahSoal;
data(:,3) = data(:,3) / maksJawabanBenar;

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
    disp('Mata Pelajaran, Skor Akhir, Kesimpulan')
end

for i = 1:size(ahp, 1)
 if ahp(i) < 0.6
 status = 'Kurang';
 elseif ahp(i) < 0.7
 status = 'Cukup';
 elseif ahp(i) < 0.8
 status = 'Baik';
 else
 status = 'Sangat Baik';
 end
 
 disp([char(mataPelajaran(i)), blanks(13 -cellfun('length',mataPelajaran(i))), ', ', ...
        num2str(ahp(i)), blanks(10 -length(num2str(ahp(i)))), ', ', ...
        char(status)])
 end