function pairs = find_pairs(len_sequence)

% #########################################################################
% ##  -----------------------------------------------------------------  ##
% ##  Aufgabe MKS4_2_1: Gold-Codes                                       ##
% ##  -----------------------------------------------------------------  ##
% ##  benötigte Matlab-Dateien: gfprimfd.m,(comm. toolbox), m_seq.m      ##
% ##                            kkf_per.m                                ##
% #########################################################################

% INPUT:
%   len_sequence .... Codelänge
% OUTPUT:
%   pairs............ quadratische Matrix mit Einsen an den Stellen mit
%                     den bevorz. Paaren

m = log2(len_sequence+1);      % len_sequence = 2^m-1;
                               % Länge des Schieberegisters

% Bestimmung aller primitiven Polynome
A = gfprimfd(m,'all');
[N_user,c] = size(A);

% m-Sequenzen
y = zeros(len_sequence,N_user);
start = [zeros(m-1,1);1];
for j=1:N_user
  y(:,j) = m_seq(A(j,:),start);
end


tmp   = 2^(floor((m+2)/2));
terms = [-1; -tmp-1; tmp-1];       % drei Korrelationswerte der bev. Paare

pairs = zeros(N_user,N_user);
cntr  = 1;

for i=1:N_user-1
  for j=i+1:N_user
    kkf = kkf_per(y(:,i),y(:,j));
    set = unique(round(kkf*len_sequence));
    if isempty(setdiff(set,terms))
      pairs(i,j) = 1;
      pairs(j,i) = 1;
    end
    cntr = cntr + 1;
  end
end
