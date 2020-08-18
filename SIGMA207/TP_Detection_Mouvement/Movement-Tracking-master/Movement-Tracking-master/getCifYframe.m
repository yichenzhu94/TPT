function frame = getCifYframe(file, k)
%GETCIFYFRAME gets a single image from a CIF/Y video
%   FRAME = GETCIFYFRAME(FILE, K) gets the K-th image from the video
%   sequence stored in the file FILE, in the format CIF 4:0:0 (luminance
%   only)
%   

frame=[];
fid = fopen(file,'r');
if fid < 0, fprintf('File %s does not exist!', nomefile); return; end;
rows = 288; cols = 352;
bytes_per_frame = rows * cols;
byte_shift = bytes_per_frame * (k-1) ;
fseek(fid,byte_shift,'bof');
frame = fread(fid, [cols rows], 'uchar');
fclose(fid);
frame = frame';

