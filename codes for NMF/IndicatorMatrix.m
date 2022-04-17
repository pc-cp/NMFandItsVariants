function Y=IndicatorMatrix(gnd,flag)
% The code specifically write for designing the indicator matrix 
%     in the paper
%   " Integrating Global and Local Structures: A Least Squares Framework for
%    Dimensionality Reduction"  Jianhui Chen, Jieping Ye, Qi Li.
%    CVPR(2007).
%    and
%    "Least Squares Linear Discriminant Analysis" Jieping Ye, ICML 07
%   Input:
%            gnd - label of each data point
% Output:
%             Y - indicator matrix 
%                   Y is of size  c x n,where n is the number of  smaples,c is the number of class.
%                   Y is usually defined as 
%   
%                    -  sqrt(n/nj)-sqrt(nj/n), if yi=j
%            Y=
%                   - -sqrt(nj/n),                otherwise
% written by xin shu  ahjmsshx AT sjtu.edu.cn
%     02/05/2011 version 1
%    27/10/2011. version 2 
% Using flag=2

if nargin<3
    flag=2;% usually used....
end
n=length(gnd);
Class=unique(gnd);
nClass=length(Class);
switch flag
    case 3
        i=1;
        Y=zeros(n,nClass);
        while(i<n+1)
            for j=1:nClass
                nj=length(find(gnd==j));
                if(gnd(i)==j)
                    Y(i,j)=sqrt(n/nj)-sqrt(nj/n);
                else
                    Y(i,j)=-sqrt(nj/n);
                end
            end
            i=i+1;
        end
    case 2
        i=1;
        Y=zeros(n,nClass);
        while(i<n+1)
            for j=1:nClass
                if(gnd(i)==j)
                    Y(i,j)=1;
                else
                    Y(i,j)=0;
                end
            end
            i=i+1;
        end
    case 1
        i=1;
        Y=zeros(n,nClass);
        while(i<n+1)
            for j=1:nClass
                if(gnd(i)==j)
                    Y(i,j)=1;
                else
                    Y(i,j)=-1/(nClass);
                end
            end
            i=i+1;
        end
    otherwise
        error('The corresponding Indicator matrix is not exist..')
end
Y=Y';