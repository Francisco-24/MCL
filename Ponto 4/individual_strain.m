function strains_curvature = individual_strain(ABD_inverse, force_and_moments, espessura)

mid_plane = ABD_inverse*force_and_moments; %eq 3.51

%eqs 3.48

espsilon_x = mid_plane(1) + espessura/2*mid_plane(4);
espsilon_y = mid_plane(2) + espessura/2*mid_plane(5);
gama_xy = mid_plane(3) + espessura/2*mid_plane(6);

strains_curvature = [espsilon_x espsilon_y gama_xy];

end