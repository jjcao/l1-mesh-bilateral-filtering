function result = areas(vs,fs)
%for trianglar mesh only
a = cross(vs(fs(:,2),:) - vs(fs(:,1),:), vs(fs(:,3),:) - vs(fs(:,1),:),2);
result = sum(a.^2,2).^0.5.*0.5;
