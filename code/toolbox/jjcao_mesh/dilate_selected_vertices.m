function dv = dilate_selected_vertices(vid, vrings)
% vid: vertices id
color = zeros(length(vrings),1);
color(vid) = 1;
for i = 1:length(vid)
    ring = vrings{vid(i)};
    color(ring) = 1;
end
dv = find(color>0);
%function erode_selected_vertices()