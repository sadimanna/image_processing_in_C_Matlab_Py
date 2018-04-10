function timg = bilin_interp(img,sx,sy)
    [r,c] = size(img);
    rnew = sx*r;
    cnew = sy*c;
    timg = zeros(rnew,cnew);
    for i=1:rnew
        for j=1:cnew
            rf = i/sx;
            cf = j/sy;
            r0 = floor(rf);
            c0 = floor(cf);
            if r0<1
                r0=1;
            end
            if r0 > r-1
                r0 = r-1;
            end
            if c0<1
                c0=1;
            end
            if c0 > c-1
                c0 = c-1;
            end
            delr = rf-r0;
            delc = cf-c0;
            timg(i,j) = img(r0,c0)*(1-delr)*(1-delc)+...
                img(r0+1,c0)*delr*(1-delc)+...
                img(r0,c0+1)*(1-delr)*delc+...
                img(r0+1,c0+1)*delr*delc;
        end
    end
end

