classdef Pantin
    properties (Constant)
        LongueurMembre = 0.75;
        MVolMembre = 1052;
        MVolCorps = 953;
        
        RayonJambe = 0.06;
        CMJambeD = [-10 0 LongueurMembre/2]; 
        CMJambeG = [10 0 LongueurMembre/2]; 
        
        RayonTronc = 0.15;
        LongueurTronc = 0.7;
        CMTronc = [0 0 (LongueurMembre+LongueurTronc/2)];
        
        RayonCou = 0.04;
        LongueurCou = 0.1;
        CMCou = [0 0 (LongueurMembre+LongueurTronc+LongueurCou/2)];
        
        RayonTete = 0.1;
        MVolTete = 1056;
        CMTete = [0 0 (LongueurMembre+LongueurTronc+LongueurCou+RayonTete)];
        
        RayonBras = 0.03;
        CMBrasDRepos = [-(RayonTronc + RayonBras) 0 (LongueurMembre/2 + LongueurTronc)];
        CMBrasGRepos = [(RayonTronc + RayonBras) 0 (LongueurMembre/2 + LongueurTronc)];
        CMBrasDLeve = [-(RayonTronc + RayonBras) 0 (LongueurMembre + LongueurTronc - RayonBras)];
        CMBrasGLeve = [(RayonTronc + LongueurMembre/2) 0 (LongueurMembre + LongueurTronc - RayonBras)];
        
    end
    
    properties
        Cou;
        Tronc;
        JambeD;
        JambeG;
        BrasD;
        BrasG;
        
        isBrasLeve;
    end
    
    methods
	    function obj = Pantin(IsBrasLeve)
            if (IsBrasLeve == 0 || IsBrasLeve == 1)
                obj.isBrasLeve = IsBrasLeve;
            else
                error('le parametre doit etre 0 ou 1');
            end
            
            obj.Cou = Cylindre(obj.MVolCorps, obj.RayonCou, obj.LongueurCou, 1, 1, 1);
            obj.Tronc = Cylindre(obj.MVolCorps, obj.RayonTronc, obj.LongueurTronc, 1, 1, 1);
            obj.JambeD = Cylindre(obj.MVolMembre, obj.RayonJambe, obj.LongueurMembre, 1, 1, 1);
            obj.JambeG = Cylindre(obj.MVolMembre, obj.RayonJambe, obj.LongueurMembre, 1, 1, 1);
            obj.BrasD = Cylindre(obj.MVolMembre, obj.RayonBras, obj.LongueurMembre, 1, 1, 1);
            obj.BrasG = Cylindre(obj.MVolMembre, obj.RayonBras, obj.LongueurMembre, 1, 1, 1);
        end
		
        function Draw(obj)
            hold on
            
            %tete
            [X,Y,Z] = sphere(12);
            surf(obj.RayonTete*X, obj.RayonTete*Y, obj.RayonTete*Z);
            
            %cou
            [X,Y,Z] = cylinder(obj.Cou.Rayon);
            surf(X,Y,Z-obj.RayonTete*2);
            
            %tronc
            [X,Y,Z] = cylinder(obj.Tronc.Rayon);
            surf(X,Y,Z-obj.RayonTete*2-1);
            
            %brasD
            if(obj.isBrasLeve == 0)
                [X,Y,Z] = cylinder(obj.BrasD.Rayon);
                surf(X+obj.Tronc*Rayon+obj.BrasD.Rayon,Y,Z-obj.RayonTete*2-1);
            else if(obj.isBrasLeve == 1)
                    [X,Y,Z] = cylinder(obj.BrasD.Rayon);
                    bras = surf(X+obj.Tronc.Rayon+obj.BrasD.Rayon,Y,Z-obj.RayonTete*2-1);
                    %                 plot::Translate3d([obj.diametreTronc+obj.diametreBras, 0, obj.diametreTete*2-1], bras);
                    direction = [0 -1 0];
                    rotate(bras,direction, 90);
                end
            end
            
            %brasG
            [X,Y,Z] = cylinder(obj.BrasD.Rayon);
            surf(X-obj.Tronc.Rayon-obj.BrasG.Rayon,Y,Z-obj.RayonTete*2-1);
            
            %jambeD
            [X,Y,Z] = cylinder(obj.JambeD.Rayon);
            surf(X + obj.Tronc.Rayon - obj.JambeD.Rayon, Y, Z-obj.RayonTete*2-2);
            
            %jambeG
            [X,Y,Z] = cylinder(obj.JambeG.Rayon);
            surf(X-obj.Tronc.Rayon + obj.JambeG.Rayon,Y,Z-obj.RayonTete*2-2);
            
        end
        
        function y = CentreDeMasse(obj)
            total = obj.Cou.Masse + obj.Tronc.Masse + obj.JambeD.Masse + obj.JambeG.Masse + obj.BrasD.Masse + obj.BrasG.Masse;
            A = obj.Cou.CentreP() + obj.Tronc.CentreP() + obj.JambeD.CentreP() + obj.JambeG.CentreP() + obj.BrasD.CentreP() + obj.BrasG.CentreP() + obj.Tete;
            y = A/total;
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
