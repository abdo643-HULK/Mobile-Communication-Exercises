function y = get_m_sequences(len_sequence,oversmpl)

% #########################################################################
% ##  -----------------------------------------------------------------  ##
% ##  Aufgabe MKS4_1_1: m-Sequenzen                                      ##
% ##  -----------------------------------------------------------------  ##
% ##  benötigte Matlab-Dateien: gfprimfd.m,(comm. toolbox), m_seq.m      ##
% ##                                                                     ##
% #########################################################################

% INPUT:
%   len_sequence .... Codelänge
%   oversmpl ........ Überabtastung
% OUTPUT:
%   y ............... Matrix der Codes (Spalten = Anzahl der Codes)


m = log2(len_sequence+1);       % len_sequence = 2^m-1;         
                                % Länge des Schieberegisters

g_p = ones(oversmpl,1)/sqrt(oversmpl);     % Rechteckimpulse mit normierter Energie

% Bestimmung aller primitiven Polynome
A = gfprimfd(m,'all');
[N_user,c] = size(A);

% m-Sequenzen
y_len = len_sequence*oversmpl;
y     = zeros(y_len,N_user);
start = [zeros(m-1,1);1];
for j=1:N_user
  y(:,j) = m_seq(A(j,:),start,len_sequence,oversmpl,g_p);
%   plot(y(:,j))
%   disp('Weiter mit beliebiger Taste');
%   pause
end

