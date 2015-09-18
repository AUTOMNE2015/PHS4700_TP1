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
    end
    
end

