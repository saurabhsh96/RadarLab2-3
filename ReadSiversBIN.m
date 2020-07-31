function [BScans,SweepTime,CentreFreq,Bandwidth,T] = ReadSiversBIN(~,~)
    [file,path] = uigetfile('*.bin','Select the data file'); % select data file to load
    fid = fopen([path file]);
    Nsamp = fread(fid,1,'int32');
    SweepTime = fread(fid,1,'double');
    CentreFreq = fread(fid,1,'double');
    Bandwidth = fread(fid,1,'double');
    A = fread(fid,'int16');
    A = A(1:end-4);
    fseek(fid,-8,0);
    T = fread(fid,1,'long')/1000;
    fclose(fid);
    BScans = reshape(A,Nsamp,[]);
    [~,NSweeps] = size(BScans);
end