function otsuimg = otsu(img)
    optk = 0;
    eta = inf;
    [r,c] = size(img);
    pi = [];
    mg = 0;
    gv = 0;
    for pv=0:255
        pi(pv+1) = nnz(img==pv)/(r*c);
        mg = mg + pi(pv+1);
    end
    disp(pi)
    for pv = 0:255
        gv = gv+pi(pv+1)*(pv-mg)^2;
    end
    disp(gv)
    for k=1:255
        m1 = 0;
        p1k = sum(pi(1:k+1));
        for pv=0:k
            m1 = m1+pv*pi(pv+1);
        end
        m1 = m1/p1k;
        gb = ((mg*p1k-m1)^2)/(p1k*(1-p1k));
        
        neweta = gb/gv;
        if neweta<eta
            eta=neweta;
            optk = k;
        end 
    end
    disp(optk)
    otsuimg = zeros(r,c);
    otsuimg(img>optk)=255;
    otsuimg(img<=optk)=0;
end