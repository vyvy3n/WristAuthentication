function [DD,Pos_w]=datasort(MM)
    M=MM(:,1);
    Pos=[];
    k=1;
    in=0.045;
    for i=1:length(M)
        if abs(M(i))>in
            Ms(k)=i;
            k=k+1;
        end
    end
    k=k-1;
    M1=diff(Ms);
    [U,V]=sort(M1);
    j=1;
    RRank=[];
    for i=1:length(U)
        if U(i)>40
            RRank(j)=V(i);
            j=j+1;
        end
    end
    RRank=sort(RRank);
    j=2;
    Pos(1)=Ms(1);
    for i=1:length(RRank)
        Pos(j)=Ms(RRank(i));
        j=j+1;
        Pos(j)=Ms(RRank(i)+1);
        j=j+1;
    end
    Pos(j)=Ms(length(Ms));

    j=1;
    for i=1:ceil(length(Pos)/4)
        Pos1(j,1)=Pos(4*i-3);
        Pos1(j,2)=Pos(4*i-2);
        j=j+1;
    end
    Pos=Pos1;
    
    PPPP=size(Pos);
    for i=1:PPPP(1)
        wid1=1;
        wid2=1;
        while (Pos(i,1)-wid1>0)
            if (abs(M(Pos(i,1)-wid1))<0.01)
                break;
            end
            wid1=wid1+1;
        end
        while (Pos(i,2)+wid2<length(M))
            if (abs(M(Pos(i,2)+wid2))<0.01)
                break;
            end
            wid2=wid2+1;
        end
        Pos_w(i,1)=max(Pos(i,1)-wid1,1);
        Pos_w(i,2)=Pos(i,2)+wid2;
    end
    DD={};
    PPPP=size(Pos);
    for i=1:PPPP(1)
        DD{i}=MM(Pos_w(i,1):Pos_w(i,2),:);
    end
end
