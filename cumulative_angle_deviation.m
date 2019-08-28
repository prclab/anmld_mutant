%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This code was written by Burcin Acar, in order to to compare virtual  
%%% 
%%% torsional angle changes between WT and mutant simulations. 
%%% It calculates torsional angles of four consecutive residue CAs residing
%%% in each conformation of the ANM-LD trajectory for WT and mutants.
%%% Then it calculates the cumulative angle deviation from WT for mutants. 
%%%                                                                                              %                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc

%% Inputs
resno=1144; %residue number
fno=100; % frame number 
ANM1hA=[11 12 78 79 80 81 82 83 207 208 211 228 ...
    232 233 267 269 270 271 272 273 275 313 314 315 316 317 318 319 ...
    320 321 323]; %hinge residues

% Reading trajectory coordinate files
count=0;
count2=0;
fn2={'experimented/exp','experimented/WT'} %mutant and WT trajectory files
for fn=fn2
    fname=sprintf('%s/BtuCD*CA.coord',fn{1})
    count=count+1
    a{count}=dir(fname);
    if count==1
    b=a{count};
    end
    if count==2
        for f2=1:length(a{count})
            b(length(a{1})+f2).name=a{count}(f2).name;
        
        end
    elseif count==3
         for f3=1:length(a{count})
            b(length(a{1})+f2+f3).name=a{count}(f3).name;
        
        end
         
    end
end

% Preallocation
ta2=zeros(fno,resno-3,length(b));
varta=zeros(1,resno-3);

%% Extracting XYZ Coordinates
for ln=1:length(a)
for w=1:length(a{ln})
count2=count2+1;    
 CAcoordfile=sprintf('%s/%s',fn2{ln},a{ln}(w).name);
%% Read coordinate file from CA coord data
fid=fopen(CAcoordfile,'r');
data=textscan(fid,'%f','HeaderLines',1,'Delimiter','Whitespace');
fclose(fid);
fnoi=length(data{1})/(resno*3);
datapr=reshape(data{1},3,resno*fnoi); datap=datapr';

x=zeros(resno,fno); y=x; z=x;
for i=1:resno
    for Q=1:fno
    x(i,Q)=datap((Q-1)*resno+i,1);
    y(i,Q)=datap((Q-1)*resno+i,2);
    z(i,Q)=datap((Q-1)*resno+i,3);
    end
end

%% Calculation of virtual torsional angles


v=cell(resno-1); n=cell(resno-2); m=n;

for i=1:fno
    t=[x(:,i) y(:,i) z(:,i)] ;
    for j=1:resno-1        
        v{j}=t(j+1,:)-t(j,:);
    end
    for l=1:resno-2
        n{l}=cross(v{l},v{l+1})/norm(cross(v{l},v{l+1})); 
        m{l}=cross(n{l},v{l+1}/norm(v{l+1}));   
    end
    for k=1:resno-3
        xp=dot(n{k}, n{k+1});
        yp=dot(m{k}, n{k+1});
        ta2(i,k,count2)=atan2(yp,xp); %torsional angles in radian
    end
end
end
end
%% Calculation of angle deviations
inef=[length(b)-1 length(b)];
eff=setdiff(1:length(b),inef);

for l=1:fno
for k=1:resno-3
        varta(k,l)=circ_std(reshape(ta2(l,k,inef),1,length(inef)));
        minif(k,l)=circ_mean(reshape(ta2(l,k,inef),1,length(inef)));
end
end


for i=1:length(eff)
    for k=1:resno-3
        for l=1:fno
            difmin(l,k,i)=abs(circ_dist(ta2(l,k,eff(i)),minif(k,l)));
        end
    end
end

for i=1:length(inef)
    for k=1:resno-3
        for l=1:fno
            difmin2(l,k,i)=abs(circ_dist(ta2(l,k,inef(i)),minif(k,l)));
        end
    end
end

%% Plotting the angle deviation scores
zu=struct2cell(b);
bn=difmin(:,unique([ANM1hA ANM1hA-1 ANM1hA-2 ANM1hA-3]),:); %consecutive CAs

bn2=reshape(bn,size(bn,1)*size(bn,2),size(bn,3))
dr4=sum(sum(bn2,1),1)
dr3=reshape(dr4,1,length(eff))
scatter(zeros(1,length(eff)),dr3(eff),150,'filled','b')
hold on

for i=1:length(b)-2
 t=text(0.05,dr3(i),zu{1,i}(end-12:end-8))
 t.FontSize=16;
 end
ylabel('Angular Deviation')
set(gca,'FontSize',30)
ylim([min(dr3)-5 max(dr3)+5])
set(gca,'XTick',[])


