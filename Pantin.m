classdef Pantin
    properties
      
    end
    
    methods
        function Draw(obj)
        end
        
        function y = CentreDeMasse(obj)
            y = [0, 0, 0];
        end
        function y = MomentInertie(obj)
            y = [0 0 0; 0 0 0; 0 0 0];
        end
        function y = AccelerationAngulaire(obj, vx, vy, vz)
            ax = 0;
            ay = 0;
            az = 0;
            y = [ax, ay, az];
        end

    end
    
end
    


% 
% clear;
% hold on
% % [X,Y,Z] = cylinder(1);
% % z(1, :) = 10;
% % surf(X+1,Y,Z);
% % 
% % [X,Y,Z] = cylinder(2);
% % surf(X+2,Y,Z);
% % 
% % [X,Y,Z] = cylinder(3);
% % surf(X+3,Y,Z);
% % 
%  [X,Y,Z] = sphere(12, 100);
%  surf(X,Y,Z + 10);
% 
% [x,y,z] = cylinder(10);
% h = hgtransform;
% surf(x,y,z, 'Parent', h, 'FaceColor', [1 1 0.5]);
% 
% % Make it taller
% set(h, 'Matrix', makehgtform('scale', [1 1 10]))
% 
% % Tip it over and make it taller
% set(h, 'Matrix', makehgtform('xrotate', pi/2))
