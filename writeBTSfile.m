function writeBTSfile(WindFileStruct)
l=30;
fid = fopen('BTS.bts','w');
fwrite(fid, 7, 'int16'); % TurbSim format identifier (should = 7, just 'cause I like that number), INT(2)
fwrite(fid, WindFileStruct.Nz, 'int32'); % the number of grid points vertically, INT(4)
fwrite(fid, WindFileStruct.Ny, 'int32'); % the number of grid points laterally, INT(4)
fwrite(fid, 0, 'int32'); % the number of tower points, INT(4)
fwrite(fid, WindFileStruct.N, 'int32'); % the number of time steps, INT(4)

fwrite(fid, WindFileStruct.dz, 'float32'); % grid spacing in vertical direction, REAL(4), in m
fwrite(fid, WindFileStruct.dy, 'float32'); % grid spacing in lateral direction, REAL(4), in m
fwrite(fid, WindFileStruct.dt, 'float32'); % grid spacing in delta time, REAL(4), in m/s
fwrite(fid, WindFileStruct.U0, 'float32'); % the mean wind speed at hub height, REAL(4), in m/s
fwrite(fid, WindFileStruct.HubHt, 'float32'); % height of the hub, REAL(4), in m
fwrite(fid, WindFileStruct.Zbottom, 'float32'); % height of the bottom of the grid, REAL(4), in m

fwrite(fid, 1000, 'float32'); % the U-component slope for scaling, REAL(4)
fwrite(fid, 0, 'float32'); % the U-component offset for scaling, REAL(4)
fwrite(fid, 1000, 'float32'); % the V-component slope for scaling, REAL(4)
fwrite(fid, 0, 'float32'); % the V-component offset for scaling, REAL(4)
fwrite(fid, 1000, 'float32'); % the W-component slope for scaling, REAL(4)
fwrite(fid, 0, 'float32'); % the W-component offset for scaling, REAL(4)
fwrite(fid, l, 'int32'); % the number of characters in the description string, max 200, INT(4)
for ii = 1:l
    fwrite(fid, version(ii), 'int8'); % the ASCII integer representation of the character string
end

v = zeros(1,3);
cnt = 0;
for it = 1:WindFileStruct.N
    for iz = 1:WindFileStruct.Nz
        for iy = 1:WindFileStruct.Ny
            for ii = 1:3
                cnt = cnt + 1;
                v(ii) = WindFileStruct.WF(it,iy,iz,ii)*1000;
            end
            fwrite(fid, v, 'int16');
        end
    end
end