function rgb = colorTransform(ycbcr)
%COLORTRANSFORM from YUV to RGB

% color space transformation
T = [65.481 128.553 24.966;...
    -37.797 -74.203 112; ...
    112 -93.786 -18.214];
Tinv= inv(T);
offset =Tinv*[16;128;128];
rgb = zeros(288,352,3);
for p = 1:3
    rgb(:,:,p) =Tinv(p,1)*ycbcr(:,:,1)+Tinv(p,2)*ycbcr(:,:,2)+ Tinv(p,3)*ycbcr(:,:,3)-offset(p);
end
rgb = min(max(rgb,0.0),1.0);