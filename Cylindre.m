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
        function obj = Cylindre(MasseVolumique, Rayon, Hauteur, x, y, z)
            obj.MasseVolumique = MasseVolumique;
            obj.Rayon = Rayon;
            obj.Hauteur = Hauteur;
            obj.Position = [x y z];
        end
    end
    
end

