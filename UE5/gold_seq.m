function y = gold_seq(len_sequence,pair_ind1,pair_ind2,oversmpl)

% #########################################################################
% ## gold_seq.m : Berechnung von Gold-Sequenzen                          ##
% #########################################################################
%
% INPUT:
%   len_sequence .... Länger der Codes
%   pair_ind1 ....... Nummer des ersten Codes des "preferred pair"
%   pair_ind2 ....... Nummer des zweiten Codes des "preferred pair"
%   oversmpl ........ oversampling
%
% OUTPUT:
%   y       :  Matrix mit Goldsequenz in jeder Spalte
%              erste und zweite Spalte enthaelt Mutter-m-Sequenzen
%              Anzahl der Spalten entspricht der Laenge der Verzoegerung + 2

m = log2(len_sequence+1);      % len_sequence = 2^m-1;
                               % Länge des Schieberegisters

% Bestimmung aller primitiven Polynome
A = gfprimfd(m,'all');

delay = 0:2^m-2;
start1 = [zeros(m-1,1);1];
start2 = [zeros(m-1,1);1];
g_p = ones(oversmpl,1)/sqrt(oversmpl);
len_sequence = 2^m-1;
                  
fb_poly1 = A(pair_ind1,:); 
fb_poly2 = A(pair_ind2,:);

y = zeros(len_sequence*oversmpl,length(delay));

y1 = sign(m_seq(fb_poly1,start1,len_sequence));
y2 = sign(m_seq(fb_poly2,start2,len_sequence));

for tau = 1:length(delay)
  tmp = y1 .* [y2(delay(tau)+1:len_sequence);y2(1:delay(tau))];
  tmp = [tmp'; zeros(oversmpl-1,len_sequence)];               % Ueberabtastung
  tmp = tmp(:)./sqrt(len_sequence);                           % Normierung

  y(:,tau) = conv(tmp(1:oversmpl*(len_sequence-1)+1),g_p);
end;

% Anfuegen der Muttersequenz zur Ausgangssequenz
y1 = [y1'; zeros(oversmpl-1,len_sequence)];                    % Ueberabtastung
y1 = y1(:)./sqrt(len_sequence);                                % Normierung
y1 = conv(y1(1:oversmpl*(len_sequence-1)+1),g_p);

y2 = [y2'; zeros(oversmpl-1,len_sequence)];                    % Ueberabtastung
y2 = y2(:)./sqrt(len_sequence);                                % Normierung
y2 = conv(y2(1:oversmpl*(len_sequence-1)+1),g_p);

y = [y1 y2 y];

%   m       :  Laenge des Schieberegisters 
%   delay   :  Verzoegerung des zweiten Muttercodes (innerhalb [0 ... 2^m-2])
%   fb_poly1:  Feedback Polynom von Code 1, stellt Feedback Pol. in GF(2) dar 
%   fb_poly2:  Feedback Polynom von Code 2, stellt Feedback Pol. in GF(2) dar 
%   start1  :  Start Vektor (Laenge m) von Mutter Code 1
%   start2  :  Start Vektor (Laenge m) von Mutter Code 2
%   n_chip  :  Anzahl der auzugebenen Chips (optional)
%   oversmpl:  Ueberabtastungsfaktor (optional)
%   g_p     :  Impulsform der Chips (optional)