classdef Sphere
    %SPHERE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        MasseVolumique;
        Rayon;
        Position;
    end
    
    methods
        % Constructeur.
        function obj = Sphere(MasseVolumique, Rayon, pos)
            obj.MasseVolumique = MasseVolumique;
            obj.Rayon = Rayon;
            obj.Position = pos;
        end
        
        % Centre de masse de la sphere.
        function y = CentreDeMasse(obj)
            y = obj.Position;
        end
        
        % Masse de la sphere.
        function y = Masse(obj)
            y = obj.Volume() * obj.MasseVolumique;
        end
        
        % Volume de la sphere.
        function y = Volume(obj)
            y = pi * obj.Rayon^3 /4;
        end
        
        % Centre de masse pondere.
        function y = CentreP(obj)
            y = obj.CentreDeMasse() * obj.Masse();
        end
        
        % Moment d'Inertie  de la sphere par rapport a son propre centre de
        % masse
        function y = momentInertie(obj)
            y = [(2*obj.Masse()*obj.Rayon^2)/5 0 0; 0 (2*obj.Masse()*obj.Rayon^2)/5 0; 0 0 (2*obj.Masse()*obj.Rayon^2)/5];
        end
        
        % Moment d'inertie de la sphere par rapport a un autre centre de
        % masse situer a la position "vecteur"
        function y = momentInertieT(obj, vecteur)
            d = vecteur - obj.Position;
            y = obj.momentInertie() + obj.Masse()*[d(2)^2+d(3)^2 -d(1)*d(2) -d(1)*d(3); -d(2)*d(1) d(1)^2+d(3)^2 -d(2)*d(3); -d(3)*d(1) -d(3)*d(2) d(1)^2+d(2)^2];
        end
    end
    
end

