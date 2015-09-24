classdef Pantin
    properties (Constant)
       
        LongueurMembre = 0.75;
        MVolMembre = 1052;
        MVolCorps = 953;
        
        RayonJambe = 0.06;
        
        RayonTronc = 0.15;
        LongueurTronc = 0.7;
        
        RayonCou = 0.04;
        LongueurCou = 0.1;
        
        RayonTete = 0.1;
        MVolTete = 1056;
        
        RayonBras = 0.03;
        

        
    end
    
    properties
        Cou;
        Tronc;
        JambeD;
        JambeG;
        BrasD;
        BrasG;
        Tete;
        
        isBrasLeve;
        
        CMJambeD; 
        CMJambeG; 
        CMTronc;
        CMCou;
        CMTete;
        CMBrasDRepos;
        CMBrasGRepos;
        CMBrasDLeve;
        CMBrasGLeve;
    end
    
    methods
	    function obj = Pantin(IsBrasLeve)
            if (IsBrasLeve == 0 || IsBrasLeve == 1)
                obj.isBrasLeve = IsBrasLeve;
            else
                error('le parametre doit etre 0 ou 1');
            end
                   
        obj.CMJambeD = [-10 0 obj.LongueurMembre/2]; 
        obj.CMJambeG = [10 0 obj.LongueurMembre/2]; 
        obj.CMTronc = [0 0 (obj.LongueurMembre+obj.LongueurTronc/2)];
        obj.CMCou = [0 0 (obj.LongueurMembre+obj.LongueurTronc+obj.LongueurCou/2)];
        obj.CMTete = [0 0 (obj.LongueurMembre+obj.LongueurTronc+obj.LongueurCou+obj.RayonTete)];
        obj.CMBrasDRepos = [-(obj.RayonTronc + obj.RayonBras) 0 (obj.LongueurMembre/2 + obj.LongueurTronc)];
        obj.CMBrasGRepos = [(obj.RayonTronc + obj.RayonBras) 0 (obj.LongueurMembre/2 + obj.LongueurTronc)];
        obj.CMBrasDLeve = [-(obj.RayonTronc + obj.LongueurMembre/2) 0 (obj.LongueurMembre + obj.LongueurTronc - obj.RayonBras)];
        obj.CMBrasGLeve = [(obj.RayonTronc + obj.LongueurMembre/2) 0 (obj.LongueurMembre + obj.LongueurTronc - obj.RayonBras)];
  
            obj.Cou = Cylindre(953, 0.04, 0.1, obj.CMCou, 0);
            obj.Tronc = Cylindre(953, 0.15, 0.7, obj.CMTronc, 0);
            obj.JambeD = Cylindre(1052, 0.06, 0.75, obj.CMJambeD, 0);
            obj.JambeG = Cylindre(1052, 0.06, 0.75, obj.CMJambeG, 0);
            if(IsBrasLeve == 1)
                %todo: rotate arm
                obj.BrasD = Cylindre(1052, 0.03, 0.75, obj.CMBrasDLeve, 1);
            else
                obj.BrasD = Cylindre(1052, 0.03, 0.75, obj.CMBrasDRepos, 0);
            end
            obj.BrasG = Cylindre(1052, 0.03, 0.75, obj.CMBrasGRepos, 0);
            obj.Tete = Sphere(1056, 0.1, obj.CMTete);
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
            total = obj.Cou.Masse + obj.Tronc.Masse + obj.JambeD.Masse + obj.JambeG.Masse + obj.BrasD.Masse + obj.BrasG.Masse + obj.Tete.Masse;
            A = obj.Cou.CentreP() + obj.Tronc.CentreP() + obj.JambeD.CentreP() + obj.JambeG.CentreP() + obj.BrasD.CentreP() + obj.BrasG.CentreP() + obj.Tete.CentreP();
            y = A/total;
        end
        
        function y = MomentInertie(obj)
            y = obj.Cou.momentInertieT(obj.CentreDeMasse()) + obj.Tronc.momentInertieT(obj.CentreDeMasse()) + obj.JambeD.momentInertieT(obj.CentreDeMasse()) + obj.JambeG.momentInertieT(obj.CentreDeMasse()) + obj.BrasD.momentInertieT(obj.CentreDeMasse()) + obj.BrasG.momentInertieT(obj.CentreDeMasse()) + obj.Tete.momentInertieT(obj.CentreDeMasse());
        end
        
        function y = AccelerationAngulaire(obj, w)
            r = [0 obj.RayonTete obj.CMTete(3)]';
            F = [0 -200 0]';
            T = cross((r - obj.CentreDeMasse()'), F);
            L = obj.MomentInertie()*w;
            %Replace inv(A)*b with A\b
            y = obj.MomentInertie()\(T + cross(L, w));
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
