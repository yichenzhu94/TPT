function z = filesize(x)
%FILESIZE returns the size of a file in bytes
fid = fopen(x,'r');
if fid == -1,
    z=-1;
    return
else
    fseek(fid,0,'eof');
    z=ftell(fid);
    fclose(fid);
end
