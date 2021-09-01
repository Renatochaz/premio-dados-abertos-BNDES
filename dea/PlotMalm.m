%Limpar
cla
%Matriz de resultados para plotar
results=[
%Ef2010	D0t	Dt0	Ef2017	Status AE	AT	IM	UF
1	1.007490263	1.065102583	1 2	1	0.972578601	0.972578601	%RS
1	1.013186139	1.76170597	1 2	1	0.758364346	0.758364346	%SP
1	1.010553473	1.848058339	1 2	1	0.739472131	0.739472131	%SC
0.056670444	0.536513721	0.222029463	1 1	17.64588243	0.370052567	6.529904096	%BA
0.263981095	1.041261446	1.026732804	1 1	3.788150061	0.5174133	1.960039225	%PE
0.385590369	1.005581447	1.169916511	1 1	2.593425771	0.575697415	1.493028514	%RJ
0.040381864	1.005034778	0.15018268	0.480387822 0	11.89612808	0.750028565	8.922435871	%PR
0.005014964	0.007449939	0.01651792	0.061540099 0	12.2712946	0.191713844	2.352577063	%GO
0.088441168	1.001272265	0.265283237	0.082377244 0	0.931435503	2.013004728	1.874984071	%MG
0.124505729	0.020112678	0.58942167	0.066678331 0	0.535544282	0.252420257	0.135182225	%CE
0.071385149	0.000984935	0.207959495	0.003757609 0	0.05263852	0.299959443	0.015789421	%MS
];

%Separar resultados por variáveis
x=results(:,end-2)
y=results(:,end-1)
z=results(:,end)
zz=results(:,end-3)

%Plotar resultados (3D + cor)
scatter3(x, y, z, 40, zz, 'filled')

%Especificações do gráfico
ax = gca;
%ax.XDir = 'reverse';
xlabel('AE')
ylabel('AT')
zlabel('IM')

%Legenda da barra de cores
cb = colorbar;
cb.Label.String = 'Número de vezes na fronteira de eficientes';

%Legenda dos pontos
a = [1:11]';
b = num2str(a); 
c = cellstr(b);

%Colocar a legenda deslocado do ponto
dx = 0.1; 
dy = 0.1; 
dz = 0.1; 

%Plotar legenda
text(x+dx, y+dy, z+dz, c, 'Fontsize', 10);
