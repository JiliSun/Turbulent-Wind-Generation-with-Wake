clear;close;clc;
    Filename = ['BTS.bts'];   
    fid1  = fopen(Filename);
    tmp   = fread( fid1, 1, 'int16');        % TurbSim format identifier (should = 7 or 8 if periodic), INT(2)
    nz    = fread( fid1, 3, 'int32');        % the number of grid points vertically, INT(4
    nt    = fread( fid1, 1, 'int32');        % the number of time steps, INT(4)
    dz    = fread( fid1, 12, 'float32');     % grid spacing in vertical direction, REAL(4), in m
    useless = fread(fid1,664,'int8' );       % Discarded unwanted characters
    v = fread( fid1, nt*16000 , 'int16' ); 
    fclose(fid1);
     
     fid0  = fopen( 'BTSmodel.bts' );
     tmp0   = fread( fid0, 66, 'int8');   
     nchar    = fread( fid0, 1, 'int32');     % the number of characters in the description string, max 200, INT(4)
     asciiINT = fread( fid0, nchar, 'int8' ); % the ASCII integer representation of the character string 
     fclose(fid0);
     
     way = ['w+'];
     eval( [ 'fid  = fopen(Filename,way)']);
     %% OUTPUT
     fwrite(fid,[tmp],'uint16');
     fwrite(fid,[nz],'uint32');
     fwrite(fid,[nt],'uint32');
     fwrite(fid,[dz],'float32');
     fwrite(fid,[nchar],'uint32');
     fwrite(fid,[asciiINT],'uint8');
     fwrite(fid,[v],'uint16');     
     fclose(fid);
