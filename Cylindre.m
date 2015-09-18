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
        function obj = Cylindre(MasseVolumique, Rayon, Hauteur, x, y, z)
            obj.MasseVolumique = MasseVolumique;
            obj.Rayon = Rayon;
            obj.Hauteur = Hauteur;
            obj.Position = [x y z];
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
    end
    
end

