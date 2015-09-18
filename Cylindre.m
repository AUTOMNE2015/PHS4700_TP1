classdef Cylindre
    %CYLINDRE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        MasseVolumique;
        Rayon;
        Hauteur;
        Position;
    end
    
    methods
        % Constructeur.
        function obj = Cylindre(MasseVolumique, Rayon, Hauteur, position)
            obj.MasseVolumique = MasseVolumique;
            obj.Rayon = Rayon;
            obj.Hauteur = Hauteur;
            obj.Position = position;
        end
        
        % Centre de masse du cylindre.
        function y = CentreDeMasse(obj)
            y = obj.Position;
        end
        
        % Masse du cylindre.
        function y = Masse(obj)
            y = obj.Volume() * obj.MasseVolumique;
        end
        
        % Volume du cylindre.
        function y = Volume(obj)
            y = pi * obj.Rayon^2 * obj.Hauteur;
        end
        
        % Centre de masse pondere.
        function y = CentreP(obj)
            y = obj.CentreDeMasse() * obj.Masse();
        end
        
        % Moment d'Inertie du cylindre par rapport a son propre centre de
        % masse
        function y = momentInertie(obj)
            y = [(obj.Masse()*obj.Rayon^2)/4+(obj.Masse()*obj.Hauteur^2)/12 0 0; 0 (obj.Masse()*obj.Rayon^2)/4+(obj.Masse()*obj.Hauteur^2)/12 0; 0 0 obj.Masse()*obj.Rayon*obj.Rayon/2];
        end
        
        % Moment d'inertie du cylindre par rapport a un autre centre de
        % masse situer a la position "vecteur"
        function y = momentInertieT(obj, vecteur)
            d = vecteur - obj.Position;
            y = obj.momentInertie() + obj.Masse()*[d(2)^2+d(3)^2 -d(1)*d(2) -d(1)*d(3); -d(2)*d(1) d(1)^2+d(3)^2 -d(2)*d(3); -d(3)*d(1) -d(3)*d(2) d(1)^2+d(2)^2];
        end
    end
    
end

