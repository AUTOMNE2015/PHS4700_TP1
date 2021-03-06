% Main function.
function main
    patineur1 = Pantin(0);
    patineur2 = Pantin(1);
    
    %patineur1.Draw();
    %patineur2.Draw();

    fprintf(questionA(patineur1, patineur2));
    fprintf(questionB(patineur1, patineur2));
    fprintf(questionC(patineur1, patineur2));
    fprintf(questionD(patineur1, patineur2));
end

function y = questionA(patineur1, patineur2)
y = '\na) Centre de masses\n';
y = strcat(y, 'patineur 1:\nVecteur de position du centre de masse en m : ');
y = strcat(y, mat2str(patineur1.CentreDeMasse()), '\n');
y = strcat(y, 'patineur 2:\nVecteur de position du centre de masse en m : ');
y = strcat(y, mat2str(patineur2.CentreDeMasse()), '\n');
end

function y = questionB(patineur1, patineur2)
y = '\nb) Moment d''inertie\n';
y = strcat(y, 'patineur 1:\nMatrice d''inertie en kg/m^2 : ');
y = strcat(y, mat2str(patineur1.MomentInertie()), '\n');
y = strcat(y, 'patineur 2:\nMatrice d''inertie  en kg/m^2: ');
y = strcat(y, mat2str(patineur2.MomentInertie()), '\n');
end

function y = questionC(patineur1, patineur2)
y = '\nc) Acceleration angulaire a partir du repos\n';
y = strcat(y, 'patineur 1:\nVecteur d''acceleration angulaire en rad/s^2 :');
y = strcat(y, mat2str(patineur1.AccelerationAngulaire([0 0 0]')), '\n');
y = strcat(y, 'patineur 2:\nVecteur d''acceleration angulaire en rad/s^2 :');
y = strcat(y, mat2str(patineur2.AccelerationAngulaire([0 0 0]')), '\n');
end

function y = questionD(patineur1, patineur2)
y = '\nd) Acceleration angulaire avec une vitesse angulaire initiale de [0,0,10]\n';
y = strcat(y, 'patineur 1:\nVecteur d''acceleration angulaire en rad/s^2 :');
y = strcat(y, mat2str(patineur1.AccelerationAngulaire([0 0 10]')), '\n');
y = strcat(y, 'patineur 2:\nVecteur d''acceleration angulaire en rad/s^2 :');
y = strcat(y, mat2str(patineur2.AccelerationAngulaire([0 0 10]')), '\n');
end